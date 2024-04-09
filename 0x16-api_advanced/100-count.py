#!/usr/bin/python3
"""
100-count module
query reddit api and count given key words in titles
prints sorted count of key words
"""
import requests


def count_words(subreddit, word_list, after=None, word_dict={}):
    """
    recursive function that queries reddit api
    counts key words in titles of hot posts
    prints sorted count of key words in descending order and alphabetically
    if no result, prints nothing
    if no count, prints nothing for that word
    """
    url = 'https://www.reddit.com/r/{}/hot.json'.format(subreddit)
    headers = {'User-Agent': 'python3:100-count:v1.0.0 (by /u/000)'}
    # params = {'limit': 100, 'after': after}
    params = {'after': after}
    word_list = list(set(word.lower() for word in word_list))
    response = requests.get(url, headers=headers, params=params,
                            allow_redirects=False)
    if response.status_code != 200:
        return
    try:
        data = response.json().get('data')
        after = data.get('after')
        children = data.get('children')
        for post in children:
            title = post.get('data').get('title').lower().split()
            for word in word_list:
                if word in title:
                    if word in word_dict:
                        word_dict[word] += 1
                    else:
                        word_dict[word] = 1
        if after is not None:
            count_words(subreddit, word_list, after, word_dict)
    except (KeyError, ValueError):
        return
    if len(word_dict) == 0:
        return
    if after is None:
        for key, value in sorted(word_dict.items(),
                                    key=lambda x: (-x[1], x[0])):
            print('{}: {}'.format(key, value))
