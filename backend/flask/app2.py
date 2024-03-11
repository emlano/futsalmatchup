from flask import Flask, request, jsonify
import numpy as np
from sklearn.cluster import KMeans
from scipy.stats import zscore
from scipy.spatial import distance
from sklearn.metrics import silhouette_score
import requests

app = Flask(__name__)

# Functions for recommendation
def prepare_data(dataset, features):
    """Prepare the data for clustering."""
    X = np.array([[player.age, player.overall_rating] for player in dataset])
    X_normalized = zscore(X)
    return X_normalized

def find_optimal_k(X_normalized, k_values):
    """Find the optimal number of clusters."""
    silhouette_scores = []
    for k in k_values:
        kmeans = KMeans(n_clusters=k, random_state=42)
        kmeans.fit(X_normalized)
        score = silhouette_score(X_normalized, kmeans.labels_)
        silhouette_scores.append(score)
    optimal_k_silhouette = k_values[np.argmax(silhouette_scores)]
    return optimal_k_silhouette

def fit_kmeans(X_normalized, optimal_k):
    """Fit KMeans clustering with the optimal number of clusters."""
    kmeans = KMeans(n_clusters=optimal_k, random_state=42)
    kmeans.fit(X_normalized)
    return kmeans

def recommend_players(kmeans, dataset, input_data, input_nationality):
    """Recommend players based on input data and nationality."""
    distances = distance.cdist([input_data], kmeans.cluster_centers_, 'euclidean')
    nearest_cluster_index = distances.argmin()
    nearest_cluster_players = [player for player in dataset if kmeans.labels_[dataset.index(player)] == nearest_cluster_index and player.nationality == input_nationality]
    nearest_cluster_players_sorted = sorted(nearest_cluster_players, key=lambda player: distance.euclidean(input_data, [player.age, player.overall_rating]))
    return nearest_cluster_players_sorted[:10]

# Flask route for recommending players
@app.route('/recommend_players', methods=['POST'])
def recommend_players_route():
    # Get player data from the node server
    input_age = request.json['age']
    input_rating = request.json['rating']
    input_nationality = request.json['location']
    input_data = [input_age, input_rating]

    # Assuming you have a function to retrieve all players from the database
    dataset = fetch_players_from_database()

    # Prepare data for clustering
    features = ['age', 'overall_rating']
    X_normalized = prepare_data(dataset, features)

    # Fit KMeans clustering
    k_values = range(2, 11)
    optimal_k = find_optimal_k(X_normalized, k_values)
    kmeans = fit_kmeans(X_normalized, optimal_k)

    # Recommend players based on input data
    recommended_players = recommend_players(kmeans, dataset, input_data, input_nationality)

    # Convert recommended players to JSON format
    recommended_players_json = jsonify([player.serialize() for player in recommended_players])

    # Return recommended players as JSON response
    return recommended_players_json

# Function to fetch players from the database
def fetch_players_from_database():
    # Make a request to the Node server to fetch player data from the database
    response = requests.get('localhost:3000/users')
    if response.status_code == 200:
        dataset = response.json()
        return dataset
    else:
        return None

if __name__ == '__main__':
    app.run(debug=True, port=8080)