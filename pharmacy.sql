CREATE DATABASE `pharmacy` /*!40100 DEFAULT CHARACTER SET
utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT
ENCRYPTION='N' */;

use pharmacy;
show tables;

create table if not exists store(
 `Name` varchar(50) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
 `Phone_no` bigint(20) DEFAULT NULL,
 `Total_sales` decimal(10,2) DEFAULT NULL,
 `No_Employees` int default null
);

describe store;

create table if not exists employee(
 `Name` varchar(50) DEFAULT NULL,
 `Employee_id` int(10) not null,
  `Address` varchar(50) DEFAULT NULL,
 `Phone_no` bigint(20) DEFAULT NULL,
 `Daily_sales` decimal(10,2) DEFAULT NULL,
 primary key (`Employee_id`)
);

describe employee;

create table if not exists medicine(
 `Name` varchar(50) DEFAULT NULL,
 `Brand` varchar(10) not null,
  `Medicine_id` varchar(10) not null,
  `Price` decimal(10,2) DEFAULT NULL,
  `Exp_month` int default null,
  `MFG_Date`date default null,
 primary key (`Medicine_id`)
);

describe medicine;

create table if not exists inventory(
  `Medicine_id` varchar(10) not null,
  `Total_quantity` bigint(20) DEFAULT 0,
  `Pending_orders` int(10) DEFAULT 0,
 foreign key(`Medicine_id`) references medicine(`Medicine_id`)
);

describe inventory;

create table if not exists `order`(
 `Order_id` int(10)  not null,
 `Employee_id` int(10) not null,
  `Medicine_id` varchar(10)  not null,
 `Daily_sales` decimal(10,2) DEFAULT NULL,
 `Date` date not null,
 primary key (`Order_id`,`Date`),
 foreign key(`Employee_id`) references employee(`Employee_id`),
foreign key(`Medicine_id`) references medicine(`Medicine_id`)
);

describe `order`;

create table if not exists supplied_order(
 `Supplied_id` varchar(10) not null,
  `Medicine_id` varchar(10) not null,
  `Price` decimal(10,2) default 0,
 `Quantity` decimal(10,2) DEFAULT 0,
 primary key (`Supplied_id`),
  foreign key(`Medicine_id`) references medicine(`Medicine_id`)
);

create table if not exists supplier(
 `Name` varchar(50) not null,
 `Supplier_id` varchar(10) not null,
  `Address` varchar(50) DEFAULT NULL,
 `Phone_no` bigint(20) DEFAULT NULL,
  `Supplied_id` varchar(10) not null,
   primary key (`Supplier_id`),
   foreign key(`Supplied_id`) references supplied_order(`Supplied_id`)
);

show tables;

insert into store values("BITS PHARMACY",12345678,"Meera Marg,Pilani",9876543210,0,0.0);

describe employee;
insert into employee values("Yasaswini" ,00001,"MB,Pilani",913365233,0.0);
insert into employee values("Radhika" ,00002,"MB,Pilani",923365233,0.0);
insert into employee values("Nikita" ,00003,"MB,Pilani",914365233,0.0);
insert into employee values("Sanjana" ,00004,"MB,Pilani",913565233,0.0);
insert into employee values("Mangala" ,00005,"MB,Pilani",913375233,0.0);
insert into employee values("Akhil" ,00006,"RB,Pilani",913365833,0.0);
insert into employee values("Arjun" ,00007,"RB,Pilani",913365933,0.0);
insert into employee values("Aditya" ,00008,"GN,Pilani",913385234,0.0);
insert into employee values("Ahaan" ,00009,"BD,Pilani",9133652315,0.0);
insert into employee values("Aryan" ,00010,"KN,Pilani",913365239,0.0);

describe medicine;
insert into medicine values("Dolo","Pfizer","DP0001",60.0,12,'2023-12-09');
insert into medicine values("Paracetamol","Pfizer","PP0001",80.0,18,'2023-12-09');
insert into medicine values("Crocin","Novartis","CN0001",70.0,6,'2023-12-09');
insert into medicine values("Azithral","Novartis","AN0002",90.0,18,'2023-12-09');
insert into medicine values("MontekLC","Cipla","MC0003",50.0,9,'2023-12-09');
insert into medicine values("Brufen","Cipla","BC0006",150.0,10,'2023-12-09');
insert into medicine values("Disprin","Biocon","DB0004",50.0,12,'2023-12-09');
insert into medicine values("Avomin","Biocon","AB0002",40.0,36,'2023-12-09');
insert into medicine values("Cetrizine","Apollo","CA0008",140.0,24,'2023-12-09');
insert into medicine values("Mephthal","Apollo","MA0001",30.0,12,'2023-12-09');

select * from mysql.user;

/*START TRANSACTION
DELIMITER //
CREATE PROCEDURE create_users_for_employees()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE emp_username VARCHAR(50);
  DECLARE emp_password VARCHAR(50);
  DECLARE cur CURSOR FOR SELECT `Name`, `Employee_id` FROM employee;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;


  OPEN cur;

  read_loop: LOOP
    FETCH cur INTO emp_username, emp_password;
    IF done THEN
      LEAVE read_loop;
    END IF;

	SET @sql = CONCAT('CREATE USER \'', emp_username, '\'@\'localhost\' IDENTIFIED BY \'', emp_password, '\'');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END LOOP;
  CLOSE cur;
END//
DELIMITER ;

CALL create_users_for_employees();
rollback;*/

select * from mysql.user;

/*START TRANSACTION
DELIMITER //
CREATE PROCEDURE drop_users_for_employees()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE emp_username VARCHAR(50);
  DECLARE cur CURSOR FOR SELECT `Name` FROM employee;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur;

  read_loop: LOOP
    FETCH cur INTO emp_username;
    IF done THEN
      LEAVE read_loop;
    END IF;

	SET @sql = CONCAT('DROP USER \'', emp_username, '\'@\'localhost\'');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END LOOP;
  CLOSE cur;
END//
DELIMITER ;

CALL drop_users_for_employees();
rollback;*/

select * from mysql.user;
show tables;
describe inventory;



