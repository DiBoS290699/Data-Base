create table N1_R1
(
    CUSTOMER VARCHAR2(50),
    COUNTRY  VARCHAR2(50)
);
create table N1_R2
(
    SUPPLIER VARCHAR2(50),
    CUSTOMER VARCHAR2(50),
    N_ORDER  NUMBER(3),
    PRICE    NUMBER(10)
);
create table N1_R3
(
    N_ORDER NUMBER(3),
    PRODUCT VARCHAR2(50),
    NUMB    NUMBER(10)
);

-----------------------------------------------------------------------------------
--1
select product
from (select product, count(product) as c
      from N1_R2
               join N1_R3 N on N1_R2.N_ORDER = N.N_ORDER
      group by product
     )
where c = 1;


--2
select SUPPLIER
from N1_R2
         join N1_R3 N on N1_R2.N_ORDER = N.N_ORDER
group by SUPPLIER
having sum(numb) = (
    select max(s)
    from (
             select SUPPLIER, sum(numb) as s
             from N1_R2
                      join N1_R3 N on N1_R2.N_ORDER = N.N_ORDER
             group by SUPPLIER));

--3
select SUPPLIER
from N1_R2
where SUPPLIER not in (select SUPPLIER
                       from N1_R2
                                join N1_R3 using (N_ORDER)
                       where product in (select product
                                         from N1_R3
                                                  join N1_R2 using (N_ORDER)
                                         where SUPPLIER = &sup
                                         group by product)
                       group by SUPPLIER)
group by SUPPLIER;

--4
select N.CUSTOMER
from N1_R2 join N1_R1 N on N1_R2.CUSTOMER = N.CUSTOMER
    join (select COUNTRY, AVG(price) as avgp
from N1_R1 join N1_R2 N on N1_R1.CUSTOMER = N.CUSTOMER
group by COUNTRY) n3 on N.COUNTRY = n3.COUNTRY
    where PRICE > avgp;