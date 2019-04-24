-- Question 1
-- Find the names of all students who are friends with someone named Gabriel.
select name from Highschooler where ID in
(select ID2 from Friend
where ID1 in (select ID from Highschooler where name = 'Gabriel'))
-- actually use 'where in' not 'where =', because the name is not unique


-- Question 2
-- For every student who likes someone 2 or more grades younger than themselves,
-- return that student's name and grade, and the name and grade of the student they like.
select H1.name, H1.grade, H2.name, H2.grade
from (Highschooler H1 join Likes on H1.ID=ID1) join Highschooler H2 on ID2 = H2.ID
where H1.grade-H2.grade>=2
              
-- Question 3
-- For every pair of students who both like each other, return the name and grade of both students. 
-- Include each pair only once, with the two names in alphabetical order.
select H1.name, H1.grade, H2.name, H2.grade
from 
(Highschooler H1 join 
(select L1.ID1 as L1ID1, L1.ID2 as L1ID2 from Likes L1 join Likes L2 on L1.ID2=L2.ID1 and L1.ID1 = L2.ID2) as Y
on H1.ID = Y.L1ID1 )
join Highschooler H2 on H2.ID=Y.L1ID2
where H1.name < H2.name
order by 1,3
              
-- Question 4
-- Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. 
-- Sort by grade, then by name within each grade. 
select name, grade from Highschooler
where ID not in (select ID1 from Likes union select ID2 from Likes)
order by 2,1
              
-- Question 5
-- For every situation where student A likes student B, but we have no information about whom B likes 
-- (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades. 
select H1.name, H1.grade, H2.name, H2.grade
from 
(Highschooler H1 join 
(select ID1, ID2 from Likes where ID2 not in (select ID1 from Likes)) as Y on H1.ID=Y.ID1)
join Highschooler H2 on H2.ID=Y.ID2

-- Question 6
-- Find names and grades of students who only have friends in the same grade. 
-- Return the result sorted by grade, then by name within each grade.
select name, grade from Highschooler where ID 
not in (
select distinct F1.ID1
from 
(Friend F1 join Highschooler H1 on H1.ID = F1.ID1)
join Highschooler H2 on H2.ID= F1.ID2 where H1.grade <> H2.grade
)
order by 2,1

-- Question 7
-- For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). 
-- For all such trios, return the name and grade of A, B, and C. 
select distinct H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
from
((
(
(select L1.ID1 as ID1, L1.ID2 as ID2 from Likes L1 where L1.ID1 not in 
      (select Likes.ID1 from Likes join Friend on Likes.ID1=Friend.ID1 and Likes.ID2=Friend.ID2) ) T 
join (select F1.ID1 as ID1,F1.ID2,F2.ID2 as FID2 from Friend F1 join Friend F2 on F1.ID2=F2.ID1 and F1.ID1<>F2.ID2) S 
on T.ID2=S.ID1 and T.ID1 <> S.ID2 and S.FID2=T.ID1
)
join Highschooler H1 on H1.ID = T.ID1
)
join Highschooler H2 on H2.ID = T.ID2
)
join Highschooler H3 on H3.ID = S.ID2

-- Question 8
-- Find the difference between the number of students in the school and the number of different first names. 
select distinct (select count(distinct ID) from Highschooler)-(select count(distinct name) from Highschooler)
from Highschooler
              
-- Question 9
-- Find the name and grade of all students who are liked by more than one other student. 
select name, grade
from Highschooler
where ID in (select ID2 from Likes group by ID2 having count(ID2)>=2)              

