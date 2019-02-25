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
