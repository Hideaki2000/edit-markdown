# README

開発の前に、以下を一読すること！

https://rerureru.backlog.com/wiki/ADMARKETING_SAAS/Rails+%E9%96%8B%E7%99%BA%E3%81%AE%E6%B5%81%E3%82%8C

**使用言語**

- Ruby 3.0

**フレームワーク**

- Ruby on Rails 6.1.3.1 (2021/04/03現在で最新)

**ミドルウェア**

DB : MySQL
Redis

**CSSフレームワーク**

[tailwindcss](https://tailwindcss.com/docs)

**主な使用gem**

- rails
- webpacker
- react-rails

---

### 環境構築

(前提)
- docker for macが入っている



#### clone

```bash
git clone ~~
```
#### packageのダウンロード
```bash
docker-compose build
docker-compose run --rm reru_rails  bash
yarn install
exit
```
### 動作確認
```bash
docker-compose up
```
config/master.keyがignore配下なので、backlogからダウンロード
https://reru.backlog.com/wiki/ADMARKETING_SAAS/Main+%E3%83%90%E3%83%83%E3%82%AF%E3%82%A8%E3%83%B3%E3%83%89+README.md

#### docker-compose up

```bash
$ docker-compose up -d
```

MySQLとphpAdminとRedisが起動する

#### DB関連

```bash
$ bundle exec rails db:create db:migrate
```

#### Rails serverを立ち上げる

```bash
$ bundle exec rails s -b 0.0.0.0
```

#### Webpack起動

```bash
$ bin/webpack-dev-server
```


---

### docker-composeでbundle install errorでrailsコンテナが立ち上がらない場合

```bash
$ docker-compose run --rm reru_rails bundle install -j4
```


