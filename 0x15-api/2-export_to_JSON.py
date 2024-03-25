#!/usr/bin/python3
"""
using a REST API, for a given employee ID, returns information
about his/her TODO list progress.
"""
from json import dump
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
                                r_key=r_key, r_val=r_val,
                                employee_id=employee_id))
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
    NUMBER_OF_DONE_TASKS = sum(1 for task in responses['todos']
                               if task['completed'])
    TOTAL_NUMBER_OF_TASKS = len(responses['todos'])
    print("Employee {} is done with tasks({}/{})".format(EMPLOYEE_NAME,
          NUMBER_OF_DONE_TASKS, TOTAL_NUMBER_OF_TASKS))
    for TASK in responses['todos']:
        print('\t {}'.format(TASK['title']))


def export_dict_to_json(responses):
    """
    export the employee's data to JSON
    Records all tasks that are owned by this employee
   Format must be: { "USER_ID": [{"task": "TASK_TITLE",
   "completed": TASK_COMPLETED_STATUS, "username": "USERNAME"},
   {"task": "TASK_TITLE", "completed": TASK_COMPLETED_STATUS,
   "username": "USERNAME"}, ... ]}
    File name must be: USER_ID.json
    """
    user_id = responses['users'][0]['id']
    username = responses['users'][0]['username']
    combined_data = {user_id: [{'task': task['title'],
                                'completed': task['completed'],
                                'username': username}
                               for task in responses['todos']]}
    with open(f"{user_id}.json", 'w') as f:
        dump(combined_data, f)


if __name__ == "__main__":
    if len(argv) > 1:
        export_dict_to_json(get_employee_data(argv[1]))
