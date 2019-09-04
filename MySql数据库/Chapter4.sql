/*  单表查询 */
/*  
	MySQL从数据表中查询数据的基本语句是SELECT语句。在SELECT语句中，可以根据自己 
    对数据的要求，使用不同的查询条件，SELECT语句的基本语法格式如下:
    
    SELECT [DISTINCT] *|字段名1，字段名2，字段名3，。。。
    FROM 表名
    where 条件表达式1
    GROUP BY 字段名 HAVING 条件表达式2
    ORDER BY 字段名 [ASC|DESC】
	LIMIT OFFSET 记录数
    
    (1) DISTINCT:用于剔除查询结果中重复的数据 
    (2) GROUP BY:用于将查询结果按照指定字段进行分组 
    (3)HAVING:用于对分组后的结果进行过滤
    (4)ORDER BY:用于将查询结果按照指定字段进行排序
    (5)LIMIT OFFSET 记录数 ：用于限制查询的数量，
				 OFFSET:表示偏移量，如果偏移量为0，则从查询结果的第一条记录开始
                 记录数：表示返回查询记录的条数 
    
*/

-- 1、查询所有字段  
--  语法：select  * from 表名alter
create database chapter04;
use chapter04;
CREATE TABLE student(
	id int(3) primary key auto_increment,
    name VARCHAR(20) NOT NULL,
    grade FLOAT,
    gender char(2)
);

insert into student(name,grade,gender) values ('songjiang',40,'男'),
 ('wuyong',100,'男'), ('qinming',90,'男'), ('husanniang',88,'女'), ('sunerniang',66,'女'),
  ('wusong',86,'男'), ('linchong',82,'男'), ('yangqing',90,null);

--  查询表中的所有记录的所有字段  
-- 一般情况下，除非需要使用表中所有字段的数据，没否则最好不要使用*通配符，使用通配符虽然可以节省输入查询语句的时间，但由于获取的数据过多会降低查询的效率 
select * from  student;

-- 2 按条件查询 
-- 数据库中包含大量的数据，很多时候需要根据需求获取指定的数据，或者对查询的数据进行排列组合，
-- 这时就要在SELECT语句中指定查询条件对查询结果进行过滤 

-- 带关系运算符的查询 
-- 在SELECT语句中，最常见的是使用WHERE子句指定查询条件对数据进行过滤 
/*
	其语法格式如下: 
		SELECT 字段名1，字段名2，。。。。
        FROM 表名
        WHERE 条件表达式 
        
        (1)带关系运算符  < > = !=
        
        (2) 带in关键字的查询 ：IN 关键字用于判断某个字段是否在指定的集合中，如果字段的值在集合中，则满足条件，该字段所在的记录将被查询出来 
			SELECT *|字段名1，字段名2.。。
            FROM 表名 
            WHERE 字段名 [NOT] IN (元素1，元素2.。。）
            
		(3) BETWEEN....AND 关键字查询  ：用于判断某个字段的值是否在指定的范围之内，如果字段的值在指定的范围内，则被查询出来，反之 
        SELECT *|字段名1，字段名2.。。。
        FROM 表名
        WHERE 字段名 BETWEEN 值1 AND 值2 
        
        (4)空值查询 
        SELECT * |字段名1，字段名2.。。
        FROM 表名
        WHERE 字段名 is [NOT] NULL
        
        (5)distinct：去掉重复记录的字段 
        SELECT DISTINCT 字段名 from 表名
        作用于多个字段，只有DISTINCT关键字后指定的多个字段值都相同，才会被认作是重复的记录 ，
        
        （6） 带LIKE关键字的查询 
        SELECT *|字段名1，字段名2，。。
        FROM 表名
        WHERE 字段名 [NOT] LIKE "匹配字符串"
        
        匹配字符串指定用来匹配的字符串，其值可以是一个普通字符串，也可以是包含百分号（%)和下划线(_)的通配字符串。
		①百分号匹配：匹配任意长度的字符串，包括空字符串，例如： c%:匹配以字符c开始，任意长度的字符串 
        ②下换线通配符: 只匹配单个字符，如果要匹配多个字符，需要使用多个下划线通配符。例如：
        
		（7）带AND关键字的多条件查询 ：使用AND关键字可以连接两个或者多个查询条件，只有满足所有条件的记录才会被返回 
        SELECT *|表达式1，表达式2，
        FROM 表名
        WHERE 条件表达式1 AND 条件表达式2 [....AND 表达N]
        
        (8)带有or关键字的多条件查询 
        SELECT *|表达式1，表达式2，
        FROM 表名
        WHERE 条件表达式1 OR  条件表达式2 [....AND 表达N]
        
*/

-- 查询学生表中id为4的学生姓名，SQL语句如下所示:
select * from student where id =4;

-- 查询学生姓名为 wusong的 学生性别‘alter
select gender from student where name ='wusong';

-- 查询student表中grade大于80的学生姓名 
select name from student where grade>80;


-- 查询student表中Id 值为1、2、3的记录 
select * from student where id in (1,2,3);

-- 查询 student表中id的值在2~5之间学生姓名 
select name from student where id between 2 and 5;


