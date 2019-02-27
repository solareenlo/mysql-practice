drop table if exists users; -- 練習用に前のusers tableを消している
create table users (
  id int unsigned primary key auto_increment,
  name varchar(20),
  score float
);

insert into users (name ,score) values ('taguchi', 5.8);
insert into users (name ,score) values ('taro', 8.2);
insert into users (name ,score) values ('github', 10.1);
insert into users (name ,score) values ('Yamada', null);
insert into users (name ,score) values ('test', 1.1);

select * from users;
/*
> +----+---------+-------+
> | id | name    | score |
> +----+---------+-------+
> |  1 | taguchi |   5.8 |
> |  2 | taro    |   8.2 |
> |  3 | github  |  10.1 |
> |  4 | Yamada  |  NULL |
> |  5 | test    |   1.1 |
> +----+---------+-------+
*/

-- index(索引)の設定をしておくと data の抽出が速くなる.
-- score に index_score という index(索引)を付与する.
-- index は data の追加や更新処理を行うたびに作り直されるので, あまり index を付けすぎると処理が遅くなる.
alter table users add index index_score (score);
show index from users;
/*
> +-------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
> | Table | Non_unique | Key_name    | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
> +-------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
> | users |          0 | PRIMARY     |            1 | id          | A         |           2 |     NULL | NULL   |      | BTREE      |         |               |
> | users |          1 | index_score |            1 | score       | A         |           5 |     NULL | NULL   | YES  | BTREE      |         |               |
> +-------+------------+-------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
*/

-- きちんと index が使われているかを確認するには explain を用いる.
explain select * from users where score > 5.0;
/*
> +----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
> | id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
> +----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
> |  1 | SIMPLE      | users | NULL       | ALL  | index_score   | NULL | NULL    | NULL |    5 |    60.00 | Using where |
> +----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
*/

-- 逆に抽出に index が使用されていない例.
explain select * from users where name = 'tagushi';
/*
> +----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
> | id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
> +----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
> |  1 | SIMPLE      | users | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    5 |    20.00 | Using where |
> +----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
*/

-- index の削除
alter table users drop index index_score;
show index from users;
/*
> +-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
> | Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
> +-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
> | users |          0 | PRIMARY  |            1 | id          | A         |           2 |     NULL | NULL   |      | BTREE      |         |               |
> +-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
*/
