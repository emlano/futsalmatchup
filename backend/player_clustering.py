# Import required libraries
import pandas as pd
import numpy as np
from sklearn.metrics import silhouette_score
from sklearn.model_selection import train_test_split
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt

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

# Visualization of data
# Histogram
dataset.hist(figsize=(10, 6))
plt.show()

# Box plot
dataset.boxplot(figsize=(10, 6))
plt.show()

# Scatter plot
plt.scatter(dataset['age'], dataset['overall_rating'])
plt.xlabel('Age')
plt.ylabel('Overall Rating')
plt.title('Age vs Overall Rating')
plt.show()

# Select relevant features
features = ['age', 'overall_rating']

# Data preparation for clustering
# Handle missing values
# Drop rows with missing values in selected features
X = dataset[features].dropna()
X.info()
print(X)

# Split the dataset as 70:30 to train and test the model
X_train, X_test = train_test_split(X, test_size=0.3)

print(X_train.head())
print(X_test.head())

# Train the model using KMeans clustering for the 70% chosen
inertia_values = []
k_values = range(1, 11)

# KMeans clustering
for k in k_values:
    kmeans = KMeans(n_clusters=k) # Choose the value of k
    kmeans.fit(X_train)
    inertia_values.append(kmeans.inertia_)

# Choose the value of k

# Elbow plot
plt.plot(k_values, inertia_values, marker=".")
plt.xlabel('Number of clusters')
plt.ylabel('Inertia value')
plt.title('Elbow curve')
plt.show()

optimal_k = 4
kmeans = KMeans(n_clusters=optimal_k)
kmeans.fit(X_train)
# Test the model accuracy with the testing metrics from the 30% chosen

# Predict cluster labels for a value in the test data
kmeans_predict_test = kmeans.predict(X_test)
print(kmeans_predict_test)

# Check output
silhouette_avg = silhouette_score(X_test, kmeans_predict_test)
print("Silhouette score: ", silhouette_avg)

inertia = kmeans.inertia_
print("Inertia: ", inertia)

# Plot the clusters
plt.scatter(X_train['age'], X_train['overall_rating'], c=kmeans.labels_, cmap='viridis')
plt.xlabel('Age')
plt.ylabel('Overall Rating')
plt.title('K Means Clustering - Futsal MatchUp')
plt.show()