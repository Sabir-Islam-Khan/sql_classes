
DROP DATABASE IF EXISTS `sql_invoicing`;
CREATE DATABASE `sql_invoicing`; 
USE `sql_invoicing`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE `payment_methods` (
  `payment_method_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `payment_methods` VALUES (1,'Credit Card');
INSERT INTO `payment_methods` VALUES (2,'Cash');
INSERT INTO `payment_methods` VALUES (3,'Bkash');
INSERT INTO `payment_methods` VALUES (4,'Nagad');

CREATE TABLE `clients` (
  `client_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` char(3) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `clients` VALUES (1,'Aarong','Bashundhara','Sadar','RNG','315-252-7305');
INSERT INTO `clients` VALUES (2,'Fresh','Hajiganj','Narayanganj','DHK','304-659-1170');
INSERT INTO `clients` VALUES (3,'Beximco','Savar','dhaka','DHK','415-144-6037');
INSERT INTO `clients` VALUES (4,'Kaji & Kaji','Srimongol','Sylhet','SLT','254-750-0784');
INSERT INTO `clients` VALUES (5,'Ujirpur','Babuganj','Barishal','BRI','971-888-9129');

CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL,
  `number` varchar(50) NOT NULL,
  `client_id` int(11) NOT NULL,
  `invoice_total` decimal(9,2) NOT NULL,
  `payment_total` decimal(9,2) NOT NULL DEFAULT '0.00',
  `invoice_date` date NOT NULL,
  `due_date` date NOT NULL,
  `payment_date` date DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `FK_client_id` (`client_id`),
  CONSTRAINT `FK_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `invoices` VALUES (1,'91-953-3396',2,101.79,0.00,'2019-03-09','2019-03-29',NULL);
INSERT INTO `invoices` VALUES (2,'03-898-6735',5,175.32,8.18,'2019-06-11','2019-07-01','2019-02-12');
INSERT INTO `invoices` VALUES (3,'20-228-0335',5,147.99,0.00,'2019-07-31','2019-08-20',NULL);
INSERT INTO `invoices` VALUES (4,'56-934-0748',3,152.21,0.00,'2019-03-08','2019-03-28',NULL);
INSERT INTO `invoices` VALUES (5,'87-052-3121',5,169.36,0.00,'2019-07-18','2019-08-07',NULL);
INSERT INTO `invoices` VALUES (6,'75-587-6626',1,157.78,74.55,'2019-01-29','2019-02-18','2019-01-03');
INSERT INTO `invoices` VALUES (7,'68-093-9863',3,133.87,0.00,'2019-09-04','2019-09-24',NULL);
INSERT INTO `invoices` VALUES (8,'78-145-1093',1,189.12,0.00,'2019-05-20','2019-06-09',NULL);
INSERT INTO `invoices` VALUES (9,'77-593-0081',5,172.17,0.00,'2019-07-09','2019-07-29',NULL);
INSERT INTO `invoices` VALUES (10,'48-266-1517',1,159.50,0.00,'2019-06-30','2019-07-20',NULL);
INSERT INTO `invoices` VALUES (11,'20-848-0181',3,126.15,0.03,'2019-01-07','2019-01-27','2019-01-11');
INSERT INTO `invoices` VALUES (13,'41-666-1035',5,135.01,87.44,'2019-06-25','2019-07-15','2019-01-26');
INSERT INTO `invoices` VALUES (15,'55-105-9605',3,167.29,80.31,'2019-11-25','2019-12-15','2019-01-15');
INSERT INTO `invoices` VALUES (16,'10-451-8824',1,162.02,0.00,'2019-03-30','2019-04-19',NULL);
INSERT INTO `invoices` VALUES (17,'33-615-4694',3,126.38,68.10,'2019-07-30','2019-08-19','2019-01-15');
INSERT INTO `invoices` VALUES (18,'52-269-9803',5,180.17,42.77,'2019-05-23','2019-06-12','2019-01-08');
INSERT INTO `invoices` VALUES (19,'83-559-4105',1,134.47,0.00,'2019-11-23','2019-12-13',NULL);

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(9,2) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `fk_client_id_idx` (`client_id`),
  KEY `fk_invoice_id_idx` (`invoice_id`),
  KEY `fk_payment_payment_method_idx` (`payment_method`),
  CONSTRAINT `fk_payment_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_payment_method` FOREIGN KEY (`payment_method`) REFERENCES `payment_methods` (`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `payments` VALUES (1,5,2,'2019-02-12',8.18,1);
INSERT INTO `payments` VALUES (2,1,6,'2019-01-03',74.55,1);
INSERT INTO `payments` VALUES (3,3,11,'2019-01-11',0.03,1);
INSERT INTO `payments` VALUES (4,5,13,'2019-01-26',87.44,1);
INSERT INTO `payments` VALUES (5,3,15,'2019-01-15',80.31,1);
INSERT INTO `payments` VALUES (6,3,17,'2019-01-15',68.10,1);
INSERT INTO `payments` VALUES (7,5,18,'2019-01-08',32.77,1);
INSERT INTO `payments` VALUES (8,5,18,'2019-01-08',10.00,2);


DROP DATABASE IF EXISTS `sql_store`;
CREATE DATABASE `sql_store`;
USE `sql_store`;

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `quantity_in_stock` int(200) NOT NULL,
  `unit_price` int(255) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `products` VALUES (1,'Body Lotion',70,125.21);
INSERT INTO `products` VALUES (2,'Handwash',49,40.65);
INSERT INTO `products` VALUES (3,'Sanitizer',38,33.35);
INSERT INTO `products` VALUES (4,'Beef',90,250);
INSERT INTO `products` VALUES (5,'Dairy Milk',94,165.63);
INSERT INTO `products` VALUES (6,'Kitkat',14,50.39);
INSERT INTO `products` VALUES (7,'Mango Juice',98,30.29);
INSERT INTO `products` VALUES (8,'Coka Cola',26,40.74);
INSERT INTO `products` VALUES (9,'Burger',67,120.26);
INSERT INTO `products` VALUES (10,'Pizza',6,200.09);


CREATE TABLE `shippers` (
  `shipper_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`shipper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `shippers` VALUES (1,'Sundarban Courier');
INSERT INTO `shippers` VALUES (2,'SA Paribahan');
INSERT INTO `shippers` VALUES (3,'Vai Vai Transport');
INSERT INTO `shippers` VALUES (4,'Korotoya Transport');
INSERT INTO `shippers` VALUES (5,'Daraz Express');


CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `birth_date` date  DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` char(3) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `customers` VALUES (1,'Rahim','Khan','2000-05-28','01718005609','Mirpur','Dhaka','DHK',2273);
INSERT INTO `customers` VALUES (2,'Latikul','Khabir','1990-12-17','01826487952','Bashundhara','Lalmonirhat','RNG',947);
INSERT INTO `customers` VALUES (3,'Nayem','Farhana','1995-08-25','01716487529','Oxygen','Chittagong','CTG',2967);
INSERT INTO `customers` VALUES (4,'Faizul','Islam','1983-01-06','01687169864','Babugabj','Barishal','BRI',457);
INSERT INTO `customers` VALUES (5,'Sadik','Shammo','1990-01-01',NULL,'Ruppur','Khulna','KHL',3675);
INSERT INTO `customers` VALUES (6,'Ariful','Rifat','2003-03-18','01594658452','Uttora','Dhaka','DHK',3073);
INSERT INTO `customers` VALUES (7,'Muntashir','Morshed','1978-04-06','017658412361','Purbo Para','Rajshahi','RAJ',1672);
INSERT INTO `customers` VALUES (8,'Nasif','Ahmed','1985-11-17','01812365784','Khan Para','Gaibandha','RNG',205);
INSERT INTO `customers` VALUES (9,'Rimu','Prodhan','1999-06-28','01547896541','Banglabandha','Ponchogor','RNG',1486);
INSERT INTO `customers` VALUES (10,'Anjim','Islam','2000-07-05','01765984123','Uttora','Dhaka','DHK',796);


CREATE TABLE `order_statuses` (
  `order_status_id` tinyint(4) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`order_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `order_statuses` VALUES (1,'Processed');
INSERT INTO `order_statuses` VALUES (2,'Shipped');
INSERT INTO `order_statuses` VALUES (3,'Delivered');


CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `comments` varchar(2000) DEFAULT NULL,
  `shipped_date` date DEFAULT NULL,
  `shipper_id` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_orders_customers_idx` (`customer_id`),
  KEY `fk_orders_shippers_idx` (`shipper_id`),
  KEY `fk_orders_order_statuses_idx` (`status`),
  CONSTRAINT `fk_orders_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_order_statuses` FOREIGN KEY (`status`) REFERENCES `order_statuses` (`order_status_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_shippers` FOREIGN KEY (`shipper_id`) REFERENCES `shippers` (`shipper_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `orders` VALUES (1,6,'2019-01-30',1,NULL,NULL,NULL);
INSERT INTO `orders` VALUES (2,7,'2018-08-02',2,NULL,'2018-08-03',4);
INSERT INTO `orders` VALUES (3,8,'2017-12-01',1,NULL,NULL,NULL);
INSERT INTO `orders` VALUES (4,2,'2017-01-22',1,NULL,NULL,NULL);
INSERT INTO `orders` VALUES (5,5,'2017-08-25',2,'','2017-08-26',3);
INSERT INTO `orders` VALUES (6,10,'2018-11-18',1,'Your order is being processed',NULL,NULL);
INSERT INTO `orders` VALUES (7,2,'2018-09-22',2,NULL,'2018-09-23',4);
INSERT INTO `orders` VALUES (8,5,'2018-06-08',1,'Item handed over to delivery partner',NULL,NULL);
INSERT INTO `orders` VALUES (9,10,'2017-07-05',2,'Order being cancelled','2017-07-06',1);
INSERT INTO `orders` VALUES (10,6,'2018-04-22',2,NULL,'2018-04-23',2);


CREATE TABLE `order_items` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` int(255) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_order_items_products_idx` (`product_id`),
  CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `order_items` VALUES (1,4,4,220.74);
INSERT INTO `order_items` VALUES (2,1,2,91.10);
INSERT INTO `order_items` VALUES (2,4,4,110.66);
INSERT INTO `order_items` VALUES (2,6,2,200.94);
INSERT INTO `order_items` VALUES (3,3,10,95.12);
INSERT INTO `order_items` VALUES (4,3,7,66.99);
INSERT INTO `order_items` VALUES (4,10,7,100.40);
INSERT INTO `order_items` VALUES (5,2,3,191.89);
INSERT INTO `order_items` VALUES (6,1,4,88.65);
INSERT INTO `order_items` VALUES (6,2,4,30.28);
INSERT INTO `order_items` VALUES (6,3,4,105.46);
INSERT INTO `order_items` VALUES (6,5,1,220.45);
INSERT INTO `order_items` VALUES (7,3,7,97.17);
INSERT INTO `order_items` VALUES (8,5,2,165.94);
INSERT INTO `order_items` VALUES (8,8,2,252.59);
INSERT INTO `order_items` VALUES (9,6,5,110.28);
INSERT INTO `order_items` VALUES (10,1,10,200.01);
INSERT INTO `order_items` VALUES (10,9,9,225.28);

CREATE TABLE `sql_store`.`order_item_notes` (
  `note_id` INT NOT NULL,
  `order_Id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `note` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`note_id`));

INSERT INTO `order_item_notes` (`note_id`, `order_Id`, `product_id`, `note`) VALUES ('1', '1', '2', 'first note');
INSERT INTO `order_item_notes` (`note_id`, `order_Id`, `product_id`, `note`) VALUES ('2', '1', '2', 'second note');


DROP DATABASE IF EXISTS `sql_hr`;
CREATE DATABASE `sql_hr`;
USE `sql_hr`;


CREATE TABLE `offices` (
  `office_id` int(11) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  PRIMARY KEY (`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `offices` VALUES (1,'Savar','Dhaka','DHK');
INSERT INTO `offices` VALUES (2,'Ashulia','Dhaka','DHK');
INSERT INTO `offices` VALUES (3,'Port','Chittagong','CTG');
INSERT INTO `offices` VALUES (4,'Oxygen','Chittagong','CTG');
INSERT INTO `offices` VALUES (5,'Bahadurpur','Khulna','KHL');
INSERT INTO `offices` VALUES (6,'Somsernagar','Khulna','KHL');
INSERT INTO `offices` VALUES (7,'Sat Matha','Rangpur','RNG');
INSERT INTO `offices` VALUES (8,'Pirganj','Rangpur','RNG');
INSERT INTO `offices` VALUES (9,'Nabab Para','Rajshahi','RAJ');
INSERT INTO `offices` VALUES (10,'Talaimari','Rajshahi','RAJ');



CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `job_title` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `reports_to` int(11) DEFAULT NULL,
  `office_id` int(11) NOT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `fk_employees_offices_idx` (`office_id`),
  KEY `fk_employees_employees_idx` (`reports_to`),
  CONSTRAINT `fk_employees_managers` FOREIGN KEY (`reports_to`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_employees_offices` FOREIGN KEY (`office_id`) REFERENCES `offices` (`office_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `employees` VALUES (37270,'Sabir','Islam','CEO',650000,NULL,10);
INSERT INTO `employees` VALUES (33391,'Ayman','Saaiq','Account Executive',62871,37270,1);
INSERT INTO `employees` VALUES (37851,'Tahsan','Khan','Statistician III',98926,37270,1);
INSERT INTO `employees` VALUES (40448,'Ahmed','Jobayer','Staff Scientist',94860,37270,1);
INSERT INTO `employees` VALUES (56274,'Robiul','Islam','VP Marketing',110150,37270,1);
INSERT INTO `employees` VALUES (63196,'Dhrubo','Roy','Assistant Professor',32179,37270,2);
INSERT INTO `employees` VALUES (67009,'North','de Clerc','VP Product Management',114257,37270,2);
INSERT INTO `employees` VALUES (67370,'Ajijul','Haque','Social Worker',96767,37270,2);
INSERT INTO `employees` VALUES (68249,'Raihan','Islam','Financial Advisor',52832,37270,2);
INSERT INTO `employees` VALUES (72540,'Nobin','Hossaain','Office Assistant I',117690,37270,3);
INSERT INTO `employees` VALUES (72913,'Kass','Hefferan','Computer Systems Analyst IV',96401,37270,3);
INSERT INTO `employees` VALUES (75900,'Korim','Hossain','Information Systems Manager',54578,37270,3);
INSERT INTO `employees` VALUES (76196,'Mridul','Haque','Cost Accountant',119241,37270,3);
INSERT INTO `employees` VALUES (80529,'Shafier','Rahman','Junior Executive',77182,37270,4);
INSERT INTO `employees` VALUES (80679,'Rashidul','Alam','Geologist II',67987,37270,4);
INSERT INTO `employees` VALUES (84791,'Hazel','Tarbert','General Manager',93760,37270,4);
INSERT INTO `employees` VALUES (95213,'Anjim','Islam','Pharmacist',86119,37270,4);
INSERT INTO `employees` VALUES (96513,'Abdul','Rajjak','Food Chemist',47354,37270,5);
INSERT INTO `employees` VALUES (98374,'Yasin','Arafat','Staff Accountant IV',70187,37270,5);
INSERT INTO `employees` VALUES (115357,'Nabab','Shah','Structural Engineer',92710,37270,5);


DROP DATABASE IF EXISTS `sql_inventory`;
CREATE DATABASE `sql_inventory`;
USE `sql_inventory`;


CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `quantity_in_stock` int(11) NOT NULL,
  `unit_price` int(255) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `products` VALUES (1,'Body Lotion',70,125.21);
INSERT INTO `products` VALUES (2,'Handwash',49,40.65);
INSERT INTO `products` VALUES (3,'Sanitizer',38,33.35);
INSERT INTO `products` VALUES (4,'Beef',90,150);
INSERT INTO `products` VALUES (5,'Dairy Milk',94,165.63);
INSERT INTO `products` VALUES (6,'Kitkat',14,50.39);
INSERT INTO `products` VALUES (7,'Mango Juice',98,30.29);
INSERT INTO `products` VALUES (8,'Coka Cola',26,40.74);
INSERT INTO `products` VALUES (9,'Burger',67,120.26);
INSERT INTO `products` VALUES (10,'Pizza',6,200.09);



