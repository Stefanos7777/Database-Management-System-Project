import pyodbc
import matplotlib.pyplot as plt
import numpy as np

# Σύνδεση στην βάση 
server = 'serverforproject.database.windows.net'
database = 'ExercisesDatabase'
username = 'newLogin'
password = '@ffPasds!3r'

cnxn = pyodbc.connect('DRIVER={ODBC Driver 18 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)

cursor = cnxn.cursor()

# Ερώτημα 1: Αριθμός ταινιών ανά έτος με συνολικό budget μεγαλύτερο από 1,000,000
query1 = '''
SELECT YEAR(release_date) AS year, COUNT(*) AS movies_per_year
FROM movie
WHERE budget > 1000000
GROUP BY YEAR(release_date)
'''

cursor.execute(query1)
result1 = cursor.fetchall()

# Οπτικοποίηση γραφήματος για το ερώτημα 1
years1 = [row[0] for row in result1]
movies_per_year1 = [row[1] for row in result1]

plt.bar(years1, movies_per_year1)
plt.xlabel('Year')
plt.ylabel('Number of Movies')
plt.title('Number of Movies per Year (Budget > 1,000,000)')
plt.show()

# Ερώτημα 2: Αριθμός ταινιών ανά είδος με συνολικό budget μεγαλύτερο από 1,000,000 ή διάρκεια μεγαλύτερη από 2 ώρες
query2 = '''
SELECT g.name AS genre, COUNT(*) AS movies_per_genre
FROM movie m
JOIN hasGenre hg ON m.id = hg.movie_id
JOIN genre g ON hg.genre_id = g.id
WHERE m.budget > 1000000 OR m.runtime > 120
GROUP BY g.name
'''

cursor.execute(query2)
result2 = cursor.fetchall()

# Οπτικοποίηση γραφήματος για το ερώτημα 2
genres2 = [row[0] for row in result2]
movies_per_genre2 = [row[1] for row in result2]

plt.bar(genres2, movies_per_genre2)
plt.xlabel('Genre')
plt.ylabel('Number of Movies')
plt.title('Number of Movies per Genre (Budget > 1,000,000 or Duration > 2 hours)')
plt.xticks(rotation=45)
plt.show()

# Ερώτημα 3: Αριθμός ταινιών ανά είδος και ανά έτος
query3 = '''
SELECT g.name AS genre, YEAR(m.release_date) AS year, COUNT(*) AS movies_per_gy
FROM movie m
JOIN hasGenre hg ON m.id = hg.movie_id
JOIN genre g ON hg.genre_id = g.id
GROUP BY g.name, YEAR(m.release_date)
'''

cursor.execute(query3)
result3 = cursor.fetchall()

# Filter out rows with missing or null values
result3 = [row for row in result3 if None not in row]

genres3 = []
years3 = []
movies_per_gy3 = []

for row in result3:
    genres3.append(row[0])
    years3.append(row[1])
    movies_per_gy3.append(row[2])

# Δημιουργία του scatter plot
plt.scatter(years3, genres3, s=movies_per_gy3, alpha=0.7)
plt.xlabel('Year')
plt.ylabel('Genre')
plt.title('Number of Movies per Genre and Year')
plt.show()

# Ερώτημα 4: Για τον αγαπημένο σας ηθοποιό, το σύνολο των εσόδων για τις ταινίες στις οποίες έχει συμμετάσχει ανά έτος
query4 = '''
SELECT YEAR(m.release_date) AS year, SUM(m.revenue) AS revenues_per_year
FROM movie m
JOIN movie_cast mc ON m.id = mc.movie_id
WHERE mc.name = 'Bruce Willis'
GROUP BY YEAR(m.release_date)
'''

cursor.execute(query4)
result4 = cursor.fetchall()

# Οπτικοποίηση γραφήματος για το ερώτημα 4
years4 = [row[0] for row in result4]
revenues_per_year4 = [row[1] for row in result4]

plt.plot(years4, revenues_per_year4, marker='o')
plt.xlabel('Year')
plt.ylabel('Total Revenue')
plt.title('Total Revenue per Year for Bruce Willis Movies')
plt.show()

# Ερώτημα 5: Το υψηλότερο budget ταινίας ανά έτος, όταν το budget αυτό δεν είναι μηδενικό
query5 = ''' 
SELECT YEAR(release_date) AS year, MAX(budget) AS max_budget
FROM movie
WHERE budget > 0
GROUP BY YEAR(release_date)
'''

cursor.execute(query5)
result5 = cursor.fetchall()
 
# Οπτικοποίηση γραφήματος για το ερώτημα 5
years5 = [row[0] for row in result5]
max_budgets = [row[1] for row in result5]

plt.bar(years5, max_budgets)
plt.xlabel('Year')
plt.ylabel('Max Budget')
plt.title('Highest Budget Movie per Year')
plt.show()

# Ερώτημα 7: Για κάθε χρήστη του πίνακα Ratings, να επιστραφούν η μέση βαθμολογία του χρήστη και ο αριθμός των βαθμολογιών του 
query7 = '''
SELECT user_id, AVG(rating) AS avg_rating, COUNT(*) AS rating_count
FROM ratings
GROUP BY user_id
'''
cursor.execute(query7)
result7 = cursor.fetchall()

# Οπτικοποίηση γραφήματος για το ερώτημα 7
user_ids7 = [row[0] for row in result7]
avg_ratings = [row[1] for row in result7]
rating_counts = [row[2] for row in result7]

# Δημιουργία του 3D bar plot
fig = plt.figure(figsize=(12, 6))
ax = fig.add_subplot(111, projection='3d')

x_data = np.arange(len(user_ids7))
y_data = np.zeros(len(user_ids7))
z_data_avg = avg_ratings
z_data_count = rating_counts

# Οπτικοποίηση μέσης βαθμολογίας
ax.bar3d(x_data, y_data, z_data_avg, 0.5, 0.5, z_data_avg, color='b', alpha=0.8)

# Οπτικοποίηση αριθμού βαθμολογιών
ax.bar3d(x_data, y_data, np.zeros(len(user_ids7)), 0.5, 0.5, z_data_count, color='r', alpha=0.8)

ax.set_xlabel('User ID')
ax.set_ylabel('Average Rating')
ax.set_zlabel('Rating Count')
ax.set_title('Average Rating and Rating Count per User')

plt.show()
