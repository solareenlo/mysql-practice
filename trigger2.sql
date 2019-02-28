drop table if exists posts;
create table posts (
  id int unsigned primary key auto_increment,
  title varchar(255),
  body text
);

drop table if exists logs;
create table logs (
  id int unsigned primary key auto_increment,
  msg varchar(255)
);

-- trigger で複数の処理を行うには begin end を使えば良い.
drop trigger if exists posts_insert_trigger;
delimiter // -- query の区切り文字を ; から // に変更した. なぜかというと, begin と end の間で復讐の処理をしたいから.
-- 変更しないと ; で trigger の処理が終わるから.
create trigger posts_insert_trigger after update on posts for each row
  begin
    insert into logs (msg) values ('post updated!');
    insert into logs (msg) values (concat(old.title, ' -> ', new.title));
    -- concat は文字列の結合
    -- old.title は変更前の title を表す.
    -- new.title は変更後の title を表す.
  end;
//
delimiter ; -- query の区切り文字を // から ; へ変更した.

drop table if exists comments;
create table comments (
  id int unsigned primary key auto_increment,
  post_id int not null,
  body text
);

insert into posts (title, body) values ('title 1', 'body 1');
insert into posts (title, body) values ('title 2', 'body 2');
insert into posts (title, body) values ('title 3', 'body 3');
select * from posts;
/*
> +----+---------+--------+
> | id | title   | body   |
> +----+---------+--------+
> |  1 | title 1 | body 1 |
> |  2 | title 2 | body 2 |
> |  3 | title 3 | body 3 |
> +----+---------+--------+
*/

update posts set title = 'title 2 updated' where id = 2;
select * from posts;
/*
> +----+-----------------+--------+
> | id | title           | body   |
> +----+-----------------+--------+
> |  1 | title 1         | body 1 |
> |  2 | title 2 updated | body 2 |
> |  3 | title 3         | body 3 |
> +----+-----------------+--------+
*/

select * from logs;
/*
> +----+----------------------------+
> | id | msg                        |
> +----+----------------------------+
> |  1 | post updated!              |
> |  2 | title 2 -> title 2 updated |
> +----+----------------------------+
*/
