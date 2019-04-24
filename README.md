# Standford_DB_Exercise
This includes materials, exercises and solutions used in the [DBclass](https://lagunita.stanford.edu/courses/DB/SQL/SelfPaced/course/#i4x://DB/SQL/chapter/ch-sql) offered by Stanford.


This includes exercises for sql in the classes. The first line in all examples is used by the dbext vim plugin to correctly connect to the right database.

## Movie-Rating Exercise
> You've started a new movie-rating website, and you've been collecting data on reviewers' ratings of various movies. There's not much data yet, but you can still try out some interesting queries. Here's the schema: 

> Movie ( mID, title, year, director ) 
English: There is a movie with ID number mID, a title, a release year, and a director. 

> Reviewer ( rID, name ) 
English: The reviewer with ID number rID has a certain name. 

> Rating ( rID, mID, stars, ratingDate ) 
English: The reviewer rID gave the movie mID a number of stars rating (1-5) on a certain ratingDate. 

> Your queries will run over a small data set conforming to the schema. View the [database](https://lagunita.stanford.edu/c4x/DB/SQL/asset/moviedata.html). (You can also [download the schema and data](https://s3-us-west-2.amazonaws.com/prod-c2g/db/Winter2013/files/rating.sql).) 

## Social-Network Exercise

> Students at your hometown high school have decided to organize their social network using databases. So far, they have collected information about sixteen students in four grades, 9-12. Here's the schema: 

> Highschooler ( ID, name, grade ) 
English: There is a high school student with unique ID and a given first name in a certain grade. 

> Friend ( ID1, ID2 ) 
English: The student with ID1 is friends with the student with ID2. Friendship is mutual, so if (123, 456) is in the Friend table, so is (456, 123). 

> Likes ( ID1, ID2 ) 
English: The student with ID1 likes the student with ID2. Liking someone is not necessarily mutual, so if (123, 456) is in the Likes table, there is no guarantee that (456, 123) is also present. 

> Your queries will run over a small data set conforming to the schema. View the [database](https://lagunita.stanford.edu/c4x/DB/SQL/asset/socialdata.html). (You can also [download the schema and data](https://s3-us-west-2.amazonaws.com/prod-c2g/db/Winter2013/files/social.sql).) 

# Github Editing
> Refrence the [editing link](https://help.github.com/en/articles/basic-writing-and-formatting-syntax)
