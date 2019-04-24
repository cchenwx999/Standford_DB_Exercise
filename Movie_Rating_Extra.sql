-- dbext:type=SQLITE:dbname=movie_rating.db

-- Question 1
--Find the names of all reviewers who rated Gone with the Wind. 
select name
from reviewer
where rID in (select rID from Rating 
              where mID = (select mID from Movie 
                          where title="Gone with the Wind"))
