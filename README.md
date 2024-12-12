# IRISファーストステップガイド

 IRISを最初に操作する際の最小限のステップについて記載

## セットアップ

## Git clone

c:¥gitで以下のコマンドを実行することを想定

```
git clone https://github.com/intersystems-jp/IRISFirstStep.git
```

## クラスロード＆データ生成

IRISターミナルで以下のコマンドを実行

```
>set file = “c:¥git¥irisfirststep¥src¥FS¥Person.cls”
>do $system.OBJ.Load(file,”ck”)
>set file = “c:¥git¥irisfirststep¥src¥FS¥Address.cls”
>do $system.OBJ.Load(file,”ck”)
>do ##class(FS.Person).%KillExtent()
>do ##class(FS.Person).Populate(1000) 
```

## クレデンシャル情報

### ログイン用

| 項目           | 値        |
|---------------|------------
| システムログイン |　_system  |
|パスワード　	   |SYS|

