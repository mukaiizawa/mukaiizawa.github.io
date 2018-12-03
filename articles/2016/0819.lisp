(require :template)

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

(make-article
  :title "Linux MintでVimをビルド"
  :time "2016-08-19"
  :tags  '("Linux" "Vim")
  :contents
  (list
    (:h1 "経緯")
    (:p "Linuxにデフォルトで入っているVimでクリップボードが使えなかった。"
      "確認してみたらクリップボードが無効になってた。"
      (to-pre-code (pop *source*)))
    (:p "いい機会なのでVimをソースコードからビルドしてインストールしてみた。")
    (:h1 "ビルド手順")
    (:p (:a ((href "http://vim-jp.org/docs/build_linux.html")) "vim-jp")
      "に親切にビルド手順が書いてあった。"
      "手順通りに進めると「１。必要なパッケージのインストール」にて次のエラーが出た。"
      (to-pre-code (pop *source*)))
    (:p "数時間嵌った結果、次の手順で解消。"
      (:ol
        (:li "Update Managerを起動")
        (:li "'Edit' -> 'Software source'を起動")
        (:li "一番下の'Enable source code repositories'をチェックして再起動"))
      "このあとは参照先の方法でビルドに成功。")))
