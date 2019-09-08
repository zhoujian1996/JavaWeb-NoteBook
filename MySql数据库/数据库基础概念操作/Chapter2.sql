/*第二章*/

/*    2.1*/

# 创建数据库
Create database itcast;

# 查看所有数据库
show databases;

#查看创建好的额数据库的信息alter
show create database itcast;

# 修改数据库 


#删除数据库 
Drop database itcast;

/*   2.2数据类型 */
/*  使用Mysql数据库存储数据时，不同的数据类型决定了MySql存储数据方式的不同。为此，MySql数据库提供了多种数据类型，其中包括整数类型、浮点类型、定点数类型、日期和时间类型、自符串类型和二进制类型 */


/*2.3 数据表的基本操作*/
/*创建数据表的基本语法格式如下：*/
/*
	CREATE TABLE 表名（
    
		字段名1  数据类型[完整性约束条件]，
		字段名2 数据类型[完整性约束条件]，
		。。。。。
        字段名n 数据类型[完整性约束条件]
    ）;

*/

/*   例子2-6:创建一个用于存储学生成绩的表tb_grade*/

-- 创建库
create database itcast;

-- 选择库alter
use itcast;

-- 创建表 
create table tb_grade(
	
    id INT(11),
    name VARCHAR(20),
    grade FLOAT
);

SHOW tables;

/*  2.3.2查看数据表*/
-- 方式1： 使用SHOW CREATE TABLE查看数据表 
show create table tb_grade;

-- 方式2： 使用desc语句查看数据表 (推荐使用这种)
DESCRIBE tb_grade;

/*  2.3.3修改数据表 */
-- 在MySql中，修改数据表的操作都是使用 ALTER TABLE语句

-- 1、修改表名: ALTER TABLE 旧表名 Rename 新表名alter
ALTER TABLE tb_grade Rename  grade;
show tables;

-- 2、修改字段名：ALTER  TABLE 表名 CHANGE 旧字段名 新字段名 新数据类型；alter
ALTER TABLE grade CHANGE name username varchar(20);
desc grade;

-- 3、修改字段的数据类型 ： alter table 表名 MODIFY 字段名 数据类型;
ALTER TABLE grade MODIFY id int(20);
desc grade;

-- 4、添加字段:  alter table 表名 add 新字段名 数据类型 [约束条件] [FIRST|AFTER 已存在字段名]
--  FIRST为可选参数:将新添加的字段设置为表的第一个字段；AFTER 也为可选参数用于将新添加的字段添加到指定“已存在字段名”的后面 
ALTER TABLE grade add age int(10);
desc grade;

--  5、删除字段: ALTER TABLE 表名 DROP 字段名 ；
ALTER TABLE grade drop age;
desc grade;

-- 6、删除数据表 在Mysql中，直接使用DROP TABLE 语句就可以删除没有被其他表关联的数据表alter
drop table grade;
show tables;

/**   2.4 表的约束**/
-- 为了防止数据表中插入错误的数据，在MySql中，定义了  一些维护数据库完整性的规则，即表的约束 
-- PRImaryKEY   主键约束，用于唯一标志对应的记录 
-- FOREIGN KEY  外键约束 
-- NOT NULL    非空约束 
-- UNIQUE 唯一性约束 
-- DEFAULT 默认值约束，用于设置字段的默认值  


--  在Mysql中，为了快速查找表中的某条数据，可以通过设置主键来实现。主键约束是通过 PRIMARY_KEY定义的，他是唯一标识表中的记录，这就好比身份证可以用来标志身份一样 
-- 每个数据表中最多只能有一个主键约束 
--  ------单字段主键 ：由一个字段构成的主键 
create table exmaple01(
  id int(10) primary key,
  age int
);
desc exmaple01;

-- -------多字段主键 ：多个字段组合而成的主键  语法  PRIMARY KEY (字段名1 ，字段名2，字段名3.。。。)
create table exmaple03(
stu_id int(10) ,
course_id int(10),
age varchar(10),
primary KEY(stu_id,course_id)
);
desc exmaple03;


-- 非空约束  
-- 非空约束值得是字段的值不能为NULL,在MySql中，非空约束是通过NOT NULL定义的，其基本语法:
-- 字段名 数据类型 NOT NULL;
create table exmpale04 (
	name int(10) not null
);
desc exmpale04;

-- 唯一约束 
-- 唯一约束用于保证数据表中字段的唯一性，即表中字段的值不能重复出现。唯一约束是通过UNIQUE定义的，其基本语法格式如下:'
-- 字段名 数据类型  UNIQUE;
CREATE TABLE exmpale05(
stu_id int(10) unique
);
desc exmpale05;


-- 默认约束 
-- 默认约束用于给数据表中的字段指定默认值，即当在表中插入一条记录时，如果 没有给这个字段赋值，那么数据库系统会自动为这个字段插入默认值。alter
-- 默认值是通过DEFAULT关键字定义 
-- 字段名 数据类型 DEFAULT morenzhi 
create TABLE exmpale06(
	id int primary key,
    grade int default 0
);
desc exmpale06;

-- 设置表的字段值自动增加alter
-- 使用 AUTO_INCREMENT设置表字段值自动增加的基本语法:alter
-- 字段名 数据类型 AUTO_INCREMENT

/*  2.6索引 * /
-- 数据库的索引好比新华字典的音序表，他是对数据库表中的一列或多列的值进行排序后的一种数据结构 
-- 普通索引 ：由KEY或INDEX定义的索引，他是Mysql的基本索引类型，可以创建在任何的数据类型 中，其值是否唯一和非空由字段本身的约束条件锁决定 。例如：在rade 表中的stu_id字段上建立一个普通的索引alter
--           查询记录时，就可以根据索引进行查询。  

-- 唯一性索引  ：由UNIQUE定义的索引，该索引所在字段的值必须是唯一的 

-- 单列索引 : 指在单个字段上建立的索引 

-- 多列索引:  在表中多个字段上创建索引 
-- 需要注意的是 ，虽然索引可以提高数据的查询速度，但索引会占用一定的磁盘空间，并且在创建和维护索引时，其消耗的时间 是随着数据量的增加而增加的。 


/*  
	创建索引 
    要想使用索引提高数据表的访问速度，首先要创建一个索引。创建索引的方式有三种alter
    1、创建表的时候创建索引 
    CREAATE TABLE 表名 (字段名 数据类型[完整性约束条件]，
                        
                        字段名，数据类型[完整性约束条件]，
                        。。。。
                        
                        [UBIQUE|FULLTEXT|SPATITAL] INDEX|KEY
                        [别名] （字段名1 [(长度)]） [ASC|DESC]
    
    
    );
*/

-- 1）创建普通索引 
create table t1(

id int,
name varchar(20),
score float,
index (id) --  创建索引
);

desc t1;
show create table t1;

-- 2）创建唯一性索引 
create table t2(
 id int not null,
 name varchar(20) not null,
 score float,
 UNIQUE INDEX unique_id(id ASC)


);
desc t2;

-- 3)创建全文索引 
create table t3(

id int not null,
name varchar(20) not null,
score float,
FULLtext INDEX fulltext_name(name)

) engine = MyISAM;

-- 4)创建单列索引 
create table t4(

name varchar(20) not null,
score float,
index single_name(name(20))

);

-- 5)创建多列索引 
create table t5(
id int not null,
name varchar(20) not null ,
index multi(id,name(20))

);


-- 删除索引 
-- ALTER TABLE 表名 DROP INDEX 索引名 
-- DROP INDEX 索引名 ON  表名;


























