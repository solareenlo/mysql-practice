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

drop trigger if exists posts_insert_trigger;
-- posts に insert が起こった後で, logs という table の record に msg として, post added! を挿入しなさい.
-- という意味.
-- trigger の名前は posts_insert_trigger
create trigger posts_insert_trigger after insert on posts for each row insert into logs (msg) values ('post added!');
-- insert だけでなく delete や update にも使える.
-- after だけでなく before も使える.

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

select * from logs;
/*
> +----+-------------+
> | id | msg         |
> +----+-------------+
> |  1 | post added! |
> |  2 | post added! |
> |  3 | post added! |
> +----+-------------+
*/

-- trigger の一覧を表示する
show triggers;
/*
> +----------------------+--------+-------+-----------------------------------------------+--------+------------------------+-------------------------------------------------------------------------------------------------------------------------------------------+----------------------+----------------------+----------------------+--------------------+
> | Trigger              | Event  | Table | Statement                                     | Timing | Created                | sql_mode                                                                                                                                  | Definer              | character_set_client | collation_connection | Database Collation |
> +----------------------+--------+-------+-----------------------------------------------+--------+------------------------+-------------------------------------------------------------------------------------------------------------------------------------------+----------------------+----------------------+----------------------+--------------------+
> | posts_insert_trigger | INSERT | posts | insert into logs (msg) values ('post added!') | AFTER  | 2019-02-28 14:05:13.74 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION | myapp_user@localhost | utf8                 | utf8_general_ci      | latin1_swedish_ci  |
> +----------------------+--------+-------+-----------------------------------------------+--------+------------------------+-------------------------------------------------------------------------------------------------------------------------------------------+----------------------+----------------------+----------------------+--------------------+
*/

-- field を縦に表示するには \G をつければ良い.
show triggers \G
/*
> *************************** 1. row ***************************
>              Trigger: posts_insert_trigger
>                Event: INSERT
>                Table: posts
>            Statement: insert into logs (msg) values ('post added!')
>               Timing: AFTER
>              Created: 2019-02-28 14:05:13.74
>             sql_mode: ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
>              Definer: myapp_user@localhost
> character_set_client: utf8
> collation_connection: utf8_general_ci
>   Database Collation: latin1_swedish_ci
*/
