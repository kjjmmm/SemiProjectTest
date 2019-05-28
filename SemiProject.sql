create user semi identified by semi;
grant connect, resource to semi;
commit;

--------------------------------------------------------------------------------

create table members(
    m_email varchar(30) primary key,
    m_pw varchar(100) not null,
    m_name varchar(20) not null,
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


--------------------------------------------------------------------------------

create table board(
    b_no number primary key,
    b_title varchar(100) not null,
    b_writer varchar(20) not null,
    b_amount number not null,
    b_account number not null,
    b_closing_date timestamp not null,
    b_contents varchar(4000) not null,
    b_viewcount number not null,
    b_writedate timestamp default sysdate not null,
    b_recommand number not null
    -- 기부가 얼마나 됐는지 알 수 있는 컬럼 추가
);
drop table board;

create sequence b_no_seq
start with 1
increment by 1
nocache
nomaxvalue;

select * from board;

--------------------------------------------------------------------------------

create table title_img(
    -- 여기 수정!!!!!!
    t_b_no foreign key references board(b_no) on update cascade on delete cascade,
    t_fileSeq number primary key,
    t_fileName varchar(300) not null,
    t_oriFileName varchar(300) not null,
    t_filePath varchar(300) not null,
    t_fileSize number not null
);
drop table title_img;

select * from title_img;

--------------------------------------------------------------------------------

create table payment(
    p_contributor varchar(20) not null, -- 기부한 사람 이름
    -- 이름, 이메일, 전화번호
    p_b_title varchar(100) not null,
    p_amount number not null,
    p_payment_date timestamp default sysdate not null
);
drop table payment;

select * from payment;

commit;
