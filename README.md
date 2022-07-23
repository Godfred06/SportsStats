# SportsStats Description of the data 


Preparation for the Proposal
#Exploration of the dataset to understand how the data was structured in the database
1.	The sports stats data set was chosen partially due to my interest in sports and also a genuine curiosity to find out about some characteristics of teams that have a high medal winning percentage when it comes to these games. 
2.	Steps taken to import and clean the data
  a.	The data was downloaded from the drop box link and then a new database was created in SQLite
  b.	The data was then imported as a table CSV file and then explored.
  c.	The table was the organized into small descriptive tables with an ER Diagram to act as a guide for the further analysis.
    i.	Age was computed as the age at the first event and age at the last event
    ii.	For persons who switched teams, the first team of affiliation was the one used for the tables. 
3.	There are 271116 entries in the database. Each entry represents an individual participating in an event in one of the games or events
  a.	Due to some participants participating in multiple events and also in multiple games, some individuals appear more than once in the database.
  b.	Also, participants might have their age differ at the time they participated in different games obviously due to growth
  c.	Some participants had a change of nationality or a switch of teams from one point of the data collection to another.
  d.	Height and weight remained pretty constant throughout the database for the participants
  e.	 There have been 52 games since the first games. The first game took place in Athina in the year 1896
  f.	There also has been 765 different events in which people have participated in.
4.	ER-Diagram
 

Developing of Project Proposal
•	This project will seek to describe some characteristics about the participants who take part in these games, 
  the countries who perform well in these games (medal winners). 
  The project will seek to describe the type of sports or events that some of these countries are good at. 
  The local new agencies will gain insights into which teams have been excelling in which of the sports that take place in the games and with further
  analysis might be able to predict which team will win a medal at a particular sport using the historical data and the characteristics of the winners.
•	Questions 
  o	What are the physical characteristics of the participants who take part in some of the events at these games? Physical characteristics such as height and weight 
  o	Which countries excel well at these games by winning medals?
•	Hypothesis
  o	Participating in one game multiple times in different games is likely to increase your chance of winning a medal.
  o	Countries with a high number of participants in these games have a much higher number of medals won.
  o	United States has the highest number of medals won in these Games
•	Approach
   o	The number of times a particular individual as participated in a single event is going to be determine and the characteristics of the individual.
   Age at the time and other characteristics. 
   
   
   #Desrcriptive Stats after creating the tables
1.	Descriptive stats 
  •	The number of distinct participants in the data base
    o	This was to guide my later analysis when combining tables to extract some information to know whether I was getting the right results for the query I was executing. 
  •	The average characteristics of the participants group by the regions that they originate from
    o	The average weight, height, age at the first and last event were all computed and grouped by the regions. 
      	This was to give an impression of the average age, height and weight of the participants for the various regions.
  •	The extremes of the data: the minimum and maximum age, weight and height
    o	This was to eliminate any outliers and bad entries from the data. Such as having a negative age or weight or height or having a physical attribute that looks like an outlier
2.	Discovery about the data
  •	The numbering for the ids is not consecutive with one following each other. That is to mean that some of the numbers are missing from the database. For example, there is no id number 332 in the database
  •	Some participants had a switch of region they competed for. Participant may have competed for one region in the first game and then switched to another team in another games.
    i.	In cases like that, one team was selected for the analysis using the max function 
  •	The columns for age, weight and height were all formatted as strings and so in order to perform any maths functions or arithmetic calculations, they had to be cast to integers first
3.	 Hypothesis
  •	Participating in multiple games increases your chance of actually winning
    i.	Initial analysis show that this is a true hypothesis
       1.	The next step will be to find how the how many medals are won by the top competing persons in the games. To count the number of medals won against the number of games the participants has competed in for top 20 in the event participation category 
  •	Countries with the highest number of participations in these games have the highest number of medals won. 
    i.	Initial analysis of the data shows that this is a true hypothesis. The United States of America has the highest number of events participated in and also the highest number of medals won
      1.	The next step will be to compute the winning percentage for the top 50 teams in the Olympics to know the teams with the highest winning percentage for the events that they have participated in
      •	United states medal count
    i.	Initial analysis shows the United States has the highest number of medals won in these games all time.
4.	Other questions
    •	How many medals have the top 50 in events participation won in these games all time?
    •	What is the winning percentage for the top 50 in events participation all time?

