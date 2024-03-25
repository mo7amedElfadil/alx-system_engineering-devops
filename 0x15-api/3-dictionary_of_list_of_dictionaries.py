#!/usr/bin/python3
"""
using a REST API, for a given employee ID, returns information
about his/her TODO list progress.
"""
from json import dump
import requests


def get_all_employee_data():
    """
    get the employee's data
    """
    responses = {'users': None, 'todos': None}
    url = 'https://jsonplaceholder.typicode.com/{res_key}'
    for res_key in responses.keys():
        response = requests.get(url.format(res_key=res_key))
        if response.status_code == 200:
            responses[res_key] = response.json()
    return responses


def format_employee_data(responses):
    """
    format the epmloyee's data
    Format must be:
    {
    "USER_ID": [ {"username": "USERNAME",
    "task": "TASK_TITLE", "completed": TASK_COMPLETED_STATUS},
    {"username": "USERNAME", "task": "TASK_TITLE",
    "completed": TASK_COMPLETED_STATUS}, ... ],
    "USER_ID": [ {"username": "USERNAME", "task": "TASK_TITLE",
    "completed": TASK_COMPLETED_STATUS}, {"username": "USERNAME",
    "task": "TASK_TITLE", "completed": TASK_COMPLETED_STATUS}, ... ]
    }
    """
    output = {}
    for user in responses['users']:
        user_id = user['id']
        username = user['username']

        for task in responses['todos']:
            if task.get('userId') == user_id:
                task_title = task['title']
                completed = task['completed']
                if user_id not in output:
                    output[user_id] = []
                output[user_id].append({'username': username,
                                        'task': task_title,
                                        'completed': completed})
    return output


def export_dict_to_json(formatted_data):
    """
    export all employee data to JSON
    File name must be: todo_all_employees.json
    """
    with open(f"todo_all_employees.json", 'w') as f:
        dump(formatted_data, f)


if __name__ == "__main__":
    responses = get_all_employee_data()
    formatted_data = format_employee_data(responses)
    export_dict_to_json(formatted_data)
