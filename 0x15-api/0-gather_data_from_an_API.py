#!/usr/bin/python3
"""
using a REST API, for a given employee ID, returns information
about his/her TODO list progress.
"""
import requests
from sys import argv


def get_employee_data(employee_id):
    """
    get the employee's data
    """
    resources = {'users': 'id=', 'todos': 'userId='}
    url = 'https://jsonplaceholder.typicode.com/{r_key}?{r_val}{employee_id}'
    responses = {}
    for r_key, r_val in resources.items():
        response = requests.get(url.format(
            r_key=r_key, r_val=r_val, employee_id=employee_id))

        if response.status_code == 200:
            responses[r_key] = response.json()
    return responses


def print_employee_todo(responses):
    """
    print formatted todos
    """
    if not responses:
        return
    EMPLOYEE_NAME = responses['users'][0]['name']
    COMPLETED_TASKS = [task for task in responses['todos']
                       if task['completed']]
    NUMBER_OF_DONE_TASKS = len(COMPLETED_TASKS)
    TOTAL_NUMBER_OF_TASKS = len(responses['todos'])
    print("Employee {} is done with tasks({}/{}):".format(EMPLOYEE_NAME,
          NUMBER_OF_DONE_TASKS, TOTAL_NUMBER_OF_TASKS))
    for TASK in COMPLETED_TASKS:
        print('\t {}'.format(TASK['title']))


if __name__ == "__main__":
    if len(argv) > 1:
        print_employee_todo(get_employee_data(argv[1]))
