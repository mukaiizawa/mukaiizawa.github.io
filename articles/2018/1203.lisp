(require :template)

(make-article
  :title "LinuxがインストールされているHDDをWindowsのHyper-Vに移行する方法"
  :time "2018-12-03"
  :tags  '("Windows Linux")
  :contents
  (list
    (:h1 "前提条件")
    (:p "この記事は次の環境にて行った。"
      (:ul
        (:li "OS:Windows 10")
        (:li "HDDのファイルシステム:ext4")))
    (:h1 "作業手順")
    (:p "次の手順で作業を行う。"
      (:ol
        (:li "HDDのファイルシステムの変換")
        (:li "vhdxファイルの作成")
        (:li "仮想マシン作成")))
    (:h2 "HDDのファイルシステムの変換")
    (:p (:a ((href "http://www.ext2fsd.com/")) "ここ")
      "からExt2Fsd-x.xx.exeをダウンロードする。")
    (:p "起動してインストール。")
    (:p "インストール後にダイアログが開いたら該当するデバイスをダブルクリックする。")
    (:p "'Mounting for fixed disk, need reboot'にチェックを入れ、任意のドライブを割り当てて再起動。")
    (:h2 "vhdxファイルの作成")
    (:p (:a ((href "https://technet.microsoft.com/ja-jp/sysinternals/ee656415.aspx")) "ここ")
      "からDisk2Vhdをダウンロードする。")
    (:p "disk2vhd.exeを起動して先に割り当てたドライブをvhdxに変換する。")
    (:h2 "仮想マシンの作成")
    (:p "作成した仮想ハードディスクを使用して仮想マシンを作成する。"
      "これらの作業は参考サイトが複数あるためそれらを参照すること。")))
