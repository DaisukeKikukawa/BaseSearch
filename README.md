# 桐生野球チームナビ
[桐生野球チームナビ](https://team-kiryu910.jp/) 

![image](https://github.com/DaisukeKikukawa/RecruitRadar/assets/58897760/939112c3-c33c-42ad-b2dd-df4117454b40)

# Get Start
docker-compose build --no-cache

docker-compose up -d

VSCodeのターミナルで以下3行を実行。

gem install rubocop

gem install rubocop-performance

gem install rubocop-rails

その後、拡張機能：ruby-rubocopをinstallする

*docker-compose up するもwebコンテナがexitする場合

エラー文：exec ./docker/web/entrypoint.sh

->entrypoint.shとstart-server.shの改行コードをLFにして、ビルドしなおしてみる

# 使用言語/環境/バージョン
* Ruby 3.1.4

* Ruby on rails 7.0.8

* Nginx

* Mysql 8.0.35

* puma

* Rubocop

# Rubocop 使用方法
Rubocop：ソースコードを自動的にチェック/修正を行ってくれるツール
  
* 「rubocop」で実行
  これだけでチェック開始

* 「rubocop -a」で実行
  チェックして、自動的に修正してくれる

* 「rubocop --help」で実行
  その他のオプションを確認できる


## 1.概要

野球が盛んなまち『球都桐生』の野球チーム情報、選手情報、大会・試合情報、球場情報などをまとめて掲載。

カテゴリーを超えて様々な球都桐生のリアルタイム野球情報を得ることができます。

## 2.ER 図
![image](https://github.com/DaisukeKikukawa/910kiryu/blob/develop/erd.png)

## 3.機能一覧
### アプリ側
| トップページ | 日程・結果画面 |
| --- | --- |
|<img width="1453" alt="スクリーンショット 2024-07-07 17 06 48" src="https://github.com/DaisukeKikukawa/RecruitRadar/assets/58897760/78caf50a-3bf0-47f8-a4f4-865d88b7e225">|<img width="1462" alt="スクリーンショット 2024-07-07 17 18 25" src="https://github.com/DaisukeKikukawa/RecruitRadar/assets/58897760/3730ac6c-664a-4df5-8215-e6831a68368d">|
|・日程結果・チーム検索・大会一覧・球場一覧のそれぞれのページにアクセスできるようになっています。</br>・画面下部のナビゲーションからも、いつでも直接アクセスすることが可能です。| 試合の日程・結果をカレンダー形式で確認することができます。 |

| チーム検索画面（カテゴリー） | チーム検索画面（チーム）|
| --- | --- |
|<img width="1453" alt="スクリーンショット 2024-07-07 17 23 59" src="https://github.com/DaisukeKikukawa/RecruitRadar/assets/58897760/02106fbe-991b-47bc-9b76-955561565e0f">|<img width="1451" alt="スクリーンショット 2024-07-07 17 24 38" src="https://github.com/DaisukeKikukawa/RecruitRadar/assets/58897760/31acd9aa-df32-4c15-b8fb-0a4ce4ece865">|
| ・各カテゴリーから任意のチームを検索可能となっています。| 選択したカテゴリーからチームを選ぶことができます。|

| チーム情報詳細画面 | 大会一覧画面|
| --- | --- |
|<img width="1440" alt="スクリーンショット 2024-07-07 17 31 35" src="https://github.com/DaisukeKikukawa/RecruitRadar/assets/58897760/81a72057-f125-4b6b-ba53-bf070c76176d">|<img width="1440" alt="スクリーンショット 2024-07-07 19 27 09" src="https://github.com/DaisukeKikukawa/RecruitRadar/assets/58897760/e2e5bf32-6566-43c6-a852-e843a20db0bd">|
|選択したチームの詳細情報を見ることができます。そのチームに紐づく情報を見ることができる、「選手名鑑タブ」・「日程・結果タブ」・「記事タブ」があります。|カレンダー形式で大会の情報を見ることができます。それぞれ大会の詳細情報と大会日程・結果画面があり、大会の情報を確認することができます。|

| 球場一覧画面 | |
| --- | ---|
|<img width="1457" alt="スクリーンショット 2024-07-07 19 39 39" src="https://github.com/DaisukeKikukawa/RecruitRadar/assets/58897760/70e89995-d348-4a4f-bc38-f65d8a38f952">|a|
|球場の情報をこのページで確認することができます。||

### CMS側

| トップページ | 管理者ログインページ |
| --- | --- |
|<img width="1451" alt="スクリーンショット 2024-07-07 19 52 10" src="https://github.com/DaisukeKikukawa/RecruitRadar/assets/58897760/bb00bc8e-c0e4-410b-83b6-4a1e51c0b575">|<img width="1439" alt="スクリーンショット 2024-07-07 19 53 51" src="https://github.com/DaisukeKikukawa/RecruitRadar/assets/58897760/d809ce17-e78c-4b17-b555-c1252d8f2f02">|
|管理者用のトップページです。| 管理者用のログインページです。 |

| 球場管理ページ | 大会管理ページ|
| --- | --- |
|<img width="1434" alt="スクリーンショット 2024-07-07 19 59 15" src="https://github.com/DaisukeKikukawa/RecruitRadar/assets/58897760/3496434c-63cd-490f-a065-ae00033693f0">|<img width="1449" alt="スクリーンショット 2024-07-07 19 59 56" src="https://github.com/DaisukeKikukawa/RecruitRadar/assets/58897760/04e29da4-d5a5-4577-85da-88bfaf0652fc">|
| 球場の一覧表示・登録・詳細情報の確認・検索を行うことができます。|大会の一覧表示・登録・詳細情報の確認・検索を行うことができます。 |

| チーム管理ページ | 試合管理ページ|
| --- | --- |
|<img width="1453" alt="スクリーンショット 2024-07-07 20 03 51" src="https://github.com/DaisukeKikukawa/RecruitRadar/assets/58897760/3721b8ce-75d2-44f0-84a6-96f7bb18298f">|<img width="1452" alt="スクリーンショット 2024-07-07 20 04 27" src="https://github.com/DaisukeKikukawa/RecruitRadar/assets/58897760/9378b1d8-fbe6-4575-96be-16a7e491b77e">|
|球場の一覧表示・登録・詳細情報の確認・検索を行うことができます。|大会の一覧表示・登録・詳細情報の確認・検索を行うことができます。|
