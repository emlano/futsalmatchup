import pandas as pd
import numpy as np

# Load the dataset
dataset = pd.read_csv("fifa_players.csv")

# Rename the "Nationality" column name as "Location"
dataset.rename(columns={"nationality": "location"}, inplace=True)

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

#if missing_values.any()
    # Handle missing values
