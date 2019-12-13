--Lab_8

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
end T_TASK_1;

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
end T_TASK_2;

insert into MENU values(101, 'borsch', 800, 1000, 1, 100, 10);

select * from simple_menu;
-------------------

create or replace trigger T_TASK_3
    before update of mass on MENU
    for each row
declare
begin
    :NEW.calories := :OLD.calories * (:NEW.mass / :OLD.mass);
end T_TASK_3;

update MENU set mass = 500 where ID = 103;

select ID, MASS, CALORIES from menu where ID = 103;

-------------------

create or replace trigger T_TASK_4
    before update of PRICE on MENU
    for each row
declare
    pragma autonomous_transaction;
    min_id MENU.ID%TYPE;
    change_price MENU.PRICE%TYPE;
begin
    select min(ID) into min_id from MENU;
    if :old.ID = min_id then
        change_price := :old.price - :new.price;
        update MENU set price = price - change_price where ID != min_id;
    end if;
    commit;
end T_TASK_4;

update MENU set price = 160 where ID = 101;

select ID, name, price from MENU order by ID ASC;

