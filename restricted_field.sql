dorp table if exists users;
create table users (
  id int unsigned primary key auto_increme, -- 一意の値を自動的に割り当ててる.
  name varchar(20) unique, -- 名前が重複するとエラーになって, 書き込まれない.
  -- score float not null -- nullだとエラーになって, 書き込まれない.
  score float default 0.0 -- 初期値が0.0に設定さえてる.
);

insert into users (id, name, score) values
  ('taro', 5.8),
  ('sola', 8.2),
  ('sola', 2.8),
  ('test', null),
  ('tanaka'),
  ('tanaka');

select * from users;
