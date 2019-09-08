/*
	3.1 添加数据 
*/

-- 为表中所有字段添加数据 
-- ---通常情况下，向数据表中添加新记录应该包含表中的所有字段，即为表中的所有字段添加数据  
--  语法： insert into 表名 （字段名1 ，字段名2 ，。。。。） values (值1，值2，。。。。） 类型顺序匹配
--           insert into 表名 values (值1，值2，值。。。。)

-- 为表中指定字段添加数据 ：就是在Insert语句中只向部分字段中添加值，而其他字段为表定义时的默认值 
-- --- insert into 表名 （字段名1 ，字段名2 ，。。。。） values (值1，值2，。。。。） 类型顺序匹配

-- 同时添加多条记录 :
-- 	 --- insert into 表名 （字段名1 ，字段名2 ，。。。。） values (值1，值2，。。。。）,(值1，值2，。。。。）,..... 类型顺序匹配

-- 创建库
create database chapter03;

-- 选择使用数据库 
use chapter03;

-- 在数据库中创建一个表student，用于存储学生信息，创建Student
create table student(

id int(4),
name varchar(20) not null,
grade float 
);
-- 使用insert向表中添加数据  
insert into student (id,name,grade) values(100,'aaa',44.5);
select * from student;

-- 添加某些字段alter
insert into student(id,name) values (11,'aa');
Select * from student;


/*3.2更新数据 */
/*
	更新数据就是指对表中存在的记录进行修改，这是数据库常见的操作，比如某个学生改了名字 ，就需要对其记录信息中的name字段值进行修改 
    MySQL中使用UPDATE语句来更新表中的记录 ，其基本的语法格式 
    
    UPDATE 表名 
		SET 字段名1 = 值1，【字段名2=值2】
        [where 条件表达式 ]
*/
SET SQL_SAFE_UPDATES = 0;

select * from student;
insert into student values(1,'a',1);
update student set name='caocao',grade=100 where id=1;

/*   3.3删除数据*/
/*
	删除数据是指对表中存在的记录进行删除。MySql中使用DELETE语句来删除 表中的记录 ，其语法格式如下 ：
    DELETE FROM 表名 [WHERE 条件表达式]
*/