select distinct gender from student;

-- 百分号匹配 查找student 表中name字段值以s开头的学生 id
select id ,name from student where name like "s%";

-- 查找student表中name字段值以符号“w”开始，以字符"g"结束的学生id
select * from student where name like "w%g";

-- 查找alter
select id,name,gender from student where id<5 and gender="女";

select * from student where id in (1,2,3,4) and name like "%ng" and grade<80;

/*
4.3
	高级查询 ：
			聚合函数:s实际开发中，经常需要对数据进行统计，例如统计某个字段的最大值、最小值、平均值等，为此MYSQL中提供了一些函数来实现这些功能。
            这些函数 用于对一组值进行统计，并返回唯一的值，这些函数被称为聚合函数。 
            
            （1） COUNT()  用来统计记录的条数 
             (2) SUM() 求和函数:用于求出表中某个字段所有值的总和alter
             (3) AVG函数：用于求出某个字段所有值的平均值 
             (4)MAX函数:求最大值函数，用于求某个字段的最大值 
             (5)MIN函数：求最小值函数，用于求出某个字段吧最小值 
             
             
             


*/
select sum(grade) from student;
use chapter04;
select avg(grade) from student;
/*
	对查询结果排序 :
				从表照中查询出来的数据可能是无序的，或者其排列顺序不是用户期望的。为了使查询结果满足用户的需求，可以使用 ORDER BY对查询alter
                结果进行排序：alter
                
                SELECT 字段名1，字段名2.。。。
                FROM 表名
                ORDER BY 字段名1[ASC|DESC] ,字段名2[ASC|DESC] 
			
	 note:在按照指定字段进行升序统计时，如果某条记录的字段值为null，则这条记录会在第一条显示，这是因为NULL值可以被认为是最小值 
                
                
*/


/*分组查询：alter
	在MySql中，可以使用GROUP BY按某个字段或者多个字段中的值进行分组，字段中值相同的为一组，其语法格式如下:
    SELECT  字段名1，字段名2，。。。。
    FROM 表名 
    GROUP BY 字段名1，字段名2 [HAVING 条件表达式 ]
    在上面的语法格式中，指定的字段名1、字段名2等是对查询结果分组的依据。alter
    HAVING 关键字指定条件表达式对分组后的内容进行过滤。需要特别注意的是，GROUP BY一般和聚合函数一起使用，如果查询的字段出现在GROUP BY
    后，却没有包含在聚合函数中 ，该字段显示的是分组后的第一条记录的值，这样有可能会导致查询结果不符合我们的预期。
*/

-- 1、单独使用 GROUP BY分组 
SELECT * FROM STUDENT GROUP BY gender;
-- 分析：查询结果按照gender字段中不同的值来分类，然而这样的查询结果只显示每个分组中的一条记录，意义不大，一般情况下 GROUP BY都和聚合函数一起使用 

-- 2、GROUP BY和聚合函数一起使用 
-- GROUP BY和聚合函数一起使用，可以统计出某个或者某些歌字段在一个分组中的最大值、最小值、平均值等。
-- 例：将student表按照gender字段值进行分组查询，计算出每个分组中各有多少名学生 
select gender, count(*) from student group by gender;

-- 3、GROUP BY和HAVING关键字一起使用 
-- HAVING 关键字和WHERE关键字的作用相同，都用于设置条件表达式对查询结果进行过绿，两者的区别在于，HAVING关键字后可以跟聚合函数，而WHERE关键字不能 
-- 通常情况下HAVING关键字都和GROUP BY一起使用，用于对分组后的结果进行过滤 。
-- 例:将student 表按照gender字段进行分组查询，查询出grade字段值之和小于300的分组
select sum(grade),gender from student group by gender having sum(grade)<300;

-- 4、使用LIMIT限制查询结果的数量 
/*
	SELECT 字段名1，字段名2.。。。
    FROM  表名 
    LIMIT [OFFSET] 记录数 
*/

-- 例查询student表中的前4条记录，SQL语句如下:a
select * from student limit 4;

-- 查询student表中grade字段值从第5为到第8位的学生从高到底alter
select * from student order by grade desc limit 4,4;

/*
 函数： 
	MySQL中提供了丰富的函数，通过这些函数可以简化用户对数据的操作。MYSQL中的函数包括数学函数、字符串函数、日期和时间函数、条件判断函数、加密函数等 
    
    常见函数 ：
		ABS(X):绝对值
        SIGN(X):返回x的符号，-1,0或者1 
        Length(str) 返回字符串的长度 
        CONTACT(s1,s2,s3...)返回一个或者多个字符串连接产生的新字符串 
        TRIM(str)删除字符串两侧的空格 
        
        //条件判断函数 
        IF(EXPR,v1,v2) :如果expr表达式为true返回v1,否则返回v2
        IFNULL(v1,v2):如果v1不为空返回v1否则返回v2
        CASE expr WHEN v1 THEN r1 [WHEN v2 THEN r2....] [ELSE rn] end :如果expr值等于v1,v2等，则返回对应位置THEN后面的结果，否则返回ELSE后面的结果 

*/

























