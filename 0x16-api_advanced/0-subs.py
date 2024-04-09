#!/usr/bin/python3
"""
Module for number_of_subscribers function
"""
import requests


def number_of_subscribers(subreddit):
    """
    Queries the Reddit API and returns the number of subscribers
    for a given subreddit. If an invalid subreddit is given,
    the function should return 0.
    """
    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)
    try:
        response = requests.get(url, headers={"User-Agent": "mo7amed/1.0"})
        if response.status_code == 200:
            result = response.json()["data"]["subscribers"]
            return result
    except (KeyError, ValueError):
        return 0
    return 0
