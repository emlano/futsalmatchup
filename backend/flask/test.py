import unittest
from app import *

class TestRecommendationSystem(unittest.TestCase):

    def setUp(self): # Setting up the testing environment
        app.config['TESTING'] = True
        self.app = app.test_client()

    def test_recommendation_endpoint(self):
        # Test the recommendation endpoint with valid input
        data = [
            {
                "age": 25,
                "player_overall_rating": 85,
                "player_city": "Barcelona"
            },
            {
                "age": 28,
                "player_overall_rating": 82,
                "player_city": "Barcelona"
            },
            {
                "age": 24,
                "player_overall_rating": 87,
                "player_city": "Madrid"
            },
            {
                "age": 30,
                "player_overall_rating": 80,
                "player_city": "Madrid"
            },
            {
                "age": 27,
                "player_overall_rating": 83,
                "player_city": "Barcelona"
            }
        ]
        response = self.app.post('/recommend', json=data)
        self.assertEqual(len(response.json), 1) # Asserting that the response contains recommendations

    def test_invalid_input(self):
        # Test the recommendation endpoint with invalid input or missing data
        data = {}
        response = self.app.post('/recommend', json=data)
        self.assertEqual(response.status_code, 500) # Asserting that the response status code is 500 (Internal Server Error)

    def test_empty_dataset(self):
        # Test the recommendation endpoint with empty dataset
        data = [
            {
                "age": 25,
                "player_overall_rating": 85,
                "player_city": "Paris"
            }
        ]
        response = self.app.post('/recommend', json=data)
        self.assertEqual(response.status_code, 500) # Asserting that the response status code is 500 (Internal Server Error)

if __name__ == '__main__':
    unittest.main()
