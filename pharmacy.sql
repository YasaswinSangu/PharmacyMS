drop database pharmacy;
CREATE DATABASE `pharmacy` /*!40100 DEFAULT CHARACTER SET
utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT
ENCRYPTION='N' */;

use pharmacy;
show tables;

create table if not exists store(
 `Name` varchar(50) DEFAULT NULL,
 `Store_id` int(10) not null,
  `Address` varchar(50) DEFAULT NULL,
 `Phone_no` bigint(20) DEFAULT NULL,
 `Total_sales` decimal(10,2) DEFAULT 0 null,
 `No_Employees` int default 0 null,
 primary key (`Store_id`)
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
  `Cost` decimal(10,2) DEFAULT NUll,
  `Exp_Date`date default null,
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
 `Quantity` int(10) not null,
 `Date` date not null,
 primary key (`Order_id`,`Medicine_id`),
 foreign key(`Employee_id`) references employee(`Employee_id`),
foreign key(`Medicine_id`) references medicine(`Medicine_id`)
);


describe `order`;
show tables;
describe store;
select * from store;

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

insert into medicine values("Dolo","Pfizer","DP0001",50.0,40.0,'2023-12-09');
insert into medicine values("Paracetamol","Pfizer","PP0001",100.0,80.0,'2023-12-09');
insert into medicine values("Crocin","Novartis","CN0001",50.0,30.0,'2023-12-09');
insert into medicine values("Azithral","Novartis","AN0002",100.0,90.0,'2023-12-09');
insert into medicine values("MontekLC","Cipla","MC0003",50.0,40.0,'2023-12-09');
insert into medicine values("Brufen","Cipla","BC0006",100.0,70.0,'2023-12-09');
insert into medicine values("Disprin","Biocon","DB0004",50.0,30.0,'2023-05-05');
insert into medicine values("Avomin","Biocon","AB0002",100.0,80.0,'2023-12-09');
insert into medicine values("Cetrizine","Apollo","CA0008",50.0,45.0,'2023-12-09');
insert into medicine values("Mephthal","Apollo","MA0001",100.0,60.0,'2023-12-09');

select * from mysql.user;
select * from mysql.user;
show tables;

create table if not exists supplier(
 `Name` varchar(50) not null,
 `Supplier_id` varchar(10) not null,
  `Address` varchar(50) DEFAULT NULL,
 `Phone_no` bigint(20) DEFAULT NULL,
   primary key (`Supplier_id`)
);

show tables;
describe inventory;
select * from inventory;


insert into inventory(`Medicine_id`,`Total_quantity`,`Pending_orders`) values
('DP0001',50,5),
('PP0001', 100, 10),
('CN0001', 200, 20),
('AN0002', 300, 30),
('MC0003', 400, 40),
('BC0006', 500, 50),
('DB0004', 600, 60),
('AB0002', 700, 70),
('CA0008', 800, 80),
('MA0001', 900, 90);

begin;
CREATE TRIGGER  update_inventory
AFTER INSERT ON `order` FOR EACH ROW 
UPDATE inventory SET Total_quantity = Total_quantity - NEW.Quantity WHERE
medicine_id = NEW.medicine_id;	  

CREATE TRIGGER update_employee
AFTER INSERT ON `order` FOR EACH ROW
UPDATE employee SET Daily_sales = Daily_sales +((SELECT Price 
FROM `order` natural join medicine
 WHERE medicine_id = NEW.medicine_id)*NEW.Quantity) WHERE 
employee.employee_id = NEW.employee_id; 
        
DELIMITER $$
CREATE PROCEDURE insert_order(
    IN order_id INT,
    IN employee_id INT,
    IN medicine_id VARCHAR(10),
    IN quantity INT,
    IN order_date DATE
)
BEGIN
    DECLARE total_qty INT;
SELECT 
    Total_quantity
INTO total_qty 
FROM
    inventory
WHERE
    inventory.Medicine_id = medicine_id;

    IF quantity <= total_qty THEN
        INSERT INTO `order`(`Order_id`, `Employee_id`, `Medicine_id`, `Quantity`, `Date`)
        VALUES(order_id, employee_id, medicine_id, quantity, order_date) ;
    ELSE 
        INSERT INTO `order`(`Order_id`, `Employee_id`, `Medicine_id`, `Quantity`, `Date`)
        VALUES(order_id, employee_id, medicine_id,total_qty, order_date); 
        
	/*ALTER TABLE inventory
	MODIFY COLUMN Pending_orders INT(10) 
	AS (inventory.Pending_orders+Total_quantity - (SELECT (Quantity) 
	FROM `order` WHERE `order`.Medicine_id = inventory.Medicine_id));*/
    END IF;
    
