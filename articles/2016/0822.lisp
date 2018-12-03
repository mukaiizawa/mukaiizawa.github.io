(require :template)

(defparameter *source* 
#<< END
<span class="Function">.</span><span class="Function">box1</span> <span class="Function">{</span> <span class="Type">float</span>:<span class="Constant">left</span>; <span class="Type">height</span>:<span class="Constant">auto</span>; <span class="Type">width</span>:<span class="Number">50</span>%; <span class="Function">}</span>
<span class="Function">.</span><span class="Function">box2</span> <span class="Function">{</span> <span class="Type">float</span>:<span class="Constant">left</span>; <span class="Type">height</span>:<span class="Constant">auto</span>; <span class="Type">width</span>:<span class="Number">50</span>%; <span class="Function">}</span>
END
)


(make-article
  :title "cssで段組の実装"
  :time "2016-08-22"
  :tags  '("html" "css")
  :contents
  (list
    (:h1 "経緯")
    (:p "意外に自分で段組みを指定するのが困難だったため備忘録。")
    (:h2 "２つのwidthの合計が100%なのにあふれた")
    (:p "下の図のようにwrapperの中にbox1 box2を並べようと思った。"
      (:div ((style "height:auto; width:500px; border: solid 3px #000000;"))
        (:div ((style "float:left; box-sizing:border-box; height:auto; width:50%; border: solid 3px #aa00aa;")) "box 1")
        (:div ((style "float:left; box-sizing:border-box; height:auto; width:50%; border: solid 3px #aaaa00;")) "box 2")
        (:p "wrapper")))
    (:p "が、次のようになってしまった。"
      (:div ((style "height:auto; width:500px; border: solid 3px #000000;"))
        (:div ((style "float:left; height:auto; width:50%; border: solid 3px #aa00aa;")) "box 1")
        (:div ((style "float:left; height:auto; width:50%; border: solid 3px #aaaa00;")) "box 2")
        (:p "wrapper")))
    (:br)
    (:p "指定したCSSは次の通り。"
      (to-pre-code *source*))
    (:h1 "原因と解決策")
    (:p "borderやpaddingを指定していると、領域の計算時にそれらの幅はデフォルトでは含まれないらしい。"
      "つまり、上の例だと領域を計算後にborder 3pxの幅が必要になってしまっている。"
      "borderやpaddingの幅も含めて領域を計算させるようにするには、border-sizingプロパティをborder-boxに指定すればいいらしい。")))
