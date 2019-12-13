--В процедуру передаётся масса и сумма, на которую изменится стоимость блюда,
--если изначальная масса блюда меньше передаваемой, то из стоимости блюда отнимается сумма,
-- если больше, то прибавляется,
-- если равны, то ничего не происходит

create or replace procedure ADD_TASK
    (check_mass in NUMBER, sum in NUMBER)
    IS
    begin
        for itr in (select * from MENU)
            loop
                if (itr.MASS < check_mass) then
                    update MENU set price = price - sum where ID = itr.ID;
                ELSIF (itr.MASS > check_mass) then
                    update MENU set price = price + sum where ID = itr.ID;
                end if;
            end loop;
    end;