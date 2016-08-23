
(require "template")

(make-article
  :title "Linux MintでVimをビルドしてみた"
  :time "2016-08-19"
  :tags  '("Linux" "Vim")
  :article
  (list
    (:h1 "Linux MintでVimをビルドしてみた")
    (:p
      "今まではWindows環境のGvim（" (link-vim-org) "が配布しているインストーラーでインストール）を使用していたんだけど，"
      "インストールしたLinuxのVimのクリップボードが使えなかった．")
    (:p "先人の教えにしたがって")
    (:pre (:code "$ vim --version | grep clipboard"))
    (:p "してみたらやっぱりオプションが無効でした．")
    (:p "これはいい機会だと思ってLinux MintにVimをソースコードからビルドしてインストールしたのでメモ．")
    (:h2 "実際にビルド")
    (:p "Vimを使う利点として情報がたくさんあるということがよく挙げられますが，今回もすぐに見つかりました．")
    (:p (:a ((href "http://vim-jp.org/docs/build_linux.html")) "Linuxでのビルド方法"))
    (:p "が，早速「１．必要なパッケージのインストール」でハマりました．")
    (:p
      "$ sudo apt-get build-dep vim"
      "[sudo] password for xxx"
      "Reading package lists..."
      "Done Building dependency tree"
      "Reading state information... Done"
      "E: You must put some 'source' URIs in your sources.list")
    (:p "数時間ハマった挙句，最後の行のエラーが原因だったので以下の手順で解決．")
    (:ol
      (:li "画面右下の盾のマークをクリックしてUpdate Managerを起動")
      (:img ((src (to-absolute "resources/images/0819_01.png")) (alt "Update Managerの写真")))
      (:li "`Edit' -> `Software source'を起動")
      (:img ((src (to-absolute "resources/images/0819_02.png")) (alt "Update Managerの写真")))
      (:li "一番下の`Enable source code repositories'をチェックして再起動．"))
    (:p "このあとは無事参照先の方法でbuildできました．めでたし．")))


