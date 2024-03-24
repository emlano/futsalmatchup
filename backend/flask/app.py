from flask import Flask, request, jsonify
import numpy as np
from sklearn.cluster import KMeans
from scipy.stats import zscore
from scipy.spatial import distance
from sklearn.metrics import silhouette_score
import traceback
import requests

# Initialize Flask application
app = Flask(__name__)

# Functions for recommendation
def prepare_data(dataset, features):
    """Prepare the data for clustering."""
    X = np.array([[player[features[0]], player[features[1]]] for player in dataset]) # Extract required features from dataset
    X_normalized = zscore(X) # Normalize the selected features
    return X_normalized

def find_optimal_k(X_normalized, k_values):
    """Find the optimal number of clusters."""
    silhouette_scores = []

    # Calculate silhouette scores for different values of k
    for k in k_values:
        kmeans = KMeans(n_clusters=k, random_state=42)
        kmeans.fit(X_normalized)
        score = silhouette_score(X_normalized, kmeans.labels_)
        silhouette_scores.append(score)

    optimal_k_silhouette = k_values[np.argmax(silhouette_scores)] # Choose the k value with the highest silhouette score
    return optimal_k_silhouette

def fit_kmeans(X_normalized, optimal_k):
    """Fit KMeans clustering with the optimal number of clusters."""
    kmeans = KMeans(n_clusters=optimal_k, random_state=42)
    kmeans.fit(X_normalized)
    return kmeans

def recommend_players(kmeans, dataset, input_data, input_nationality):
    """Recommend players based on input data and nationality."""

    # Calculate distances from input data to cluster centers using euclidean distance
    distances = distance.cdist([input_data], kmeans.cluster_centers_, 'euclidean')
    nearest_cluster_index = distances.argmin()

    # Filter players from the nearest cluster and with the same nationality
    nearest_cluster_players = [player for player in dataset if kmeans.labels_[dataset.index(player)] == nearest_cluster_index and player['player_city'] == input_nationality]

    # Sort players based on their distance from the input data
    nearest_cluster_players_sorted = sorted(nearest_cluster_players, key=lambda player: distance.euclidean(input_data, [player['age'], player['player_overall_rating']]))
    return nearest_cluster_players_sorted[:5]

# Flask route for recommending players
@app.route('/recommend', methods=['POST'])
def recommend_players_route():
    try:
        # Extract player data from the request
        body = request.json[0]
        input_age = body['age']
        input_rating = body['player_overall_rating']
        input_nationality = body['player_city']
        input_data = np.array([input_age, input_rating], dtype=np.float64)

        # Extract all players' data from the request
        dataset = request.json[1:]
        # print(dataset)

        # Prepare data for clustering
        features = ['age', 'player_overall_rating']
        X_normalized = prepare_data(dataset, features)

        # Find the optimal number of clusters
        k_values = range(2, 11)
        optimal_k = find_optimal_k(X_normalized, k_values)

        # Fit KMeans clustering
        kmeans = fit_kmeans(X_normalized, optimal_k)

        # Recommend players based on input data
        recommended_players = recommend_players(kmeans, dataset, input_data, input_nationality)

        # Convert recommended players to JSON format
        recommended_players_json = jsonify(recommended_players)

        # Return recommended players as JSON response
        return recommended_players_json

    except Exception as e:
        # Handle exceptions and return error message
        traceback.print_exc()
        return jsonify({'error': str(e)}), 500

# # Function to fetch players from the database
# def fetch_players_from_database():
#     # Make a request to the Node server to fetch player data from the database
#     response = requests.get('http://localhost:3000/users')
#     if response.status_code == 200:
#         dataset = response.json()
#         return dataset
#     else:
#         return None

if __name__ == '__main__':
    app.run(debug=True, port=8080) # Run the Flask application