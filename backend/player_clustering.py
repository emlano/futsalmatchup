# Import required libraries
import pandas as pd
import numpy as np
from sklearn.metrics import silhouette_score, davies_bouldin_score, calinski_harabasz_score
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
from scipy.stats import zscore
from scipy.spatial import distance

# Load the dataset
dataset = pd.read_csv("fifa_players.csv")

# Exploratory Data Analysis
# Explore the dataset
print(dataset.head())

# Explore the data columns
dataset.info()

# Get summary statistics
print(dataset.describe())

# Drop columns
columns_to_drop = ['full_name', 'birth_date', 'height_cm', 'weight_kgs', 'positions', 'potential', 'value_euro', 'wage_euro', 'preferred_foot', 'international_reputation(1-5)', 'weak_foot(1-5)', 'skill_moves(1-5)', 'body_type', 'release_clause_euro', 'national_team', 'national_rating', 'national_team_position', 'national_jersey_number', 'crossing', 'finishing', 'heading_accuracy', 'short_passing', 'volleys', 'dribbling', 'curve', 'freekick_accuracy', 'long_passing', 'ball_control', 'acceleration', 'sprint_speed', 'agility', 'reactions', 'balance', 'shot_power', 'jumping', 'stamina', 'strength', 'long_shots', 'aggression', 'interceptions', 'positioning', 'vision', 'penalties', 'composure', 'marking', 'standing_tackle', 'sliding_tackle']
dataset = dataset.drop(columns=columns_to_drop)

# # Visualization of data
# # Histogram
# dataset.hist(figsize=(10, 6))
# plt.show()
#
# # Box plot
# dataset.boxplot(figsize=(10, 6))
# plt.show()
#
# # Scatter plot
# plt.scatter(dataset['age'], dataset['overall_rating'])
# plt.xlabel('Age')
# plt.ylabel('Overall Rating')
# plt.title('Age vs Overall Rating')
# plt.show()

# Select relevant features
features = ['age', 'overall_rating']

# Data preparation for clustering
# Handle missing values
# Drop rows with missing values in selected features
X = dataset[features].dropna()
X.info()
print(X)

# Feature scaling
# z-score Normalization for numerical features
X_normalized = X.apply(zscore)
print(X_normalized)

# Find optimal k value
# Elbow method
inertia_values = []
k_values = range(2, 11)  # trying k from 2 to 10
for k in k_values:
    kmeans = KMeans(n_clusters=k, random_state=42)
    kmeans.fit(X_normalized)
    inertia_values.append(kmeans.inertia_)

# Silhouette method
silhouette_scores = []
for k in k_values:
    kmeans = KMeans(n_clusters=k, random_state=42)
    kmeans.fit(X_normalized)
    score = silhouette_score(X_normalized, kmeans.labels_)
    silhouette_scores.append(score)

optimal_k_silhouette = k_values[np.argmax(silhouette_scores)]
# Inertia
# Gap statistics

# Davies-Bouldin
davies_bouldin_scores = []
for k in k_values:
    kmeans = KMeans(n_clusters=k, random_state=42)
    kmeans.fit(X_normalized)
    score = davies_bouldin_score(X_normalized, kmeans.labels_)
    davies_bouldin_scores.append(score)

# Calinski-Harabasz
calinski_harabasz_scores = []
for k in k_values:
    kmeans = KMeans(n_clusters=k, random_state=42)
    kmeans.fit(X_normalized)
    score = calinski_harabasz_score(X_normalized, kmeans.labels_)
    calinski_harabasz_scores.append(score)

# # Plot graphs for each method
# plt.figure(figsize=(15, 10))
#
# plt.subplot(2, 2, 1)
# plt.plot(k_values, inertia_values, marker='o')
# plt.title('Inertia vs Number of Clusters')
# plt.xlabel('Number of Clusters (k)')
# plt.ylabel('Inertia')
#
# plt.subplot(2, 2, 2)
# plt.plot(k_values, silhouette_scores, marker='o')
# plt.title('Silhouette Score vs Number of Clusters')
# plt.xlabel('Number of Clusters (k)')
# plt.ylabel('Silhouette Score')
#
# plt.subplot(2, 2, 3)
# plt.plot(k_values, davies_bouldin_scores, marker='o')
# plt.title('Davies-Bouldin Score vs Number of Clusters')
# plt.xlabel('Number of Clusters (k)')
# plt.ylabel('Davies-Bouldin Score')
#
# plt.subplot(2, 2, 4)
# plt.plot(k_values, calinski_harabasz_scores, marker='o')
# plt.title('Calinski-Harabasz Score vs Number of Clusters')
# plt.xlabel('Number of Clusters (k)')
# plt.ylabel('Calinski-Harabasz Score')
#
# plt.tight_layout()
# plt.show()

# Inspection of the clusters and their centroids


# plt.scatter(X_normalized['age'], X_normalized['overall_rating'], c=kmeans_elbow.labels_, cmap='viridis')
# plt.scatter(kmeans_elbow.cluster_centers_[:, 0], kmeans_elbow.cluster_centers_[:, 1], marker='x', s=100, c='red')
# plt.xlabel('Age')
# plt.ylabel('Overall Rating')
# plt.title('KMeans Clustering with Elbow Method (k=3)')
# plt.show()

# # Create a table of methods and corresponding k values
# methods = ['Silhouette Method', 'Davies-Bouldin Score', 'Calinski-Harabasz Score']
# k_values = [k_values[np.argmax(silhouette_scores)], k_values[np.argmin(davies_bouldin_scores)], k_values[np.argmax(calinski_harabasz_scores)]]
#
# table = pd.DataFrame({'Method': methods, 'Optimal k': k_values})
# print(table)

# Fit KMeans clustering with optimal k value
kmeans = KMeans(n_clusters=optimal_k_silhouette, random_state=42)
kmeans.fit(X_normalized)

# Evaluation of the model
# Test the model accuracy using testing metrics from the 30% chosen
# Predict cluster labels for the test data
kmeans_labels = kmeans.predict(X_normalized)

# Evaluation metrics for testing
# Silhouette Score
silhouette_test = silhouette_score(X_normalized, kmeans_labels)
print(f"Silhouette Score on Test Data: {silhouette_test}")

# Davies-Bouldin Score
davies_bouldin_test = davies_bouldin_score(X_normalized, kmeans_labels)
print(f"Davies-Bouldin Score on Test Data: {davies_bouldin_test}")

# Calinski-Harabasz Score
calinski_harabasz_test = calinski_harabasz_score(X_normalized, kmeans_labels)
print(f"Calinski-Harabasz Score on Test Data: {calinski_harabasz_test}")

# Testing with user inputs
# Get input from the console
input_age = float(input("Enter your age: "))
input_rating = float(input("Enter your overall rating: "))
input_nationality = input("Enter your location: ")

# Calculate the Euclidean distance to each cluster center
input_data = [input_age, input_rating]
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

# Display sorted recommendations
print("Recommended players from the same nationality:")
print(nearest_cluster_players_sorted[['name', 'age', 'overall_rating', 'nationality']].head(10))
