alter trigger t_task_1 disable;
alter trigger t_task_2 disable;
alter trigger t_task_3 disable;
alter trigger t_task_4 disable;

create or replace trigger T_TASK_1
    after delete on MENU
    for each row
declare
begin
    delete from COMPOSITION where ID = :OLD.ID;
end;

-------------------

create table simple_menu
(
    name varchar2(20),
    type number(1)
);

create or replace trigger T_TASK_2
    after insert on MENU
    for each row
declare
begin
    insert into simple_menu values (:NEW.name, :NEW.type);
end;

-------------------

create or replace trigger T_TASK_3
    after update on MENU
    for each row
declare
begin
    update MENU set calories = calories * (:NEW.mass / :OLD.mass) where ID = :NEW.ID;
end;

select * from menu order by ID ASC;

update MENU set mass = 500 where ID = 103;
-------------------

