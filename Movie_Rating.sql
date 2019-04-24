-- Question 1
-- Find the titles of all movies directed by Steven Spielberg. 
select distinct title
from Movie
where director= "Steven Spielberg"

-- Question 2
-- Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. 
select year
from movie
where mID in (select mID from Rating where stars=4 or stars=5)
order by year

-- Question 3
-- Find the titles of all movies that have no ratings.
select title
from Movie
where mID not in (select mID from Rating)

-- Question 4
-- Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.
select distinct name from reviewer
where rID in (select rID from Rating where ratingDate is null) 

-- Question 5
-- Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. 
-- Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. 
select R.name, M.title,  Ra.stars, Ra.ratingDate
from Movie M,Rating Ra ,Reviewer R 
where M.mID=Ra.mID and R.rID=Ra.rID
order by R.name, M.title, Ra.stars

-- Question 6
-- For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, 
-- return the reviewer's name and the title of the movie. 
select name,title
from Movie,Reviewer,(select R1.rID,R1.mID from Rating R1, Rating R2 where R1.rID=R2.rID and R1.mID=R2.mID
                   and R1.ratingDate<R2.ratingDate and R1.stars<R2.stars) as T
where Movie.mID=T.mID and Reviewer.rID=T.rID

-- Question 7
-- For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. 
-- Sort by movie title. 
select title,max(stars)
from Rating join Movie on Rating.mID=Movie.mID
group by title
order by title

-- Question 8
-- For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. 
-- Sort by rating spread from highest to lowest, then by movie title. 
select title, max(stars)-min(stars) as "rating spread"
from Movie join Rating on movie.mID=rating.mID
group by title
order by "rating spread" desc, title

-- Question 9
-- Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. 
-- (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies 
-- after. Don't just calculate the overall average rating before and after 1980.) 
select distinct (select avg(G.Avg) from (select mID,avg(stars) AS Avg from Rating group by mID) as G
join Movie on movie.mID=g.mID  where year<1980)-
(select avg(G.Avg) from (select mID,avg(stars) as Avg from Rating group by mID) as G
join Movie on movie.mID=G.mID
where year>1980)
from Movie

