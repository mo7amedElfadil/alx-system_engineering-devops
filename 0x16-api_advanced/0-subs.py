import logging
import platform

import requests
import ssl

class MyHTTPAdapter(requests.adapters.HTTPAdapter):
    def init_poolmanager(self, connections, maxsize, block=False):
        self.poolmanager = requests.packages.urllib3.poolmanager.PoolManager(
            num_pools=connections,
            maxsize=maxsize,
            block=block,
            ssl_version=ssl.PROTOCOL_TLSv1_2,
        )

try:
    import http.client
except ImportError:
    import httplib
    httplib.HTTPConnection.debuglevel = 1
else:
    http.client.HTTPConnection.debuglevel = 1

logging.basicConfig()
logging.getLogger().setLevel(logging.DEBUG)
requests_log = logging.getLogger("requests.packages.urllib3")
requests_log.setLevel(logging.DEBUG)
requests_log.propagate = True


def number_of_subscribers(subreddit):
    """
    Queries the Reddit API and returns the number of subscribers
    for a given subreddit. If an invalid subreddit is given,
    the function should return 0.
    """
    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)
    headers = {'User-Agent': 'python3:1-subs:v1.0.0 (by /u/000)'}
    try:
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            result = response.json().get("data").get("subscribers")
            return result
    except (KeyError, ValueError):
        return 0
    return 0
