# Fledge Hub

## is 何？

RUNTEQ生のポートフォリオ、どこで見れるんじゃ？<br>
→ないなら作ろう

そんな感じで始まりましたが、想定ユーザーはRUNTEQ生に限定しないことになりました。<br>
みんなでカスタマイズしていけたらいいなと思っています。


## 参加したい！

まずは[Mattermostのチャンネル](https://chat.runteq.jp/runteq/channels/c01rtlnl5qx)に入ってください。


環境構築手順は[こちら](https://github.com/runteq/fledge-hub/wiki/%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89%E6%89%8B%E9%A0%86)から。

思いついた機能を[Issue](https://github.com/runteq/fledge-hub/issues)に投げるだけでも大丈夫です。<br>
実装できそうかも？と思った人は、環境構築からお願いします（ものによっては環境構築不要なものもありますが）


### タスクの進め方

- Issueの追加
  - やりたいことがIssueにない場合は、自分で作ってください
  - [New Issue](https://github.com/runteq/fledge-hub/issues/new)からタスクを追加する

- Issueに取り掛かる
  - `Assignees`に自分を追加して「やります表明」をする
<img width="1316" alt="貼り付けた画像_2021_04_15_21_37" src="https://user-images.githubusercontent.com/44717752/114870176-cecc9700-9e32-11eb-8bfd-ec153fe97744.png">

- 実装する
  - 仕様の確認含む質問はできるだけGitHubで一元管理したいので、基本的にはGitHubで行う（Mattermostのチャンネルも都度使い分ける）

- PRを出す
  - [セルフレビュー](https://beta-chelsea.hatenadiary.jp/entry/2020/12/19/125756)をしましょう

- Approveを受けたらマージする
  - コンフリクトの解消も経験です


#### その他

- 回答などが必要な場合はメンションをすると確実です

- 1つのIssueの規模が大きい場合、PRを複数に分けて出すことをおすすめします
  - PRの粒度が小さいと、レビュワーの負担が軽くなります

- あなたのレビューも歓迎です！
  - LGTMを出すほどの自信がなくても、他人のコードを読んでコメントしてみましょう！


## 仕様

- ユーザーの導線
  - GitHubアカウントでログイン
  - 新規プロダクト（PF）を作成
  - プロダクトに紐づく関連メディア、画像を作成

### ER図

![ER図](./erd.png)
https://drive.google.com/file/d/1lPhbCER0sW7sJMw0R_E0QcrDQB4JijEv/view?usp=sharing

詳細は https://github.com/runteq/fledge-hub/pull/1 だけど、若干内容が変わっている。

### 画面遷移図

[画面遷移図](https://www.figma.com/file/AwHt66yEYV4qlvxi4Nv19F/Runteq-senses?node-id=0%3A88)
イメージです。
気づいたところがあれば、適宜いじって欲しい！！
