#!/usr/bin/env python3
import datetime
import os
import requests
from rich.console import Console
from rich.tree import Tree
import argparse

console = Console()

now = datetime.datetime.now()
formatted_date = now.strftime(
    "%d%b") + f"({now.isocalendar()[1]}-{now.isoweekday()})." + now.strftime("%y")

BOT_TOKEN = 'BOTTOKEN'
CHAT_ID = 'CHATID'

# Store message IDs
sent_message_ids = []


def read_tasks(filepath):
    tasks_undone = []
    tasks_done = []
    with open(filepath, "r", encoding='utf-8') as file:
        for row in file:
            if len(row) > 1:
                if row.startswith("- [ ]"):
                    tasks_undone.append(row.lstrip("- [ ]").rstrip("\n"))
                elif row.startswith("- [X]"):
                    tasks_done.append(row.lstrip("- [X]").rstrip("\n"))
    return tasks_undone, tasks_done


def print_tasks_tree(title, tasks, icon, color):
    tree = Tree(f"[bold {color}]{title}[/bold {color}]")
    for i, task in enumerate(tasks):
        tree.add(f"{i+1} {icon} [bold {color}]{task}[/bold {color}]")
    console.print(tree)


def mark_task_done(filepath, tasks, lines, task_number):
    newline = f"- [X] {tasks[task_number - 1]}"
    console.print(
        f"\n[bold green]Marking task as done: {newline}[/bold green]\n")

    with open(filepath, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    lines = [newline + "\n" if tasks[task_number - 1]
             in line else line for line in lines]

    with open(filepath, 'w', encoding='utf-8') as file:
        file.writelines(lines)


def mark_task_undone(filepath, tasks, lines, task_number):
    newline = f"- [ ] {tasks[task_number - 1]}"
    console.print(
        f"\n[bold yellow]Marking task as undone: {newline}[/bold yellow]\n")

    with open(filepath, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    lines = [newline + "\n" if tasks[task_number - 1]
             in line else line for line in lines]

    with open(filepath, 'w', encoding='utf-8') as file:
        file.writelines(lines)


def actions(filepath, tasks_undone, tasks_done, lines):
    task_type = input(
        "\nMark task as (d)one or (u)ndone? (d/u): ").strip().lower()

    if task_type == '':
        exit(0)
    if task_type == 'd':
        task_number = int(
            input("\nEnter the number of the task you completed (0 to exit): "))
        if task_number == 0:
            exit(0)
        if task_number < 1 or task_number > len(tasks_undone):
            console.print(
                "[bold red]Invalid task number. Please try again.[/bold red]")
            return
        mark_task_done(filepath, tasks_undone, lines, task_number)
    elif task_type == 'u':
        task_number = int(
            input("\nEnter the number of the task to mark as undone (0 to exit): "))
        if task_number == 0:
            exit(0)
        if task_number < 1 or task_number > len(tasks_done):
            console.print(
                "[bold red]Invalid task number. Please try again.[/bold red]")
            return
        mark_task_undone(filepath, tasks_done, lines, task_number)


def send_telegram_message(bot_token, chat_id, message):
    url = f"https://api.telegram.org/bot{bot_token}/sendMessage"
    payload = {
        'chat_id': chat_id,
        'text': message,
        'parse_mode': 'Markdown',
        'disable_notification': True
    }
    response = requests.post(url, data=payload)
    if response.status_code == 200:
        message_id = response.json()['result']['message_id']
        sent_message_ids.append(message_id)
        console.print(f"[bold green]Message sent successfully![/bold green]")
    else:
        console.print(
            f"[bold red]Failed to send message: {response.text}[/bold red]")


def delete_telegram_messages(bot_token, chat_id):
    url = f"https://api.telegram.org/bot{bot_token}/deleteMessage"
    for message_id in sent_message_ids:
        payload = {
            'chat_id': chat_id,
            'message_id': message_id
        }
        response = requests.post(url, data=payload)
        if response.status_code == 200:
            console.print(
                f"[bold green]Message {message_id} deleted successfully![/bold green]")
        else:
            console.print(
                f"[bold red]Failed to delete message {message_id}: {response.text}[/bold red]")
    sent_message_ids.clear()


def format_tasks_message(tasks_undone, tasks_done):
    message = "📝 *Tasks:*\n"
    message += "-------------------\n"
    for i, task in enumerate(tasks_undone, 1):
        message += f"🔴 {i}. [ ] {task}\n"
    message += "\n✅ *Completed Tasks:*\n"
    message += "-----------------------\n"
    for i, task in enumerate(tasks_done, 1):
        message += f"🟢 {i}. [ ] {task}\n"
    return message


def init(filepath):
    if not os.path.exists(filepath):
        console.print(f"[bold red]File {filepath} not found.[/bold red]")
        exit(1)

    console.print(f"[bold green]Reading tasks from: {filepath}[/bold green]\n")
    while True:
        lines = []
        tasks_undone, tasks_done = read_tasks(filepath)

        print_tasks_tree("Tasks", tasks_undone, "✗", "red")
        print_tasks_tree("Completed Tasks", tasks_done, "✔", "green")

        actions(filepath, tasks_undone, tasks_done, lines)

        delete_telegram_messages(BOT_TOKEN, CHAT_ID)

        tasks_undone, tasks_done = read_tasks(filepath)

        message = format_tasks_message(tasks_undone, tasks_done)
        send_telegram_message(BOT_TOKEN, CHAT_ID, message)


def main():
    parser = argparse.ArgumentParser(description="Task management script")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('-d', '--default', action='store_true',
                       help="Use default file path")
    group.add_argument('-f', '--file', type=str,
                       help="Specify custom file path")

    args = parser.parse_args()

    base_path = "PATH"
    directory = "Week" + str((datetime.date.today()).isocalendar()[1])
    base_path = os.path.join(base_path, directory)
    if args.default:
        filepath = os.path.join(base_path, formatted_date + ".md")
    else:
        filepath = args.file

    init(filepath)


if __name__ == "__main__":
    main()
