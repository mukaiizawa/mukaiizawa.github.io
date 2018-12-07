(require :template)

(make-article
  :title "LinuxがインストールされているHDDをWindowsのドライブにマウントする"
  :time "2018-12-03"
  :tags  '("Windows Linux")
  :contents
  (list
    (:h1 "概要")
    (:p "WindowsとLinuxではファイルシステムが異なるため、そのままでは外付けのHDDのLinuxのファイルを参照できない。"
      "ext2fsdを利用してWindowsのドライブにマウントできるようにする。")
    (:h1 "ext2fsdのインストール")
    (:p (:a ((href "http://www.ext2fsd.com/")) "ここ")
      "からExt2Fsd-x.xx.exeをダウンロードし実行する。")
    (:h1 "ドライブにマウント")
    (:p "/Ext2Mgr.exeを実行する。")
    (:p "'Mounting for fixed disk, need reboot'にチェックを入れ、任意のドライブを割り当てる。")))
