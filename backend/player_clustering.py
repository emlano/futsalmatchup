# Import required libraries
import pandas as pd
import numpy as np
from sklearn.metrics import silhouette_score, davies_bouldin_score, calinski_harabasz_score
from sklearn.model_selection import train_test_split
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
from scipy.stats import zscore

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

# Feature scaling
# z-score Normalization for numerical features
X_normalized = X.apply(zscore)
print(X_normalized)

# Model creation and training
# Split the dataset into train and test sets (70:30 split)
X_train, X_test = train_test_split(X_normalized, test_size=0.3)
print(X_train)
print(X_test)

# Find optimal k value
# Elbow method
inertia_values = []
k_values = range(2, 11)  # trying k from 2 to 10
for k in k_values:
    kmeans = KMeans(n_clusters=k, random_state=42)
    kmeans.fit(X_train)
    inertia_values.append(kmeans.inertia_)

# Silhouette method
silhouette_scores = []
for k in k_values:
    kmeans = KMeans(n_clusters=k, random_state=42)
    kmeans.fit(X_train)
    score = silhouette_score(X_train, kmeans.labels_)
    silhouette_scores.append(score)

# Inertia
# Gap statistics

# Davies-Bouldin
davies_bouldin_scores = []
for k in k_values:
    kmeans = KMeans(n_clusters=k, random_state=42)
    kmeans.fit(X_train)
    score = davies_bouldin_score(X_train, kmeans.labels_)
    davies_bouldin_scores.append(score)

# Calinski-Harabasz
calinski_harabasz_scores = []
for k in k_values:
    kmeans = KMeans(n_clusters=k, random_state=42)
    kmeans.fit(X_train)
    score = calinski_harabasz_score(X_train, kmeans.labels_)
    calinski_harabasz_scores.append(score)