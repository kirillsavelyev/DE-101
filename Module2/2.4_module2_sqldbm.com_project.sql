
CREATE SCHEMA dw;


-- ************************************** calendar

CREATE TABLE dw.calendar
(
 dateid   serial NOT NULL,
 year     int NOT NULL,
 quarter  int NOT NULL,
 month    int NOT NULL,
 week     int NOT NULL,
 "date"     date NOT NULL,
 week_day varchar(20) NOT NULL,
 leap     varchar(20) NOT NULL,
 CONSTRAINT PK_calendar_dim PRIMARY KEY ( dateid )
);


-- ************************************** customer

CREATE TABLE dw.customer
(
 cust_id       serial NOT NULL,
 customer_id   varchar(8) NOT NULL,
 customer_name varchar(22) NOT NULL,
 CONSTRAINT PK_customer_dim PRIMARY KEY ( cust_id )
);


-- ************************************** geo

CREATE TABLE dw.geo
(
 geo_id      serial NOT NULL,
 country     varchar(13) NOT NULL,
 city        varchar(17) NOT NULL,
 "state"       varchar(20) NOT NULL,
 postal_code varchar(20) NULL,
 CONSTRAINT PK_geo_dim PRIMARY KEY ( geo_id )
);


-- ************************************** product

CREATE TABLE dw.product
(
 prod_id      serial NOT NULL,
 product_id   varchar(50) NOT NULL,
 product_name varchar(127) NOT NULL,
 category     varchar(15) NOT NULL,
 sub_category varchar(11) NOT NULL,
 segment      varchar(11) NOT NULL,
 CONSTRAINT PK_product_dim PRIMARY KEY ( prod_id )
);


-- ************************************** shipping

CREATE TABLE dw.shipping
(
 ship_id       serial NOT NULL,
 shipping_mode varchar(14) NOT NULL,
 CONSTRAINT PK_shipping_dim PRIMARY KEY ( ship_id )
);


-- ************************************** sales_fact

CREATE TABLE dw.sales_fact
(
 sales_id      serial NOT NULL,
 order_id      varchar(25) NOT NULL,
 sales         numeric(9,4) NOT NULL,
 profit        numeric(21,16) NOT NULL,
 quantity      int4 NOT NULL,
 discount      numeric(4,2) NOT NULL,
 geo_id        integer NOT NULL,
 cust_id       integer NOT NULL,
 ship_id       integer NOT NULL,
 prod_id       integer NOT NULL,
 order_date_id integer NOT NULL,
 ship_date_id  integer NOT NULL,
 CONSTRAINT PK_sales_fact PRIMARY KEY ( sales_id ),
 CONSTRAINT FK_56 FOREIGN KEY ( geo_id ) REFERENCES geo ( geo_id ),
 CONSTRAINT FK_59 FOREIGN KEY ( cust_id ) REFERENCES customer ( cust_id ),
 CONSTRAINT FK_62 FOREIGN KEY ( ship_id ) REFERENCES shipping ( ship_id ),
 CONSTRAINT FK_65 FOREIGN KEY ( prod_id ) REFERENCES product ( prod_id ),
 CONSTRAINT FK_68 FOREIGN KEY ( order_date_id ) REFERENCES calendar ( dateid ),
 CONSTRAINT FK_72 FOREIGN KEY ( ship_date_id ) REFERENCES calendar ( dateid )
);

CREATE INDEX fkIdx_57 ON sales_fact
(
 geo_id
);

CREATE INDEX fkIdx_60 ON sales_fact
(
 cust_id
);

CREATE INDEX fkIdx_63 ON sales_fact
(
 ship_id
);

CREATE INDEX fkIdx_66 ON sales_fact
(
 prod_id
);

CREATE INDEX fkIdx_69 ON sales_fact
(
 order_date_id
);

CREATE INDEX fkIdx_73 ON sales_fact
(
 ship_date_id
);