END$$
DELIMITER ;

  commit;
  rollback;
  call insert_order(0001, 00001, 'DP0001',55,'2023-04-01');
  call insert_order(0002, 00002, 'PP0001',75, '2023-04-02');
  call insert_order(0003, 00003, 'MC0003',180,'2023-04-03');
  call insert_order(0004, 00004, 'DB0004',24,'2023-04-04');
  call insert_order(0005, 00005, 'MA0001',8, '2023-04-05');
  call insert_order(0006, 00006, 'CN0001',50,'2023-04-06');
  call insert_order(0007, 00007, 'BC0006',100,'2023-04-07');
  call insert_order(0008, 00008, 'CA0008',30,'2023-04-08');
  call insert_order(0009, 00009, 'AN0002',70,'2023-04-09');
  call insert_order(0010, 00010, 'AB0002',18,'2023-04-10');
  
select * from 	`order`;
  INSERT INTO `supplier` (`Name`, `Supplier_id`, `Address`, `Phone_no`)
VALUES
  ('ABC Pharmaceuticals', 'SUP001', '123 Main St, Anytown', 1234567890),
  ('XYZ Healthcare', 'SUP002', '456 First Ave, Somewhere', 2345678901),
  ('PQR Drugs', 'SUP003', '789 Fifth St, Nowhere', 3456789012),
  ('MNO Pharma', 'SUP004', '1010 Tenth Ave, Everywhere', 4567890123),
  ('LMN Medicines', 'SUP005', '1212 Twelfth St, Anytown', 5678901234),
  ('EFG Pharma', 'SUP006', '1414 Fourteenth Ave, Somewhere', 6789012345),
  ('HIJ Healthcare', 'SUP007', '1616 Sixteenth St, Nowhere', 7890123456),
  ('UVW Drugs', 'SUP008', '1818 Eighteenth Ave, Everywhere', 8901234567),
  ('STU Pharmaceuticals', 'SUP009', '2020 Twentieth St, Anytown', 9012345678),
  ('RST Medicines', 'SUP010', '2222 Twenty-second Ave, Somewhere', 1234567890);
  
  
  /* QUERY 1 - TO find the stock level of a Medicine X */
  
  SELECT NAME,sum(Total_quantity) as Total_quantity FROM 
  medicine NATURAL JOIN inventory
  GROUP BY NAME;
  
  /* QUERY 2 Medicines expiring in next 30 days */
  
SELECT * FROM medicine 
WHERE DATEDIFF(Exp_Date, NOW()) <= 30 
AND DATEDIFF(Exp_Date, NOW()) >= 0;

/* QUERY 3 Units of Medicines sold in last 30 days  */

SELECT sum(quantity) from `order`
where DATEDIFF(Date, NOW()) <= 0;

/* QUERY 4  Out of Stock medicines*/
SELECT NAME FROM 
medicine natural join inventory 
WHERE Total_quantity<=0;

/* QUERY 5  Frequently sold medications */

  SELECT NAME,count(Date) as frequency FROM 
  medicine NATURAL JOIN `order`
  GROUP BY NAME
  ORDER BY frequency DESC;
  
/* QUERY 6 Total Inventory Value */

 Select sum(Total_quantity) FROM INVENTORY;
 Select * from employee;
 
 /* QUERY 7 Average Monthly sales for past six months */
 
 SELECT sum(`Sale_Per_Month`)/6 
 FROM (SELECT YEAR(`order`.`Date`) AS `Year`, MONTH(`order`.`Date`) AS `Month`, AVG(`order`.`Quantity` * (`medicine`.`price`))
AS `Sale_Per_Month`
FROM `order` JOIN `medicine` ON `order`.`Medicine_id` = `medicine`.`Medicine_id`
GROUP BY YEAR(`order`.`Date`), MONTH(`order`.`Date`)
ORDER BY YEAR(`order`.`Date`), MONTH(`order`.`Date`) ) 
AS `Average_six_Months`;

 /* QUERY 9 Medicines with highest profit */
 
SELECT m.Name, (m.Price - m.Cost) * o.Quantity AS profit
FROM medicine m
JOIN `order` o ON m.Medicine_id = o.Medicine_id
ORDER BY profit DESC;

/* QUERY 10 Medicines with lowest turnover rate */


/* QUERY 11 Employees with highest sakes */

SELECT NAME,Daily_sales from employee 
order by Daily_sales DESC;











 






