
(require "template")

(make-article
  :title "cssで段組実装時に２段になってしまう"
  :time "2016-08-22"
  :tags  '("html")
  :article
  (list
    (:h1 "cssで段組実装時に２段になってしまう")
    (:p
      "仕事ではBootStrap使って段組実装してばっかりだったのだけれど，"
      "ブログ作成するときに自力で段組を実装していたら詰まったのでメモ．"
      )
    (:h2 "２つのwidthの合計が100%なのにあふれた")
    (:p "下の図のようにwrapperの中にbox1 box2を並べようと思った．")
    (:div ((style "height:auto; width:500px; border: solid 3px #000000;"))
      (:div ((style "float:left; box-sizing:border-box; height:auto; width:50%; border: solid 3px #aa00aa;"))
        "box 1")
      (:div ((style "float:left; box-sizing:border-box; height:auto; width:50%; border: solid 3px #aaaa00;"))
        "box 2")
      "wrapper")
    (:p ((style "margin-top:20px;"))
      "が，")
    (:div ((style "height:auto; width:500px; border: solid 3px #000000;"))
      (:div ((style "float:left; height:auto; width:50%; border: solid 3px #aa00aa;"))
        "box 1")
      (:div ((style "float:left; height:auto; width:50%; border: solid 3px #aaaa00;"))
        "box 2")
      "wrapper")
    (:p ((style "margin-top:40px;"))
      "そう簡単には行かなかった．指定しているstyleはそれぞれ")
    (:p
      "box 1 { float:left; height:auto; width:50%; }" (:br)
      "box 2 { float:left; height:auto; width:50%; }")
    (:p"で，２つのboxのwidthの和がwrapperをちょうど占領するイメージだったがそうは行かなかった．")
    (:h2 "原因と解決策")
    (:p "どうやらborderやpaddingを指定していると，領域の計算時にそれらの幅はデフォルトでは含まれないらしい．")
    (:p "つまり，上の例だと領域を計算後にborder 3pxの幅が必要になってしまっている．")
    (:p "borderやpaddingの幅も含めて領域を計算させるようにするには，border-sizingプロパティをborder-boxに指定すればいいらしい．" (:br)
      (:a ((href "http://phiary.me/css3-box-sizing/"))
        "CSS3 の box-sizing が便利すぎる!! padding や border に依存しない width, height 指定 | phiary"))
    (:p "上記のサイトを参考にさせていただき，解決．")))

