(require :template)

(make-article
  :title "Androidの実機デバッグ時に'java.lang.IllegalArgumentException: Unknown package:xxx'が発生する"
  :time "2019-05-20"
  :tags  '("Android")
  :contents
  (list
    (:h1 "修正手順")
    (:p "Android Studioにて'View -> Tool Windows -> Device File Explorer'を選択する。")
    (:p "data/local/tmp/にある対応するpackageを削除する。")))
