(require :template)

;; *source* {{{

(defparameter *source* '(
#<< END
$ vim <span class="Special">--version</span> | grep clipboard
END

#<< END
$ sudo apt-get build-dep vim
<span class="Statement">[</span>sudo<span class="Statement">]</span> password <span class="Statement">for</span> xxx
Reading package lists...
Done Building dependency tree
Reading state information... Done
E: You must put some <span class="Statement">'</span><span class="String">source</span><span class="Statement">'</span> URIs <span class="Statement">in</span> your sources.list
END
))

;; }}}

(make-article
  :title "Linux MintでVimをビルドしてみた"
  :time "2016-08-19"
  :tags  '("Linux" "Vim")
  :article
  (list
    (:h1 "Linux MintでVimをビルドしてみた")
    (:p
      "今まではWindows環境のGvim（" (link-vim-org) "が配布しているインストーラーでインストール）を使用していたんだけど，"
      "インストールしたLinuxのVimのクリップボードが使えなかった．確認してみたら")
    (to-pre-code (pop *source*))
    (:p
      "オプションが無効でした．"
      "これはいい機会だと思ってLinux MintにVimをソースコードからビルドしてインストールしたのでメモ．")
    (:h2 "実際にビルド")
    (:p "Vimについての情報は豊富で大抵の情報はすぐに見つかるので便利．")
    (:p (:a ((href "http://vim-jp.org/docs/build_linux.html")) "Linuxでのビルド方法"))
    (:p "が，早速「１．必要なパッケージのインストール」でハマりました．")
    (to-pre-code (pop *source*))
    (:p "数時間ハマった挙句，最後の行のエラーが原因だったので以下の手順で解決．")
    (:ol
      (:li "画面右下の盾のマークをクリックしてUpdate Managerを起動")
      (import-img "2016/0819_01.png" "Update Managerの写真")
      (:li "`Edit' -> `Software source'を起動")
      (import-img "2016/0819_02.png" "Update Managerの写真")
      (:li "一番下の`Enable source code repositories'をチェックして再起動．"))
    (:p "このあとは無事参照先の方法でbuildできました．めでたし．")))
