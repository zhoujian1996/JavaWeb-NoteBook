/*
	6.2.1创建存储过程 
		
        要想使用存储过程，首先要创建一个存储过程。创建存储过程，需要使用Create PROCEDURE 语句 ，创建存储过程的基本语法格式如下 :
        
        CREATE PROCEDURE sp_name ([proc_parameter])
		[characteristics...] routine_body
        
        (1)CREATE PROCEDURE为用来创建存储过程的关键字
        (2) sp_name 为存储过程的名称 
        (3) proc_parameter:指定存储过程的参数列表  该参数列表的形式如下： [IN|OUT|INOUT] param_name typr
													上述参数列表的形式中，IN表示输入参数，OUT表示输出参数，INOUT表示既可以是输入也可以是输出 ，param_name表示参数的名称 ，type表示参数的类型，它可以是MySql数据库中的数据类型 
                                                    
		(4) characteristics:指定存储过程的特性它的取值具体说明如下： 
				
                LANGUAGE SQL:说明routine_body部分是由SQL语句组成的，当前系统支持的语言为SQL,SQL是LANGUAGE的唯一值 

*/

use chapter6;

CREATE TABLE student(
    id INT(3) primary key auto_increment,
    NAME VARCHAR(20) NOT NULL,
    grade FLOAT,
    gender CHAR(2)
);

INSERT INTO student(name,grade,gender) values('tom',60,'男'),('jack',70,'男');
select * from student;

-- 创建存储过程 

DELIMITER //

CREATE PROCEDURE Proc()

BEGIN

SELECT * FROM student;
end //

/*
	6.2.2变量的使用 
		
        在编写存储过程时，有时会需要使用变量保存数据处理过程中的值。在MySQL中，变量可以在子程序中声明并使用，这些变量的作用范围是在BEGIN------END程序中 
        
        想要在存储过程中使用变量，首先需要定义变量。在存储过程中使用DECLARE语句定义变量，具体语法格式如下 :
        
        DECLARE var_name[,var_name].....date_typr[DEFAULT value)；
        
        在上述语法格式中，var_name为局部变量的名称。DEFAULT value子句给变量提供一个默认值。该值除了可以被声明一个常数以外，还可以被指定为一个表达式。如果没有DEFAULT子句，变量的初始值为null。
        
        接下来定义一个名称为 myvariable的变量，类型为INT类型，默认值为100，示例代码如下： 
        
        DECLARE myvariable INT DEFAULT 100;
        
        定义变量之后，为变量赋值可以改变变量的默认值，MySql中使用SET语句为变量赋值，语法格式如下：
        
        SET var_name = expr[,var_name=expr]......;
        
        
        接下来声明三个变量，分别为var1、Var2、var3，数据类型为INT，使用SET为变量赋值，示例代码如下 ：
        
        DECLARE var1,var2,var3 INT;
        SET var1 = 10，var2 = 20;
        SET var3 = var1+var2;
        
        
        6.2.3定义条件和处理程序 
        在实际开发中，经常需要对特定的条件进行处理，这些条件可以联系到错误以及子程序中的一般流程控制。alter
        
        定义条件：实现定义程序执行过程中遇到的问题alter
        
        处理程序：定义了在遇到这些问题时应当采取的处理方式，并且保证存储过程在遇到警告或错误时能继续执行 。
        
        
        1、定义条件 
        DECLARE condition_name CONDITION FOR [Condition_type];
        
        condition_name:表示所定义的条件名称 
        condition_type:表示条件的类型 
        sqlstate_value和mysql_error_code都可以表示 MySQL错误 
        
        -- 定义ERROR1148(42000)的错误，名称为command_not_allowed。可以用两种不同的方法来定义 ：
        DECALRE command_not_allowed CONDITION FOR SQLSTATE '42000';
        
	
	2、定义处理程序 
		
        定义玩条件后，还需要定义针对此条件的处理程序。MYSQl中使用DECLARE语句定义处理程序，具体语法格式如下：
        
        DECLARE handler_type HANDLER FOR condition_value[,....] sp_statement
        
        handler_type:
				CONTINUE|EXIT|UNDO
		condition_value:
			|condition_name
            |SQLWARNING
            |NOT FOUND
            |SQLEXCEPTION
            |mysql_error_code
            
            handler_type为错误处理方式：参数取三个值：Continue、EXIT、UNDO. 	
													CONTINUE表示遇到错误不处理，继续执行；a
													EXIT:遇到错误马上退出 
                                                    UNDO:表示遇到错误撤回之前的错误 
			
            condition_value:表示错误类型 

*/






















