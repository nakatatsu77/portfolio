### 画面遷移図
Figma：https://www.figma.com/design/abY5VKaac5Yr2tSgFqkH78/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&t=8AlWgGDrFIOUbC83-1

## サービス概要
職場でやらかした（ミスをした）時のエピソードを投稿、閲覧できるアプリです。

## このサービスへの思い・作りたい理由
私自身、職場でのやらかしエピソードがいくつもあります。
勿論、やらかした瞬間は落ち込みますし、繰り返さないように反省しますが、後になって思い返すと思わず笑ってしまうようなエピソードだったりもします。
そんな「自分のやらかしエピソードを投稿したり、他の人のエピソードを見れる場所があったら」と考えこのサービスを作ろうと思いました。

## ユーザー層について
* 職場でやらかした経験のある方。
* 他の人のやらかしエピソードを見て、ちょっと元気をもらいたい方。

## サービスの利用イメージ
ユーザーは自分のやらかしエピソードを投稿したり、他人の投稿を閲覧する事ができます。
自分の投稿したエピソードに共感してもらったり、他人のエピソードを見て、「自分よりもさらに凄いやらかしをしてる人もいるんだ」とちょこっとだけ元気をもらえます。

## ユーザーの獲得について
* Xを使ってPRを行う
* RUNTEQのtimesやソーシャルポートフォリオの活用

## サービスの差別化ポイント・推しポイント
現状、やらかしエピソード投稿アプリみたいなサービスは無いと思いますが、TikTokやXなどで時々やらかした体験などの投稿を目にします。
差別化ポイントとして、UIに力を入れていきたいです。各投稿はカードのデザインを想定しています。投稿にマウスのカーソルを合わせると、投稿が180度回転し投稿の内容が見れる仕組みなど、ユーザーが思わず閲覧したくなるようなUIにしたいと考えています。

## 機能候補
### MVPリリース時に実装予定の機能
* ユーザー登録
* ログイン
* 投稿
* 投稿一覧
* 投稿詳細
* 投稿閲覧時のアニメーション
* 生成AIにてやらかしエピソードに沿った画像を生成

### 本リリースまでに実装予定の機能
* いいね機能
* コメント機能
* ランキングページの実装
* Xへのシェア機能

## 機能の実装方針予定
フロントエンド: React TailwindCSS<br> <!-- MVPリリース後にReactで実装予定 -->
バックエンド: Ruby on Rails<br>
データベース: MySQL