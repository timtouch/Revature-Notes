/* PL/SQL */

create table cave (
    cave_id integer primary key,
    cave_name varchar2(50) unique,
    max_bears integer default 4
);

create table bear_type(
    bear_type_id integer primary key,
    bear_type_name varchar2(50)
);

create table bear(
    bear_id integer primary key,
    bear_name varchar2(50),
    bear_age integer check (bear_age > 0),
    bear_weight integer check (bear_weight > 0),
    cave_id integer,
    bear_type_id integer
);

alter table bear add bear_type_id integer;

create table beehive (
    beehive_id integer primary key,
    beehive_weight integer default 50 check (beehive_weight > 0)
);

create table bear_beehive (
    bear_id integer,
    beehive_id integer,
    constraint pk_bear_beehive primary key (bear_id, beehive_id)
);

-- Create foreign keys
alter table bear add constraint fk_bear_type_id
foreign key (bear_type_id)
references bear_type (bear_type_id);

alter table bear add constraint fk_cave_id
foreign key (cave_id)
references cave (cave_id);

alter table bear_beehive add constraint fk_bear_id
foreign key (bear_id)
references bear (bear_id);

alter table bear_beehive add constraint fk_beehive_id
foreign key (beehive_id)
references beehive (beehive_id);

-- populate
insert into cave (cave_id, cave_name, max_bears)
values (1, 'Yosemite', 4);

insert into cave (cave_id, cave_name, max_bears)
values (2, 'Yellowstone', 5);

insert into beehive values (1,35);
insert into beehive values (2,55);

insert into bear_type values(1, 'Picnic');

insert into bear values (1, 'Yogi', 30, 400, 1, 1);
insert into bear values (2, 'Boo Boo', 30, 200, 2, 1);

insert into bear_beehive values (1,1);
insert into bear_beehive values (2,2);

-- Sequence
create sequence sq_bear_pk start with 3 increment by 1;

-- Trigger (before insert, use sequence)
create or replace trigger tr_insert_bear -- replace allows you to update a function
before insert on bear                    -- determine when the trigger occurs
for each row                             -- gotta have this
begin
    select sq_bear_pk.nextval into :new.bear_id from dual;  -- grabs the next value from sq_bear_pk and use it as the "new" bear_id
end;
/                                        -- '/' should end all our pl/sql stuff otherwise it keeps going

-- View
create view vw_bears_per_cave (location, Total) as
select cave_name, count(bear_id) from cave, bear
where bear.cave_id = cave.cave_id
group by cave_name;

select * from vw_bears_per_cave;

-- (IMPORTANT TO KNOW) Functions: executable blocks of code, 0 or many input parameters, 0 or 1 simple output, no dml (select is fine),
-- can call other functions or view, but not stored procedures
create or replace function find_max_number ( x in number, y in number)
return number as z number;
begin
    if x > y then z:=x;
    else z:=y;
    end if;

    return z;
end;
/

-- Running function
declare
    first_num number;
    second_num number;
    max_num number;
begin
    first_num:=22;
    second_num:=42;
    max_num:=find_max_number(first_num, second_num);
    dbms_output.put_line('max= ' || max_num);           -- How to print out to the dbms output
end;
/

-- (IMPORTANT TO KNOW) Stored Procedures - same as function, but 0 or many complex outputs, can use DML
create or replace procedure hello_world_sp is
begin
    dbms_output.put_line('Hello, World!');
end;
/

-- Call it
begin
    hello_world_sp;
end;
/

-- Cursors
create or replace procedure get_all_bears (s out sys_refcursor) as
begin
    open s for
    select bear _id, bear_name from bear;
end;
/

-- How to run in Oracle
declare
    s sys_refcursor;
    some_id bear.bear_id%type; -- Takes the type implicitly?
    some_name bear.bear_name%type;
begin
    get_all_bears(s);
    loop
        fetch s into some_id, some_name;
        exit when s%notfound;
        dbms_output.put_line(some_id || ' ' || some_name);
    end loop;
    close s;
end;
/


-- Stored Procedure: SP_FEED_BEAR
-- INPUTS: Bear_Id, Beehive_Id, Honey_Amt
-- Increase/decrease bear/hive weight by honey_amt
CREATE OR REPLACE PROCEDURE SP_FEED_BEAR
(B_ID IN NUMBER, H_ID IN NUMBER, HONEY_AMT IN NUMBER) AS
BEGIN
    -- SAVEPOINT;
    UPDATE BEEHIVE
        SET BEEHIVE_WEIGHT = BEEHIVE_WEIGHT - HONEY_AMT
        WHERE BEEHIVE_ID = H_ID;
    UPDATE BEAR
        SET BEAR_WEIGHT = BEAR_WEIGHT + HONEY_AMT
        WHERE BEAR_ID = B_ID;
    
    -- ROLLBACK - to savepoint
    COMMIT;    
END;
/

-- Test SP_FEED_BEAR
SELECT * FROM BEAR;
SELECT * FROM BEEHIVE;
BEGIN
    SP_FEED_BEAR(1,1,5);
END;
/