--������� �������� ����� � ���� � �������, 
--������ ��� ���� ������ 1 ������ 2018 ���� ������ ����� �������� null � ������:

--R1(Book, ID)
--R2(ID, I_Date)

---------------------------------------

create table R1
(
    Book VARCHAR2(50),
    ID NUMBER primary key
);

create table R2
(
    ID number,
    I_DATE date
);

select R1.Book, R2.I_DATE from R1 inner join R2 on R1.ID = R2.ID where I_DATE >= '1.01.2018' UNION ALL
select R1.Book, NULL from R1 inner join R2 on R1.ID = R2.ID where I_DATE < '1.01.2018';
