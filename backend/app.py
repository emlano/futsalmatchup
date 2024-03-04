# Import required libraries
from flask import Flask, request, jsonify

# Importing functions from the clustering module
from clustering import *

app = Flask(__name__)

# Define Flask route to handle recommendation requests
@app.route('/recommend', methods=['POST'])
def recommend():
    # Receive input data from the request
    input_data = request.json.get('input_data')
    input_nationality = request.json.get('input_nationality')

    # Perform recommendation based on input data
    recommended_players = recommend_players(kmeans, dataset, input_data, input_nationality, features)

    # Convert recommended players to JSON format and return as response
    return jsonify(recommended_players.to_dict(orient='records'))

if __name__ == '__main__':
    # File path to the dataset
    file_path = "fifa_players.csv"

    # Load dataset from the CSV file
    dataset = load_dataset(file_path)

    # Drop irrelevant columns from the dataset
    dataset = drop_columns(dataset)

    # Selected features for clustering
    features = ['age', 'overall_rating']

    # Prepare data for clustering
    X_normalized = prepare_data(dataset, features)

    # Range of K values to try for finding the optimal K
    k_values = range(2, 11)
    optimal_k = find_optimal_k(X_normalized, k_values)
    kmeans = fit_kmeans(X_normalized, optimal_k) # Fit KMeans clustering with the optimal number of clusters

    # Run Flask app
    app.run(debug=True)
