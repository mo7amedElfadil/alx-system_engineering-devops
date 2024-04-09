#!/usr/bin/python3
"""Top Ten module
"""
import requests


def top_ten(subreddit):
    """
    queries the Reddit API and prints the titles of the first 10 hot posts
    listed for a given subreddit.
    """
    url = "https://www.reddit.com/r/{}/hot.json?limit=10".format(subreddit)
    response = requests.get(url, headers={"User-Agent": "mo7amed/1.0"})
    try:
        response = requests.get(url, headers={"User-Agent": "mo7amed/1.0"})
        if response.status_code == 200:
            for post in response.json().get("data").get("children"):
                print(post.get("data").get("title"))
            return
    except (KeyError, ValueError):
        print(None)
        return
    print(None)
