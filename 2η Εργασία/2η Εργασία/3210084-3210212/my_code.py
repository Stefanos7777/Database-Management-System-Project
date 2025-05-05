import csv
import ast

# Reading the CSV file and store the data in a list of dictionaries
with open('keywords.csv', newline='', encoding='utf-8') as csvfile:
    reader = csv.DictReader(csvfile)
    next(reader)
    data = [row for row in reader]

# Creating dictionaries for the new hasKeyword and keyword table
hasKeyword = {}
keyword = {}

# Going through each line of the original file and process the data
for row in data:
    
    movie_id = row['movie_id']
    keywords = ast.literal_eval(row['keywords'])

    # Looping through each key in the JSON and add it to the keyword table
    for key in keywords:
        keyword_id = key['id']
        keyword_name = key['name']
        if keyword_id not in keyword:
            keyword[keyword_id] = {'id': keyword_id, 'name': keyword_name}
   
        # Adding the (movie_id, keyword_id) element to the hasKeyword array
        if movie_id not in hasKeyword:
            hasKeyword[movie_id] = set()
        hasKeyword[movie_id].add(keyword_id)
        
# Creating the hasKeyword array with unique values ​​for each key
hasKeyword = {}
for row in data:
    movie_id = row['movie_id']
    keywords = ast.literal_eval(row['keywords'])
    if movie_id not in hasKeyword:
        hasKeyword[movie_id] = set()
    for key in keywords:
        keyword_id = key['id']
        hasKeyword[movie_id].add(keyword_id)

# Creating the new tables in CSV files
with open('hasKeyword.csv', 'w', newline='', encoding='utf-8') as csvfile:
    fieldnames = ['movie_id', 'keyword_id']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()
    for movie_id, keyword_ids in hasKeyword.items():
        for keyword_id in keyword_ids:
            writer.writerow({'movie_id': movie_id, 'keyword_id': keyword_id})

with open('keyword.csv', 'w', newline='', encoding='utf-8') as csvfile:
    fieldnames = ['id', 'name']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()
    for keyword_data in keyword.values():
        writer.writerow(keyword_data)

