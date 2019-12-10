--Вывести название блюда с наибольшим количествои ингридиентов:

select name from MENU inner join COMPOSITION C on MENU.ID = C.ID group by name
having count(*) = (select MAX(count(*)) from COMPOSITION group by ID);