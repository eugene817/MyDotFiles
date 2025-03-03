import datetime
import random
import os
import argparse


text = f"""
{datetime.time()} 



"""


parser = argparse.ArgumentParser(description="Task management script")
parser.add_argument('-n', '--number', type=int, required=True, help="Add number to planner creator")
args = parser.parse_args()



number = args.number

path = ""
directory = "DailyDailyDiary/Weeks/Week" + str((datetime.date.today() + datetime.timedelta(days=number)).isocalendar()[1])

new_path = os.path.join(path, directory)

os.mkdir(new_path)

# Генерация дат для недели
formatted_date = []
for i in range(number, 7 + number):
    now = datetime.date.today() + datetime.timedelta(days=i)
    formatted_date.append(now.strftime("%d%b") + f"({now.isocalendar()[1]}-{now.isoweekday()})." + now.strftime("%y"))

# Генерация файлов на каждый день
daily_files = []
for i in formatted_date:
    filepath = os.path.join(new_path, i)
    daily_files.append(filepath + ".md")
    with open(filepath + ".md", "w") as f:
        # Выбираем случайную цитату
        
        # Шаблон для дня
        text = f"""
- [ ] 
"""
        f.write(text)

# Создаем файл недели с ссылками на все дни
weekmd = os.path.join(new_path, "Week-")
weekmd += str((datetime.date.today() + datetime.timedelta(days=number)).isocalendar()[1]) + "-" + now.strftime("%y") + ".md" 
with open(weekmd, "w") as f:
    summary_text = f"""
# Обзор недели {datetime.date.today().isocalendar()[1]}

## Цели недели:
- Главная цель: 
- Подцели:
  - 
  - 

## Ссылки на дни:
"""
    for daily_file, date in zip(daily_files, formatted_date):
        summary_text += f"- [{date.split('.')[0]}](./{os.path.basename(daily_file)})\n"
    
    summary_text += f"""

---

## Рефлексия недели:
- Что было хорошо? 
- Что можно улучшить?
- Какие цели на следующую неделю?

## Итоги недели:
- 
"""
    f.write(summary_text)

# Создаем файл для обзора всей недели
final_summary = os.path.join(new_path, "Week-")
final_summary += str((datetime.date.today() + datetime.timedelta(days=number)).isocalendar()[1]) + "-" + now.strftime("%y") + ".md" 
with open(final_summary, "w") as f:
    final_text = f"""
# Итоговый обзор недели {datetime.date.today().isocalendar()[1]}

## Основные достижения:
- 

## Сложности и препятствия:
- 

## Выводы:
- 

## Цели на следующую неделю:
- 

---

## Дни недели:
"""
    for daily_file, date in zip(daily_files, formatted_date):
        final_text += f"- [{date.split('.')[0]}](./{os.path.basename(daily_file)})\n"
    
    final_text += """
---

## Благодарность:
- Кому или чему вы благодарны за эту неделю?
"""
    f.write(final_text)
