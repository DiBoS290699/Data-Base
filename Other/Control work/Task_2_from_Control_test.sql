--1
select ФИО from R1 group by ФИО having count(ФИО) > 3;

--2
select заболевание from R1 group by заболевание having count(заболевание) = 
	(select max(count(заболевание)) from R1 group by заболевание)

--3
select ФИО from R1 where ФИО not in 
	(select ФИО from R1 inner join R2 on id = id where процедура in 
		(select процедура from R2 where id = &id_нужного_пациента) );

--4
select count(*) from R2 where отметка о выполнении = false; 
--т.е. отметка = false если пациент не проходил процедуру