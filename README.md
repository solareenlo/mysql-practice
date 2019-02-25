# mysql-practice
MySQLの使い方

## MySQLの基本的な使い方
```bash
# Ubuntuへのインストール
sudo apt install mysql-server mysql-client

# 起動確認
sudo service mysql status
> mysql.service - MySQL Community Server

# MySQLの基本設定を行う
sudo mysql_secure_instalation
> Securing the MySQL server deployment.
# で, 色々と設定していく.

# コンソールからMySQLサーバに接続
sudo mysql -u root -p
> Enter password:
# password入力して, MySQLサーバに接続
> mysql>

# helpを見る
mysql> help;

# 状態を見る
mysql> status

# 現在のユーザーを表示
mysql> select user();
> +----------------+
> | user()         |
> +----------------+
> | root@localhost |
> +----------------|
> 1 row in set (0.00 sec)

# ; を忘れると
mysql> select user()
    ->
# 続きを打てと催促されるので, 慌てずに ; を打つ.
    ->;
> +----------------+
> | user()         |
> +----------------+
> | root@localhost |
> +----------------|
> 1 row in set (0.00 sec)

# 現在のコマンドをキャンセルするには \c を打つ.
mysql> select user()
    -> \c
mysql>

# MySQLサーバーへの接続を終了する
mysql> quit;
mysql> \q
>Bye
```

## MySQLのデータ構造
Database  
  -> 複数のTable  
    -> その中にid, title, bodyを持つ表があって,  
    -> 行をRecord, Row, 列をField, Columと言う.  
こういったDatabaseやTableやFieldやRecordを扱う言語をSQL(Structured Query Language)と言う.

## DBを表示・新規作成・削除・操作対象にする
mysql> の後に打ち込むコマンドをQuery(クエリ)と言う.  
MySQLでのクエリは大文字小文字の区別がない.

```bash
# DBを表示する
mysql> show databases;
> +--------------------+
> | Database           |
> +--------------------+
> | information_schema |
> | mysql              |
> | performance_schema |
> | sys                |
> +--------------------|
> 4 row in set (0.00 sec)
# これらはシステムが用いているDBなのでうっかり消さないように注意する.

# 新規にDBを作成する
mysql> create database mydb01;
> Query OK, 1 row affected (0.00 sec)
# OKが出れば成功
mysql> create database mydb02;
> Query OK, 1 row affected (0.00 sec)
mysql> create database mydb03;
> Query OK, 1 row affected (0.00 sec)

# DBを削除する
mysql> drop database mydb03;
> Query OK, 0 row affected (0.00 sec)
# OKが出れば成功

# 操作対象のDBを確認する
mysql> select database();
> +--------------------+
> | database()         |
> +--------------------+
> | NULL               |
> +--------------------|
> 1 row in set (0.00 sec)
# NULLが帰ってきたので, 操作対象のDBがないと言うこと

# 操作対象のDBを選択する
mysql> use mydb02;
> Database changed
mysql> select database();
> +--------------------+
> | database()         |
> +--------------------+
> | mydb02             |
> +--------------------|
> 1 row in set (0.00 sec)
```

## 作業用ユーザーを設定し削除する
rootユーザーでうっかりをすると大変なことになるのでDBごとに作業用ユーザーを作成する.
```bash
# userを新規作成
mysql> create user dbuser01@localhost identified by '6AVAkig2@#';
> Query OK, 0 raws affected (0.00 sec)

# userにDBの権限を付与する
>mysql grant all on mydb01.* to dbuser01@localhost;
# grant は権限を与える.
# all は全ての権限を与える.
# mydb01.* はmydb01にあるテーブル全てに対して と言う意味.
# to dbuser@localhost はdbuser@localhostに対して と言う意味.
> Query OK, 0 raws affected (0.00 sec)

# 一度rootでログアウトして, もう一度dbuser01@localhostでログインする.
mysql> quit;
> Bye
mysql -u dbuser01 -p mydb01
> Enter password:
6AVAkig2@#
> Welcome to the MySQL monitor. Commands end with ; or \g.
# で, 無事にdbuser01ユーザーでログインができた.

# 一応確認.
mysql> select user();
> +--------------------+
> | user()             |
> +--------------------+
> | dbuser01@localhost |
> +--------------------|
> 1 row in set (0.00 sec)
# ユーザーがdbuser01になってる.

# アクセスできるDBも確認.
mysql> show databases;
> +--------------------+
> | Database           |
> +--------------------+
> | information_schema |
> | mydb01             |
> +--------------------|
> 2 row in set (0.00 sec)
# きちんとmydb01にだけアクセスするようになってる.

# ユーザーの削除
# rootユーザーでログインする
mysql> quit;
> Bye
sudo mysql -u root -p
> Enter password:
# rootユーザーのpasswordを入力して, エンター
mysql> drop user dbuser01@localhost;
> Query OK, 0 raws affected (0.00 sec)
```

## 外部ファイルを実行する
先ずは, 外部ファイルcreate_myapp.sqlを作成し, rootユーザーでログインするときに外部ファイルを読み込ます方法.
```bash
myspl -u root < create_myapp.sql
>
# 何も反応がないけど, きちんとできてます.
```

もしくは, rootユーザーでログインした後に, 外部ファイルを読み込ます方法.
```bash
sudo mysql -u root
> Welcome to the MySQL monitor. Commands end with ; or \g.
mysql> source ./create_myapp.sql
# もしくは
mysql> \. ./create_myapp.sql
> Query OK, 0 rows affected (0.00 sec)
>
> Query OK, 1 row affected (0.00 sec)
>
> Query OK, 0 rows affected, 1 warning (0.00 sec)
```

## Tableを新規作成・一覧表示・中身表示・削除する
Talbeを外部ファイルで作成して, 削除する.
```bash
mysql -u myapp_user -p myapp
> Enter password:
2VNAhigo@#
> Welcome to the MySQL monitor. Commands end with ; or \g.

# tableを外部ファイルを使って作成する
\. ./create_table.sql
> Query OK, 0 rows affected (0.00 sec)

# tableの一覧を見る
mysql> show tables;
> tableの一覧が見れる

# usersというtableの中身を見る
mysql> desc users;
> userというtableの中身が表示される
> 3 rows in set (0.00 sec)

# usersというtableの削除方法
mysql> drop table users;
> Query OK, 0 rows affected (0.00 sec)
mysql> show tables;
> Empty set (0.00 sec)
```
