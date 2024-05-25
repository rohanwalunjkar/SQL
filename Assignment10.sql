
--Q1. Write a procedure to find the factorial of the number.
--	Hint: use only repeat loop
	
mysql> delimiter &&
mysql> create procedure find_fact(p_num int)
    -> begin
    -> declare v_fact int default 1;
    -> repeat 
    -> set v_fact=v_fact*p_num;
    -> set p_num=p_num-1;
    -> until p_num=0
    -> end repeat;
    -> select v_fact as 'factorial';
    -> end &&
Query OK, 0 rows affected (0.01 sec)

mysql> delimiter ;
mysql> call find_fact(7);
+-----------+
| factorial |
+-----------+
|      5040 |
+-----------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)


--Q2. Create a procedure to find the sum of digits of the number passed as parameter to it.
--	Hint: use while loop

mysql> delimiter &&
mysql> create procedure sumDigit(p_num int)
    -> begin
    -> declare v_sum int default 0;
    -> declare v_digit int default 0;
    -> declare v_temp int default 0;
    -> set v_temp = p_num;
    -> while v_temp !=0 do
    -> set v_digit = v_temp%10;
    -> set v_temp = v_temp/10;
    -> set v_sum = v_sum + v_digit;
    -> end while;
    -> select v_sum as 'Sum of digits';
    -> end&&
Query OK, 0 rows affected (0.01 sec)

mysql> delimiter ;
mysql> call sumDigit(1234);
+---------------+
| Sum of digits |
+---------------+
|            10 |
+---------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)


-- Q3. Write a procedure to print the Fibonacci sequence using any kind of the loop.
--	e.g. 0, 1, 1, 2, 3, 5, 8....

mysql> delimiter &&
mysql> create procedure fibonacci(p_n int)
    -> begin
    ->     declare v_firstTerm int default 0;
    ->     declare v_secondTerm int default 1;
    ->     declare v_result TEXT default '';
    ->     declare v_thirdTerm int;
    ->     if p_n = 1 then
    ->         set v_result = v_firstTerm;
    ->     elseif p_n = 2 then
    ->         set v_result = concat_ws(',',v_firstTerm, v_secondTerm);
    ->     else
    ->         set v_result = concat_ws(',',v_firstTerm,v_secondTerm);
    ->         set p_n = p_n - 2; 
    ->         myloop: loop
    ->             set v_thirdTerm = v_secondTerm + v_firstTerm;
    ->             set v_result = concat_ws(',',v_result,v_thirdTerm);
    ->             set v_firstTerm = v_secondTerm;
    ->             set v_secondTerm = v_thirdTerm;
    ->             set p_n = p_n - 1;
    ->             if p_n <= 0 then
    ->             leave myloop;
    ->             end if;
    ->         end loop;
    ->     end if;
    -> select v_result as fibonacci_series;
    -> end &&
Query OK, 0 rows affected (0.00 sec)

mysql> delimiter ;
mysql> call fibonacci(1);
+------------------+
| fibonacci_series |
+------------------+
| 0                |
+------------------+
1 row in set (0.01 sec)

Query OK, 0 rows affected (0.01 sec)

mysql> call fibonacci(2);
+------------------+
| fibonacci_series |
+------------------+
| 0,1              |
+------------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

mysql> call fibonacci(3);
+------------------+
| fibonacci_series |
+------------------+
| 0,1,1            |
+------------------+
1 row in set (0.01 sec)

Query OK, 0 rows affected (0.01 sec)

mysql> call fibonacci(7);
+------------------+
| fibonacci_series |
+------------------+
| 0,1,1,2,3,5,8    |
+------------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)


--Q4. Write a procedure to print all the odd and even numbers separately using
--	same procedure.

mysql> delimiter &&
mysql> create procedure evenOdd(p_num int)
    -> begin
    -> declare v_num int default 1;
    -> declare v_even varchar(20) default '';
    -> declare v_odd varchar(20) default '';
    -> while (v_num<=p_num) do
    -> if(v_num%2=0) then
    -> set v_even=concat_ws(' ',v_even,v_num);
    -> else 
    -> set v_odd=concat_ws(' ',v_odd,v_num);
    -> end if;
    -> set v_num = v_num+1;
    -> end while; 
    -> select v_even;
    -> select v_odd;
    -> end &&
Query OK, 0 rows affected (0.01 sec)

mysql> delimiter ;
mysql> call evenOdd(10);
+-------------+
| v_even      |
+-------------+
|  2 4 6 8 10 |
+-------------+
1 row in set (0.01 sec)

+------------+
| v_odd      |
+------------+
|  1 3 5 7 9 |
+------------+
1 row in set (0.01 sec)

Query OK, 0 rows affected (0.01 sec)