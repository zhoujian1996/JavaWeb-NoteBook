/*
   外键：引用另一个表中的一列或多lie，被引用的lie应该具有主键约束或唯一性约束，外键用于建立个加强两个表之间的链接。 


*/

create database chapter5;
use chapter5;
create table grade(
	
    id int(4) NOT NULL PRIMARY KEY,
    name varchar(36)

);

create table student(
	
    sid int(4) not null primary key,
    sname varchar(36),
    gid int(4) not null


);


-- 为表添加外键 
-- alter table 表名 add constraint FK_ID foreign key(外键字段名) Reference 外表表名 (主键字段名) 
alter table student add constraint KF_ID foreign key(gid) references grade(id);

-- 删除外键约束  ：解除两个表之间的关联关系 
-- 语法: alter table 表名 drop foreign key 外键名 ；
alter table student drop foreign key KF_ID;

/*
5.2：操作关联表 

*/
alter table student add constraint KF_ID foreign key(gid) references grade(id);
INSERT INTO grade(id,name) values (1,'软件一班');
INSERT INTO grade(id,name) values (2,'软件二班');
-- 由于student表的外键与grade表的主键关联，因此在为student 表添加数据时，gid的值只能器1 或2
insert into  student(sid,sname,gid) values (11,'zj',1);
insert into  student(sid,sname,gid) values (12,'z2',1);
insert into  student(sid,sname,gid) values (1,'z23',1);
insert into  student(sid,sname,gid) values (2,'w',2);
insert into  student(sid,sname,gid) values (3,'e',2);
insert into  student(sid,sname,gid) values (4,'e',2);


-- 删除操作：在两个具有关联关系的表中删除数据时，一定要先删除从表中的数据，然后再删除主表中的数据  。


/*
	链接查询 ：
			在关系型数据库管理系统中，建立表时各个数据之间的关系不确定，通常将每个实体的所有信息存放在一个表中，当查询alter
            数据时，通过链接操作查询多个表中的实体信息，当两个或者多个表中存在意义相同的字段时，便可以通过这些字段对不同的表进行链接查询alter
            链接查询包括：交叉链接查询 、内连接查询、外连接查询 


*/
-- 1、交叉链接
-- 交叉链接返回的结果是被链接的两个表中所有数据行的笛卡尔乘技术alter
-- 语法: select * from 表1 CROSS JOIN 表2 



create table department (
	did int(4) not null primary key,
    dname varchar(36)
);
use chapter5;
desc employee;
create table employee(
	
    id int(4) not null primary key,
    name varchar(36),
    age int(2),
    did int(4) not null
);

INSERT INTO department (did,dname) values (1,'网络部');
INSERT INTO department (did,dname) values (2,'媒体部');
INSERT INTO department (did,dname) values (3,'研发部');
INSERT INTO department (did,dname) values (4,'人事部');

insert into employee (id,name,age,did) values (1,'张三', 20,1);
insert into employee (id,name,age,did) values (2,'张三', 20,1);
insert into employee (id,name,age,did) values (3,'张三', 20,1);
insert into employee (id,name,age,did) values (4,'张三', 20,1);

/**
	内连接：内连接使用比较运算符对两个表中的数据进行比较，并列出与链接条件匹配的数据行，组合成新的记录，
     也就是说在内连接查询中，只有满足条件的记录才能出现在查询结果中。内连接查询的语法格式如下 ：
     select 查询字段 from 表1 JOIN 表2 ON 表1.关系字段 = 表2.关系字段 
*/
use chapter5;
select employee.name,department.dname from department join employee on department.did = employee.did;
/*
	外连接：内连接返回的结果中只包含符合查询条件和连接条件的数据，然而有时还需要包含没有关联的数据，即返回查询结果中
            不仅包含符合条件的数据，而且还包括左表（左连接或左外连接）、右表（右连接或右外连接)或两个表（全外连接)中的所有数据，
            此时就需要使用外连接查询，外连接分为左连接和右连接 
            
            外连接的语法格式：
            SELECT 所查字段 FROM 表1 LEFT|RIGHT|[OUTER] JOIN 表2 ON 表1.关系字段 = 表2.关系字段 WHERE 条件 
            
            在使用左连接和右连接查询时，查询结果是不一致的，具体如下 :
            (1) LEFT JOIN(左连接):返回包括左表中的所有记录和右表中符合连接条件的记录；如果左表中的某条记录在右表中不存在，则在右表中显示为空。 
            (2)RIGHT JOIN(右连接):返回包括右表中的所有记录和左表中国符合连接条件的记录 ；如果游标中的某条记录在左表中没有匹配，则左表将返回空值。
	
*/

Select * from employee;
select * from department;


select department.did,department.dname,employee.name from department left join employee on department.did = employee.did;

/**
	子查询：
		子查询是指一个查询语句嵌套在另一个查询语句内部的查询，他可以嵌套在一个 SELECT、SELECT.....INTO语句、INSERT...INTO等语句中。在执行查询语句中，首先会执行alter
        子查询语句中的语句，然后将返回结果作为外层查询的过滤条件，在子查询中通常可以使用IN,EXISTS、ANY、ALL等操作符 。
*/

-- 带有in关键字子查询
-- 查询存在年龄为20岁的员工的部门 
select * from department where did in (select did from employee where age=20);

-- 带EXISTS关键字的子查询 
-- EXISTS关键字后面的参数可以是任意一个子查询，这个子查询的作用相当于测试，他不产生任何数据，只返回TRUE或FALSE,当返回值为TRUE时，外层查询才会执行 

-- 查询employee表中是否存在年龄大于21岁的员工，如果存在，则查询department表中所有的记录 
select * from department where exists (select did from employee where age>21);

-- 带ANY关键字的子查询 
-- ANY关键字表示满足其中任意一个条件，它允许创建一个表达式对子查询的返回值列表进行比较，只要满足内层子查询中的任意一个比较条件，就会返回一个结果作为外层查询条件 
select * from department where did > ANY (SELECT did from employee);

-- 带ALL关键字的子查询 
-- ALL关键字与ANY有点类似，只不过带ALL关键字的子查询返回的结果需要同时满足所有内层查询条件。
SELECT * FROM department where did>all(select did from employee);

-- 带有比较运算符的子查询 
-- 在前面讲解的ANY关键字和ALL关键字的子查询中使用了“>”比较运算符，子查询中还可以使用 其他的比较运算符，比如 < > >= = !=

-- 查询赵四是 哪个部门的员工
select * from department where did=(select did from employee where name="赵四");



















