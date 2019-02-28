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

-- 日付の変更
update posts set created = '2016-12-31 10:10:10' where id = 2;
select * from posts;
/*
> +----+---------+--------+---------------------+---------------------+
> | id | title   | body   | created             | updated             |
> +----+---------+--------+---------------------+---------------------+
> |  1 | title 1 | body 1 | 2019-02-28 16:17:59 | 2019-02-28 16:17:59 |
> |  2 | title 2 | body 2 | 2016-12-31 10:10:10 | 2019-02-28 16:17:59 |
> |  3 | title 3 | body 3 | 2019-02-28 16:17:59 | 2019-02-28 16:17:59 |
> +----+---------+--------+---------------------+---------------------+
*/

-- 日付の条件指定
-- 2017-01-01 よりも新しい日付の record を抽出する
select * from posts where created > '2017-01-01';
/*
> +----+---------+--------+---------------------+---------------------+
> | id | title   | body   | created             | updated             |
> +----+---------+--------+---------------------+---------------------+
> |  1 | title 1 | body 1 | 2019-02-28 16:21:48 | 2019-02-28 16:21:48 |
> |  3 | title 3 | body 3 | 2019-02-28 16:21:48 | 2019-02-28 16:21:48 |
> +----+---------+--------+---------------------+---------------------+
*/

-- 日時の計算もできる
select created, date_add(created, interval 14 day) from posts;
select created, date_add(created, interval 2 week) from posts;
-- 上記の2つはどちらでも同じ結果が抽出される.
/*
> +---------------------+------------------------------------+
> | created             | date_add(created, interval 14 day) |
> +---------------------+------------------------------------+
> | 2019-02-28 16:24:23 | 2019-03-14 16:24:23                |
> | 2016-12-31 10:10:10 | 2017-01-14 10:10:10                |
> | 2019-02-28 16:24:23 | 2019-03-14 16:24:23                |
> +---------------------+------------------------------------+
*/

-- 日付の書式変更
select created, date_format(created, '%W %M %Y') from posts;
/*
> +---------------------+----------------------------------+
> | created             | date_format(created, '%W %M %Y') |
> +---------------------+----------------------------------+
> | 2019-02-28 16:26:27 | Thursday February 2019           |
> | 2016-12-31 10:10:10 | Saturday December 2016           |
> | 2019-02-28 16:26:27 | Thursday February 2019           |
> +---------------------+----------------------------------+
*/
