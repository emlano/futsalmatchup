from flask import Flask, request, jsonify
import pandas as pd
import numpy as np
from sklearn.cluster import KMeans
from scipy.stats import zscore
from scipy.spatial import distance
from sklearn.metrics import silhouette_score

app = Flask(__name__)

# Functions for recommendation
def load_dataset(file_path):
    """Load the dataset from a CSV file."""
    return pd.read_csv(file_path)

def drop_columns(dataset):
    """Drop irrelevant columns from the dataset."""
    columns_to_drop = ['full_name', 'birth_date', 'height_cm', 'weight_kgs', 'positions', 'potential', 'value_euro',
                       'wage_euro', 'preferred_foot', 'international_reputation(1-5)', 'weak_foot(1-5)',
                       'skill_moves(1-5)', 'body_type', 'release_clause_euro', 'national_team', 'national_rating',
                       'national_team_position', 'national_jersey_number', 'crossing', 'finishing', 'heading_accuracy',
                       'short_passing', 'volleys', 'dribbling', 'curve', 'freekick_accuracy', 'long_passing',
                       'ball_control', 'acceleration', 'sprint_speed', 'agility', 'reactions', 'balance', 'shot_power',
                       'jumping', 'stamina', 'strength', 'long_shots', 'aggression', 'interceptions', 'positioning',
                       'vision', 'penalties', 'composure', 'marking', 'standing_tackle', 'sliding_tackle']
    return dataset.drop(columns=columns_to_drop, errors='ignore')

def prepare_data(dataset, features):
    """Prepare the data for clustering."""
    X = dataset[features].dropna()
    X_normalized = X.apply(zscore)
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

def recommend_players(kmeans, dataset, input_data, input_nationality, features):
    """Recommend players based on input data and nationality."""
    distances = distance.cdist([input_data], kmeans.cluster_centers_, 'euclidean')

    # Get the nearest cluster index
    nearest_cluster_index = distances.argmin()

    # Get indices of players within the nearest cluster and with the same nationality
    nearest_cluster_indices = np.where((kmeans.labels_ == nearest_cluster_index))[0]
    nationality_indices = np.where(dataset['nationality'] == input_nationality)[0]
    common_indices = np.intersect1d(nearest_cluster_indices, nationality_indices)

    # Get recommended players
    nearest_cluster_players = dataset.iloc[common_indices]

    # Calculate the Euclidean distance for each player in the nearest cluster
    nearest_cluster_players['distance'] = nearest_cluster_players.apply(
        lambda row: distance.euclidean(input_data, [row[feature] for feature in features]), axis=1)

    # Sort recommended players by distance (ascending order)
    nearest_cluster_players_sorted = nearest_cluster_players.sort_values(by='distance')

    # Return sorted recommendations
    return nearest_cluster_players_sorted[['name', 'age', 'overall_rating', 'nationality']].head(10)

# Initialize variables and load data
file_path = "fifa_players.csv"
dataset = load_dataset(file_path)
dataset = drop_columns(dataset)
features = ['age', 'overall_rating']
X_normalized = prepare_data(dataset, features)
k_values = range(2, 11)
optimal_k = find_optimal_k(X_normalized, k_values)
kmeans = fit_kmeans(X_normalized, optimal_k)

# Flask route for recommending players
@app.route('/recommend_players', methods=['GET'])
def recommend_players_route():
    # Get player data from the node server
    player_data = request.json
    input_age = player_data['age']
    input_rating = player_data['rating']
    input_nationality = player_data['location']
    input_data = [input_age, input_rating]

    # Recommend players based on input data
    recommended_players = recommend_players(kmeans, dataset, input_data, input_nationality, features)

    # Convert recommended players to JSON format
    recommended_players_json = recommended_players.to_json(orient='records')

    # Return recommended players as JSON response
    return jsonify(recommended_players_json)

if __name__ == '__main__':
    app.run(debug=True, port=8080)