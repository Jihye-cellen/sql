create table product(
    code char(3) not null primary key,
    name varchar(100) not null,
    price int default 0
);

desc product;

insert into product (code, name, price) values('101', '냉장고', 3500000);
insert into product (code, name, price) values('102', '세탁기', 2300000);
insert into product (code, name, price) values('103', '스타일러', 1700000);

select * from product;

create table sale(
    seq int,
    code char(3) not null, 
    sale_date date default sysdate,
    qnt int default 1,
    primary key(code, sale_date),
    foreign key(code) references product(code)
    );

desc sale;
drop table product;
select * from sale;


insert into sale (seq, code, sale_date, qnt) values(1, '101', '2024-04-01', 12);
insert into sale (seq, code, sale_date, qnt) values(2, '102', '2024-04-01', 5);
insert into sale (seq, code, sale_date, qnt) values(3, '103', '2024-04-02', 6);
insert into sale (seq, code, sale_date, qnt) values(4, '101', '2024-04-03', 15);

create sequence seq_sale increment by 1 start with 5;
drop sequence seq_sale;

insert into sale(seq, code, sale_date, qnt) values (seq_sale.nextval, '103', '2024-04-05', 10);

delete from sale where seq=5;

update sale set qnt = 12 where seq = 6; 

create view view_sale as select p.name, p.price, s.* from product p, sale s where p.code=s.code; /*테이블 안에만 있는 컬럼들을 지칭할 때는 아예 p.생략해도 된다.*/
select s.code, p.name, p.price, s.sale_date, s.qnt from product p, sale s where p.code = s.code;
select * from view_sale;

select* from view_sale where name='냉장고';
select* from view_sale where price>=150000 order by price desc;

commit;

select max(code)+1 as code from product;
commit;

select*from product;
select*from sale;