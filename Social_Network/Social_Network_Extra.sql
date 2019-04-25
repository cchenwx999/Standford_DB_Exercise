    
-- Question 1
-- For every situation where student A likes student B, but student B likes a different student C, 
-- return the names and grades of A, B, and C.
select H1.name, H1.grade,H2.name, H2.grade,H3.name, H3.grade
from (((
(select L1.ID1 as L1ID1, L1.ID2 as L1ID2,L2.ID2 as L2ID2 from Likes L1 join Likes L2 on L1.ID2=L2.ID1 and L1.ID1<>L2.ID2) T
join Highschooler H1 on H1.ID= T.L1ID1)
join Highschooler H2 on H2.ID= T.L1ID2)
join Highschooler H3 on H3.ID= T.L2ID2)

-- Question 2
-- Find those students for whom all of their friends are in different grades from themselves. Return the students' names and grades. 
select H.name, H.grade
from Highschooler H
where ID not in 
      (select T.ID1 from
             (
                (select ID1, ID2, H1.grade as grade from Friend F join Highschooler H1 on H1.ID=F.ID1) S
                  join Highschooler H2 on H2.ID = S.ID2 and S.grade = H2.grade
              ) T 
       )

-- or
select name, grade
from Highschooler, (
  select ID1 from Friend
  except
  -- students have friends with same grade
  select distinct Friend.ID1
  from Friend, Highschooler H1, Highschooler H2
  where Friend.ID1 = H1.ID and Friend.ID2 = H2.ID
  and H1.grade = H2.grade
) as Sample
where Highschooler.ID = Sample.ID1

-- Question 3
-- What is the average number of friends per student? (Your result should be just one number.) 
select avg(T.CID)
from (select ID, count(ID) as CID from Highschooler H join Friend F on H.ID=F.ID1 group by ID) T
# the Highschooler join with Friend seems redundant

--or
select SUM(NUM)/ROUND(COUNT(NUM),1)
from (select count(id2) as num from friend group by id1) 

-- or use average function
select avg(T.num)
from (select count(id2) as num from friend group by id1) T

-- Question 4
-- Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. 
-- Do not count Cassandra, even though technically she is a friend of a friend.
select count(IDID)
from(
select ID1 as IDID
from Friend where ID2=(select ID from Highschooler where name = 'Cassandra')
union
select F2.ID2 as IDID
from Friend F1 join Friend F2 on F1.ID2=F2.ID1 where F1.ID1=(select ID from Highschooler where name = 'Cassandra')
)
where IDID <>(select ID from Highschooler where name = 'Cassandra')

-- Question 5
-- Find the name and grade of the student(s) with the greatest number of friends. 
select name,grade
from Highschooler
where ID in ( select T.ID from 
(select ID, count(ID) as CID
from Highschooler H join Friend F on H.ID=F.ID1 group by ID) T 
where T.CID = (select max(T.CID) from 
(select ID, count(ID) as CID
from Highschooler H join Friend F on H.ID=F.ID1 group by ID) T    ))

