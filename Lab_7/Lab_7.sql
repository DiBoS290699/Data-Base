create or replace procedure P_TASK_1
    is
begin
    DBMS_OUTPUT.ENABLE();
    for itr in (select name from MENU
    where MENU.name like 'A%')
        loop
            DBMS_OUTPUT.PUT_LINE(itr.name);
        end loop;
end P_TASK_1;

call P_TASK_1();

--------------------

create or replace procedure P_TASK_2(per_cent in NUMBER)
is
begin
    for itr in (select name, minutes from MENU where type = 2)
        loop
            if itr.minutes > 15 then
                update MENU m set m.PRICE = m.PRICE - per_cent/100*m.PRICE
                where itr.name = m.NAME;
            end if;
        end loop;
end P_TASK_2;

call P_TASK_2(10);

--------------------

create or replace procedure P_TASK_3
is
begin
    for itr in (select ID from COMPOSITION c where c.component = 'cabbage' group by ID)
        loop
            delete from COMPOSITION where ID = itr.ID;
            delete from MENU where ID = itr.ID;
        end loop;
end P_TASK_3;

call P_TASK_3();

--------------------

create table BONUS
(
    ID       NUMBER(3)     not null,
    PRICE    NUMBER(6, 2)  not null
);

create or replace procedure P_TASK_4(bonus_price in NUMBER)
is
max_price number(6,2);
i number := 1;
begin
    loop
        select max(PRICE) into max_price from MENU m where m.type = i;
        insert into BONUS (select ID, bonus_price from MENU where PRICE = max_price);
        i := i + 1;
        exit when i = 4;
    end loop;
end;

call P_TASK_4(5);