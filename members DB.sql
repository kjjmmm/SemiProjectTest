create user semi identified by semi;
grant connect, resource to semi;
commit;

--------------------------------------------------------------------------------

create table members(
    m_email varchar(30) primary key,
    m_pw varchar(100) null,
    m_name varchar(20) not null,
<<<<<<< HEAD
    m_nickname varchar(20) not null,
=======
>>>>>>> 47849336d9dcf3e22e3994f40fb1b903c5d930b1
    m_phone varchar(20),
    m_zipcode varchar(20),
    m_address1 varchar(100),
    m_addredd2 varchar(100),
    m_joindate timestamp default sysdate not null,
    m_ipaddress varchar(20) not null,
    m_admin char(1) check(m_admin in('y', 'n'))
);
drop table members;

select * from members;
<<<<<<< HEAD
=======
commit;
>>>>>>> 47849336d9dcf3e22e3994f40fb1b903c5d930b1

