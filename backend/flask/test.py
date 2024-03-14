# Import required libraries
import unittest

# Importing functions from the clustering module
from clustering import *

class TestPlayerRecommendation(unittest.TestCase):

    def setUp(self):
        # Setting up a sample DataFrame for testing
        self.dataset = pd.DataFrame({
            'name': ['Player1', 'Player2', 'Player3'],
            'age': [25, 30, 28],
            'overall_rating': [85, 90, 88],
            'nationality': ['England', 'France', 'Spain']
        })

    def test_load_dataset(self):
        # Test loading dataset
        file_path = "fifa_players.csv"
        data = load_dataset(file_path) # Call the load_dataset function

        # Check if the returned object is a DataFrame
        self.assertIsInstance(data, pd.DataFrame)

    def test_drop_columns(self):
        # Call the function with the sample DataFrame
        processed_df = drop_columns(self.dataset) # Call the drop_columns function

        # Define the expected columns after dropping
        expected_columns = ['name', 'age', 'overall_rating', 'nationality']

        # Check if the columns of the processed DataFrame match the expected columns
        self.assertListEqual(list(processed_df.columns), expected_columns)

    def test_prepare_data(self):
        # Test preparing data
        features = ['age', 'overall_rating']
        prepared_data = prepare_data(self.dataset, features) # Call the prepare_data function

        # Check if the returned object is a DataFrame
        self.assertIsInstance(prepared_data, pd.DataFrame)

        # Check if the number of columns matches the number of features
        self.assertEqual(prepared_data.shape[1], len(features))

    def test_find_optimal_k(self):
        # Test finding optimal k
        X_normalized = pd.DataFrame(np.random.rand(100, 2), columns=['age', 'overall_rating'])
        k_values = range(2, 11)
        optimal_k = find_optimal_k(X_normalized, k_values) # Call the find_optimal_k function

        # Check if the optimal k is within the specified range of k_values
        self.assertIn(optimal_k, k_values)

    def test_fit_kmeans(self):
        # Test fitting KMeans
        X_normalized = pd.DataFrame(np.random.rand(100, 2), columns=['age', 'overall_rating'])
        optimal_k = 3  # Define optimal_k
        kmeans = fit_kmeans(X_normalized, optimal_k) # Call the fit_kmeans function

        # Check if the returned object is an instance of KMeans
        self.assertIsInstance(kmeans, KMeans)

