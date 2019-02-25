-- insert into users (id, name, score) values (1, 'taro', 5.8);
-- insert into users (id, name, score) values (2, 'sola', 8.2);
-- insert into users (id, name, score) values (3, 'test', 10.1);
-- insert into users (id, name, score) values (4, 'yamada', null);

-- 以下も上と全く同じ操作をしてくれる.
insert into users (id, name, score) values
  (1, 'taro', 5.8),
  (2, 'sola', 8.2),
  (3, 'test', 10.1),
  (4, 'yamada', null);

select * from users;
