# 開発中疑問に思ったこと

## デプロイ環境での画面操作テスト？

- Haml文法エラー（ローカルではOKだったのに、Herokuに上げたらエラーになった）

data属性の書き方

#### bad

```
%button.close{"area-hidden": true, "data-dismiss": "modal"} ×
```

#### good

```
%button.close{ data: { dismiss: "modal"} } ×
```

### 疑問点

- 画面が正しく表示されるかのテスト（フィーチャーテスト？）でカバーするべき？
- デバッグ用に 'rails_12factor' gemを入れたら、通常のデバッグメッセージも沢山出るようになった。このままでよいのか？
    - エラーが発覚した時だけgem入れる？
    - 良い設定方法がある？

## js library の管理方法

- bower で管理するように設定してみた

### 疑問点

- bower_components をgit commitしなかったらCircleCIでエラーが発生した
- bower_components はgit管理下にするのが普通？
