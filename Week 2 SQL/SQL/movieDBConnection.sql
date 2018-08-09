connect moviedb/p4ssw0rd

-- JOIN
create table genres (
    g_id integer constraint genre_pk primary key,
    g_name varchar2(50) not null
);

create table studios (
    s_id integer constraint studio_pk primary key,
    s_name varchar2(50) not null
);

create table movies (
    m_id integer primary key, 
    m_name varchar2(100) not null,
    m_date date,
    m_genre integer, 
    m_studio integer,
    foreign key (m_genre) references genres(g_id),
    foreign key (m_studio) references studios(s_id)
);

insert into genres values(1, 'Comedy');
insert into genres values(2, 'Horror');
insert into genres values(3, 'Sci-fi Action');

insert into studios values(1, 'WB');
insert into studios values(2, 'MGM');
insert into studios values(3, 'Fox');

insert into movies values(1, 'Rush Hour', CURRENT_TIMESTAMP, 1, 2);
insert into movies values(2, 'Star Wars', CURRENT_TIMESTAMP, 3, 3);
insert into movies values(3, 'Get Out', CURRENT_TIMESTAMP, 2, 1);

select * from movies;

-- Inner Join: TableA inner join TableB on FK = PK
select m_name, g_name from genres inner join movies
on m_genre = g_id;

-- Union
select * from genres inner join movies on m_genre = g_id where g_name like 'Horror'
UNION
select * from genres inner join movies on m_genre = g_id where g_name like 'Comedy';

-- Super Join
select * from genres inner join movies on m_genre = g_id
inner join studios on m_studio = s_id
where g_name = 'Horror';

-- Cross Join
select * from movies cross join genres;

-- Truncate
truncate table genres; -- Doesn't work unless you ON DELETE CASCADE for 

-- Contraints
-- Primary Key, Foreign Key, Not Null, Unique, Default, Check
create table persons (
    p_id integer primary key,
    p_name varchar2(100) not null,
    p_age integer check (p_age > 18),
    p_country varchar2(100) default 'USA',
    p_ssn number unique not null
);

-- IN: Allows you to specify values in WHERE clauses
select * from genres where g_name in ('Horror', 'Comedy');

-- Subqueries: Correlated (subquery is not independent vs Non-Correlated
select * from movies where m_genre in (select m_genre from movies where m_genre = 2);

-- EXISTS: Test for existence, returns true if one or more is returned
select * from movies where exists (select g_name from genres where g_id = 2);