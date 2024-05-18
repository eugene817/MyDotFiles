import datetime
import os
import argparse


text = """
pattern to add
"""



parser = argparse.ArgumentParser(description="Task management script")
parser.add_argument('-n', '--number', type=int, required=True, help="Add number to planner creator")
args = parser.parse_args()

number = 0


number = args.number

path = "/home/yasakar/Desktop/EveryDAy/DailyDailyDiary/Weeks/"
directory = "Week" + str((datetime.date.today() + datetime.timedelta(days=number)).isocalendar()[1])

new_path = os.path.join(path, directory)

os.mkdir(new_path)

formatted_date = []
for i in range(number, 7 + number):
    now = datetime.date.today() + datetime.timedelta(days=i)
    formatted_date.append(now.strftime("%d%b") + f"({now.isocalendar()[1]}-{now.isoweekday()})." + now.strftime("%y"))



for i in formatted_date:
    filepath = os.path.join(new_path, i)
    with open(filepath + ".md", "w") as f:
        f.write(text)

weekmd = os.path.join(new_path, directory)
with open(weekmd + ".md", "w") as f:
    for i in formatted_date:
        f.write("[[" + i + "]]\n")
