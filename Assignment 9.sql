
---Q1 Create a new column which states that where the students got first class of
not?

mysql> select * from student;
+------+---------+-------+------+-------+
| roll | name    | marks | age  | class |
+------+---------+-------+------+-------+
|    1 | rohan   |  92.2 |   23 | d2    |
|    2 | shubham | 53.23 |   25 | d2    |
|    3 | pratik  | 42.34 |   25 | d1    |
|    4 | viraj   | 63.23 |   25 | d3    |
|    5 | suraj   |  73.2 |   23 | d1    |
|    6 | viraj   |  82.2 |   24 | d1    |
|    7 | kartik  | 72.34 |   26 | d3    |
+------+---------+-------+------+-------+
7 rows in set (0.00 sec)

mysql> alter table student add column grade varchar(30);
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> update student set grade = 'First Class' where marks>=75;
Query OK, 2 rows affected (0.00 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> update student set grade = 'Not First Class' where marks<75;
Query OK, 5 rows affected (0.01 sec)
Rows matched: 5  Changed: 5  Warnings: 0

mysql> select * from student;
+------+---------+-------+------+-------+-----------------+
| roll | name    | marks | age  | class | grade           |
+------+---------+-------+------+-------+-----------------+
|    1 | rohan   |  92.2 |   23 | d2    | First Class     |
|    2 | shubham | 53.23 |   25 | d2    | Not First Class |
|    3 | pratik  | 42.34 |   25 | d1    | Not First Class |
|    4 | viraj   | 63.23 |   25 | d3    | Not First Class |
|    5 | suraj   |  73.2 |   23 | d1    | Not First Class |
|    6 | viraj   |  82.2 |   24 | d1    | First Class     |
|    7 | kartik  | 72.34 |   26 | d3    | Not First Class |
+------+---------+-------+------+-------+-----------------+
7 rows in set (0.00 sec)


---Q2 Create a new column which states that grade of the students:
	1) > 75: A+ grade
	2) > 60: A grade
	3) > 55: B+ grade
	4) > 50: B grade
	5) > 40: C grade
	6) < 40: D grade

mysql> update student set grade = case when marks > 75 then 'A+'
    -> when marks between 60 and 75 then 'A'
    -> when marks between 55 and 60 then 'B+'
    -> when marks between 50 and 55 then 'B'
    -> when marks between 40 and 50 then 'C'
    -> when marks < 40 then 'D'
    -> end;
Query OK, 2 rows affected (0.00 sec)
Rows matched: 7  Changed: 2  Warnings: 0

mysql> select * from student;
+------+---------+-------+------+-------+-------+
| roll | name    | marks | age  | class | grade |
+------+---------+-------+------+-------+-------+
|    1 | rohan   |  92.2 |   23 | d2    | A+    |
|    2 | shubham | 53.23 |   25 | d2    | B     |
|    3 | pratik  | 42.34 |   25 | d1    | C     |
|    4 | viraj   | 63.23 |   25 | d3    | A     |
|    5 | suraj   |  73.2 |   23 | d1    | A     |
|    6 | viraj   |  82.2 |   24 | d1    | A+    |
|    7 | kartik  | 72.34 |   26 | d3    | A     |
+------+---------+-------+------+-------+-------+
7 rows in set (0.00 sec)



--- Q3 Create a procedure to find addition of first 10 natural numbers.

mysql> delimiter &&
mysql> create procedure sumNat()
    -> begin
    -> declare i int;
    -> declare sum int;
    -> set i=1;
    -> set sum=0;
    -> myloop:loop
    -> set sum=sum+i;
    -> set i=i+1;
    -> if i>10 then
    -> leave myloop;
    -> end if;
    -> iterate myloop;
    -> end loop;
    -> select sum;
    -> end &&
Query OK, 0 rows affected (0.00 sec)
mysql> delimiter ;
mysql> call sumNat;
+------+
| sum  |
+------+
|   55 |
+------+
1 row in set (0.00 sec)


---Q4 Create a procedure to enter a parameter and check where that is even
number or odd number or neither of them.

mysql> create procedure even(in num int, out result varchar(10))
    -> begin
    -> if num%2=0 then
    -> set result = 'Even';
    -> else
    -> set result = 'odd';
    -> end if;
    -> select result;
    -> end &&
Query OK, 0 rows affected (0.01 sec)

mysql> delimiter ;
    -> set @result='';
    -> call even(22,@result);
Query OK, 0 rows affected (0.00 sec)

+--------+
| result |
+--------+
| Even   |
+--------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)


---Q5 Write a procedure to pass marks a parameter and find the grade of the
	student according to marks:
	1) > 75: A+ grade
	2) > 60: A grade
	3) > 55: B+ grade
	4) > 50: B grade
	5) > 40: C grade
	6) < 40: D grade

mysql> delimiter &&
mysql> create procedure findGrade(in m double, out grade varchar(10))
    -> begin
    -> if (m>=75) then set grade = 'A+';
    -> elseif (m >= 60 and m < 75) then set grade = 'A';
    -> elseif (m >= 55 and m < 60) then set grade = 'B+';
    -> elseif (m >= 50 and m < 55) then set grade = 'B';
    -> elseif (m >= 40 and m < 50) then set grade = 'C';
    -> else set grade = 'D';
    -> end if;
    -> select grade;
    -> end &&
Query OK, 0 rows affected (0.00 sec)

mysql> delimiter ;
mysql> set @grade='';
Query OK, 0 rows affected (0.00 sec)

mysql> call findGrade(62,@grade);
+-------+
| grade |
+-------+
| A     |
+-------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

mysql> call findGrade(60,@grade);
+-------+
| grade |
+-------+
| A     |
+-------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)


