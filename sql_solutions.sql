--Problem 1: Find the total number of crimes recorded in the Crime table
--Answer: based on the csv that has the data, a crime occurs for each row, so in order to sum up/count the number of data we shall count all the rows !


SELECT COUNT(*) AS TOTAL_CRIMES_COUNT
FROM CRIMES;


--Problem 2: Retrieve first 10 rows 
--Answer: we select * i.e. get all the columns from the table and we select to get the first 10 rows. Because we use db2 we shall use the command fetch first X rows only! 

SELECT * 
FROM CRIMES
FETCH FIRST 10 ROWS ONLY;


--Problem 3:  How many crimes involve an arrest?
--Answer: an arrest is made when the column arrest has the value true thus, we shall count all the rows-instances where an arrest is made!

SELECT COUNT(*) AS TOTAL_CRIMES_ARRESTSV
FROM CRIMES
WHERE  ARREST = 'TRUE' ;

--Problem 4:  Which unique types of crimes have been recorded at a GAS STATION?
--Answer: unique in sql means distinct ! In addition the question asks about incidents happening at Gas stations thus we shall filter our results based on the column LOCATION_DESCRIPTION.

SELECT DISTINCT PRIMARY_TYPE AS UNIQUE_TYPES_OF_CRIMES
FROM CRIMES
WHERE LOCATION_DESCRIPTION = 'GAS STATION' ;


--Problem 5:  In the CENUS_DATA table list all community areas whose names start with the letter ‘B’
--Answer: we shall display all the unique column values that their name shall start with B and then any character shall follow!


SELECT DISTINCT COMMUNITY_AREA_NAME
FROM CENUS_DATA
WHERE COMMUNITY_AREA_NAME LIKE 'B%';


--Problem 6:  List the schools in Community Areas 10 to 15 that are healthy school certified?
--Answer: we shall display all the rows regarding the schools that have a communtiy area number [10,11,12,13,14,15] .


SELECT DISTINCT COMMUNITY_AREA_NAME
FROM CENUS_DATA
WHERE COMMUNITY_AREA_NUMBER BETWEEN 10 AND 15 ;


--Problem 7:  What is the average school Safety Score?
--Answer: a built in function in excel already exists regarding calculating the average so we shall use it.


SELECT AVG(SAFETY_SCORE) AS AVG_SCHOOL_SAFETY
FROM CHICAGO_PUBLIC_SCHOOLS ;


--Problem 8:  list the top 5 Community Areas by average College Enrollments [number of students]
--Answer: we shall display the area name and the average enrollments for each result. In order to list the top 5 areas we shall group them by the name and shall display them based on the average of each value.


SELECT COMMUNITY_AREA_NAME, AVG(COLLEGE_ENROLLMENT)
FROM CHICAGO_PUBLIC_SCHOOLS 
GROUP BY COMMUNITY_AREA_NAME
ORDER BY AVG(COLLEGE_ENROLLMENT)
LIMIT 5 ;

---Problem 9: Use a sub-query to determine which Community Area has the least value for Safety Score?
--Answer: the words 'least value' in sql terms mean find the minimum value of a column. We shall select to display the community area name which shall have the min safety score. We can solve this problem without the use of a subquerry too but, this is an example in order to understand the use of subquerries in general :) 

SELECT DISTINCT COMMUNITY_AREA_NAME
FROM CHICAGO_PUBLIC_SCHOOLS 
WHERE SAFETY_SCORE = (SELECT MIN(SAFETY_SCORE FROM  CHICAGO_PUBLIC_SCHOOLS 
) ;


--Problem 10: Find the Per Capita Income of the Community Area which has a school Safety Score of 1.
--Answer 1: we shall display the per capita income of the census data table where the community are number of this table shall equal the number of the chicago_public_schools table!

SELECT PER_CAPITA_INCOME
FROM CENSUS_DATA
WHERE COMMUNITY_AREA_NUMBER =
                              (
                              	SELECT COMMUNITY_AREA_NUMBER
                              	FROM CHICAGO_PUBLIC_SCHOOLS 
                              	WHERE SAFETY_SCORE =1

                              ) ;

--Answer 2: this solution is a bit more elegant. We use inner jon in order to get the similar values between the 2 tables and we connect them via the column of community are number!

SELECT PER_CAPITA_INCOME
FROM CENSUS_DATA
INNER JOIN CHICAGO_PUBLIC_SCHOOLS 
ON CENSUS_DATA.COMMUNITY_AREA_NUMBER =CHICAGO_PUBLIC_SCHOOLS.COMMUNITY_AREA_NUMBER
WHERE CHICAGO_PUBLIC_SCHOOLS.SAFETY_SCORE =1 ;