# uecda-client-alpine

## 概要
UECコンピュータ大貧民大会のクライアントプログラムをAlpine Linux上に配備したものです.
本大会に興味を持った方が, とりあえずローカル環境で対戦プログラムを動かしてみることを,
気軽に試せる環境を提供することを目的としています.

## イメージの入手方法
### Docker Hubからビルド済みイメージを取得する場合
```
docker pull akimateras/uecda-client-alpine
```

### GitHubからソースを取得して自分でビルドする場合
Gitがインストールされている必要があります.
```
git clone https://github.com/akimateras/uecda-client-alpine.git
docker build -t akimateras/uecda-client-alpine uecda-client-alpine
```

Windowsの場合, ビルドしたイメージの実行時に, 下記のエラーが出る場合があります.
```
standard_init_linux.go:175: exec user process caused "no such file or directory"
```
これは, Gitが自動的に改行コードをWindows形式に変換しているために発生します.
```
git config --global core.autoCRLF false
```
を実行するなどして自動変換を無効化し, `git clone`からやり直してください.

## 起動方法
<https://github.com/akimateras/uecda-server-alpine> のREADMEで示された方法で,
サーバープログラムのコンテナが既に起動済みであることを前提とします.

下記コマンドでUECda開発キットに付属するクライアントプログラム（対戦AI）が起動します.
```
docker run -d --link uecda-server akimateras/uecda-client-alpine default ./client -h uecda-server
```

クライアントプログラム起動後, 予め起動してあったサーバープログラムのコンソールに, 下記のような出力が追加されれば起動は成功です.
```
protocol_version: 20070
NAME: default
accepted from 172.17.0.3
```

対戦が開始されるためには, サーバープログラムに対してクライアントプログラムが5つ接続される必要があります.
最初はとりあえず, 上のコマンドを5回実行し, 対戦が開始されることを確認してください.

クライアントプログラムを5つ起動し終わったのち, サーバープログラムのコンソールに下記のような出力が流れ始めれば, 正常に対戦が進行しています.
```
================ game 1
daihugou   1
hugou      2
heimin     3
himmin     4
daihinnmin 0
--------- total point
1 5 4 3 2
sekigae done
-> 2
-> 4
-> 0
-> 3
-> 1
================ game 2
daihugou   2
hugou      1
heimin     4
himmin     0
daihinnmin 3
--------- total point
3 9 9 4 5
sekigae done
-> 2
-> 4
-> 0
-> 3
-> 1
================ game 3
        :
        :
```

## 使用する対戦プログラムの変更
前節では, とりあえず開発キットに付属するクライアントプログラムを起動させてみました.

本Dockerfileでは開発キット付属のクライアントプログラムの他に,
UECコンピュータ大貧民大会のWEBページで配布されている, 2種類のクライアントプログラムが使用可能な状態になっています.

下記に, それぞれのプログラムの起動方法を示します.

### 開発キット付属クライアント (前節で使用したもの)
```
docker run -d --link uecda-server akimateras/uecda-client-alpine default ./client -h uecda-server
```

### wisteria (UECda-2015 重量級優勝プログラム)
```
docker run -d --link uecda-server akimateras/uecda-client-alpine wisteria ./client -h uecda-server
```

### kou2 (UECda-2015 ライト級優勝プログラム)
```
docker run -d --link uecda-server akimateras/uecda-client-alpine kou2 ./client -h uecda-server
```
