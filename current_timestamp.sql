drop table if exists posts;
create table posts (
  id int unsigned primary key auto_increment,
  title varchar(255),
  body text,
  created datetime default current_timestamp,
  updated datetime default current_timestamp on update current_timestamp
  -- on update current_timestamp で更新時にその時の日時で field を自動更新してくれる.
);

insert into posts (title, body) values ('title 1', 'body 1');
insert into posts (title, body) values ('title 2', 'body 2');
insert into posts (title, body) values ('title 3', 'body 3');

select * from posts;
/*
> +----+---------+--------+---------------------+---------------------+
> | id | title   | body   | created             | updated             |
> +----+---------+--------+---------------------+---------------------+
> |  1 | title 1 | body 1 | 2019-02-28 15:25:58 | 2019-02-28 15:25:58 |
> |  2 | title 2 | body 2 | 2019-02-28 15:25:58 | 2019-02-28 15:25:58 |
> |  3 | title 3 | body 3 | 2019-02-28 15:25:58 | 2019-02-28 15:25:58 |
> +----+---------+--------+---------------------+---------------------+
*/

-- 以下を mysql にアクセスして実行すると
-- update された日時が field の updated の欄に書き込まる.

-- update posts set title = 'updated' where id = 2;
-- select * from posts;
/*
> +----+---------+--------+---------------------+---------------------+
> | id | title   | body   | created             | updated             |
> +----+---------+--------+---------------------+---------------------+
> |  1 | title 1 | body 1 | 2019-02-28 15:31:16 | 2019-02-28 15:31:16 |
> |  2 | updated | body 2 | 2019-02-28 15:31:16 | 2019-02-28 15:38:20 |
> |  3 | title 3 | body 3 | 2019-02-28 15:31:16 | 2019-02-28 15:31:16 |
> +----+---------+--------+---------------------+---------------------+
*/
