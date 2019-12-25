-- Триггер, который при удалении блюда, удаляет связанные с ним записи,
-- а при добавлении, вставляет запись в таблицу ингридиентов

create or replace trigger communication
    after delete or insert
    on MENU
    for each row
declare
    change_id number;
    untitled  VARCHAR2(10) := 'untitled';
begin
    if INSERTING then
        change_id := :new.ID;
        insert into COMPOSITION values (change_id, untitled, 0, 'gram');
    else
        change_id := :old.ID;
        delete from COMPOSITION where ID = change_id;
    end if;
end;

delete
from MENU
where ID = 101;
select *
from COMPOSITION
order by ID;

insert into MENU
values (101, 'borsch', 800, 1000, 1, 150, 10);