drop table if exists users;
create table users (
  id int unsigned primary key auto_increment, -- 一意の値を自動的に割り当ててる.
  name varchar(20) unique, -- 名前が重複するとエラーになって, 書き込まれない.
  -- score float not null -- nullだとエラーになって, 書き込まれない.
  score float default 0.0 -- 初期値が0.0に設定さえてる.
);
desc users;

insert into users (name, score) values
  ('taro', 5.8),
  ('sola', 8.2),
  -- ('sola', 2.8),
  ('test', null),
  -- ('tanaka', 1.1),
  ('tanaka', 1.2);

select * from users;
