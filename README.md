# App

実装予定の処理を以下に示す。

（1）日記の内容を保存する機能

・userdefalutまたはその他の保存方法で実装
・Firebaseなどのクラウドサービスを利用しデータを保存

＜現状の課題>
日記のデータには日付や内容のデータが含まれており、これらを1まとまりにして管理する方法を検討しているが実装方法などわからない点が多く苦戦している。



（2）日記を追加した後、日記一覧からタップして編集画面に遷移した際に表示される画面下部のtoolbar内の処理

・ゴミ箱マークをタップしたときにその日記を削除する機能
・保存ボタンをタップしたときにその日記の編集内容を保存する機能

＜現状の課題＞
日記の編集作業を一覧表示しているviewcontrollerに反映させる予定だが、開発途中で機能追加を少しずつしているため、データの取り扱いが複雑になって完全に理解できていない。
データの受け渡しや更新方法を再考して適切な実装方法を考える必要がある。


（3）現在研究室で学習しているPytorchや自然言語処理、感情分析を利用した機能追加
・日記の内容の文章を感情分析を使って日記の内容の感情を分類させ日付と共に1ヶ月の感情変化をグラフ化させる機能
メリット：1ヶ月の感情の起伏変化チャートを簡単に作成でき見返す時におもしろい

＜現状の課題＞
独自機能で実装方法が全くわからないため現在はアイデアとして1つを挙げただけの段階であること。
時間があり、知識がある人物の協力が得られるのであれば実装したら面白そう。
