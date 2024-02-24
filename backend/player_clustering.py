import pandas as pd
import numpy as np

# Load the dataset
dataset = pd.read_csv("fifa_players.csv")

# Rename the "Nationality" column name as "Location"
#dataset.rename(columns={"nationality": "location"}, inplace=True)

# Check for missing values
missing_values = dataset[['age', 'overall_rating', 'nationality']].isnull().sum()

# Determine the min, max, mean median of the columns with numerical values
min_age = dataset['age'].min()
max_age = dataset['age'].max()
median_age = dataset['age'].median()
mean_age = dataset['age'].mean()

min_rating = dataset['overall_rating'].min()
max_rating = dataset['overall_rating'].max()
median_rating = dataset['overall_rating'].median()
mean_rating = dataset['overall_rating'].mean()

# print(min_age, max_age, median_age, mean_age)
# print(min_rating, max_rating, median_rating, mean_rating)

# if there are any missing values handle missing values
if missing_values.any():
    # Dropping values
    dataset = dataset.dropna(inplace=True)
    # Assigning the mean
    # dataset = dataset.fillna(dataset.mean(), inplace=True)
    # Assigning the median
    # dataset = dataset.fillna(dataset.median(), inplace=True)

# Split the dataset as 70:30 to train and test the model

# Train the model using KMeans clustering for the 70% chosen

# Plot the clusters

# Choose the value of k

# Test the model accuracy with the testing metrics from the 30% chosen