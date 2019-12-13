--Вывести тип блюда, который имеет больше всего блюд в меню:

select type from MENU group by type having count(*) = (select MAX(count(*)) as max from MENU group by type);
