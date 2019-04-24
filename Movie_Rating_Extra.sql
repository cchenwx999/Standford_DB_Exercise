-- dbext:type=SQLITE:dbname=movie_rating.db

-- Question 1
--Find the names of all reviewers who rated Gone with the Wind. 
select name
from reviewer
where rID in (select rID from Rating 
              where mID = (select mID from Movie 
                          where title="Gone with the Wind"))
                           
-- Question 2
-- For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.
select name, title,stars
from (Movie join Rating on movie.mid=rating.mid)
            join reviewer on reviewer.rid=rating.rid
where name=director
                           
-- Question 3
-- Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first 
-- word in the title is fine; no need for special processing on last names or removing "The".) 
select name as Names from Reviewer
union 
select title as Names from Movie
order by Names
                           
-- Question 4
-- Find the titles of all movies not reviewed by Chris Jackson.
                           
select title from movie where mID not in 
              (select mID from Rating where rID in
                      (select rID from Reviewer where name="Chris Jackson"))

-- Question 5
-- For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. 
-- Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, 
-- return the names in the pair in alphabetical order. 
select distinct Re1.name,re2.name
from Rating R1, Rating R2,reviewer re1, reviewer re2
where Re1.name<Re2.name and R1.mID=R2.mID and re1.rID=R1.Rid and re2.rid=r2.rid
order by re1.name, re2.name  
                       
-- Question 6
-- For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, 
-- and number of stars. 
select name,title,stars
from (Movie join Rating on movie.mid=rating.mid)
            join reviewer on reviewer.rid=rating.rid
where stars=(select min(stars) from rating)  
                       
-- Question 7
-- List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies 
-- have the same average rating, list them in alphabetical order. 
select title,avg(stars)
from Movie join Rating on movie.mID=rating.mID
group by title
order by avg(stars) desc, title
                       
-- Question 8
-- Find the names of all reviewers who have contributed three or more ratings. 
-- (As an extra challenge, try writing the query without HAVING or without COUNT.) 
   
select name
from Reviewer, (select rID, count(stars) as tsat from Rating group by rID) as T
where T.rID=Reviewer.rID
and T.tsat>=3

select distinct name from (Reviewer join 
(select R1.rID as rID1,R2.rID as rID2,R1.mID as mID1,R2.mID as mID2,R1.ratingDate as ratingDate1,R2.ratingDate as ratingDate2
from Rating R1 join Rating R2 on R1.rID = R2.rID and (R1.mID<>R2.mID or R1.ratingDate<>R2.ratingDate)) T 
on Reviewer.rID=T.rID1) S
join Rating R3 on S.rID1 = R3.rID and (S.mID1 <> R3.mID or S.ratingDate1 <> R3.ratingDate)
where (S.mID2 <> R3.mID or S.ratingDate2 <> R3.ratingDate)
 
-- Question 9
-- Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, 
-- along with the director name. 
-- Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.) 
select m1.title,m1.director
from Movie m1, Movie m2
where m1.director=m2.director and m1.title<>m2.title
order by m1.director,m1.title

select Movie.title, Movie.director from Movie
join (select director, count(title) as title from Movie group by director) T on Movie.director=T.director
where T.title>=2
order by 2,1

select title, director from Movie
where director in (select director from Movie group by director having count(director)>=2)
order by director,title     
 
-- Question 10
-- Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. 
-- (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the 
-- highest average rating and then choosing the movie(s) with that average rating.) 
select title, T.astar
from Movie join (select mID, avg(stars) as astar
from Rating  group by mID) as T on Movie.mID=T.mID
where T.astar=(select max(T.astar) from (select mID, avg(stars) as astar
from Rating
group by mID) as T)    
 
-- Question 11
-- Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. 
-- (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as 
-- finding the lowest average rating and then choosing the movie(s) with that average rating.)
select title,T.mstar
from Movie join (select mID, avg(stars) as mstar from rating group by mID) as T on Movie.mID=T.mID
Where T.mstar = (select min(T.mstar) from (select mID,avg(stars) as mstar from Rating group by mID) as T)
 
-- Question 12
-- For each director, return the director's name together with the title(s) of the movie(s) they directed 
-- that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL. 
select distinct movie.director, movie.title, stars
from (movie join rating on movie.mID=Rating.mID) join
( select director, max(stars) as mtars from movie join rating using (mid) group by director) T
on movie.director=T.director and Rating.stars=T.mtars
