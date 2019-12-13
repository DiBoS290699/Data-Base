--Вывести название блюд, которые не содержат любой ингридиент из заданного блюда

select name from menu inner join composition on MENU.ID = COMPOSITION.ID
    where name not in (select name from menu inner join composition on MENU.ID  = COMPOSITION.ID
        where COMPONENT IN (select component from COMPOSITION where ID = &NUMB_ID) group by name) group by name;