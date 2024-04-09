#!/usr/bin/python3
"""
module to recurse a subreddit
"""
import requests


def recurse(subreddit, hot_list=[], after=None):
    """
    method to recurse a subreddit using reddit api pagination
    returns a list of hot posts titles
    """
    url = 'https://www.reddit.com/r/{}/hot.json'.format(subreddit)
    headers = {'User-Agent': 'Mozilla/5.0'}
    params = {"after": after}
    try:
        response = requests.get(url, headers=headers, allow_redirects=False,
                                params=params)
        if response.status_code == 200:
            data = response.json().get("data")
            after = data.get("after")
            for post in data.get("children"):
                hot_list.append(post.get("data").get("title"))
            if after is not None:
                return recurse(subreddit, hot_list, after)
            return hot_list
    except (KeyError, ValueError):
        return None

