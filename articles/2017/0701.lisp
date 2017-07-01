(require :template)

(defparameter *source* '(
#<< END
<span class="Delimiter">(</span><span class="Statement">defun</span> dice <span class="Delimiter">(</span>n<span class="Delimiter">)</span>
  <span class="Delimiter">(</span><span class="Statement">if</span> <span class="Delimiter">(</span><span class="Statement">=</span> n <span class="Number">0</span><span class="Delimiter">)</span>
    <span class="Statement">nil</span>
    <span class="Delimiter">(</span><span class="Statement">cons</span> <span class="Delimiter">(</span><span class="Statement">1+</span> <span class="Delimiter">(</span><span class="Statement">mod</span> <span class="Delimiter">(</span><span class="Statement">random</span> <span class="Number">6</span> <span class="Delimiter">(</span><span class="Statement">make-random-state</span> <span class="Statement">t</span><span class="Delimiter">))</span> <span class="Number">6</span><span class="Delimiter">))</span>
          <span class="Delimiter">(</span>dice <span class="Delimiter">(</span><span class="Statement">1-</span> n<span class="Delimiter">)))))</span>

<span class="Delimiter">(</span><span class="Statement">print</span> <span class="Delimiter">(</span><span class="Statement">apply</span> <span class="Type">#'+</span> <span class="Delimiter">(</span><span class="Statement">print</span> <span class="Delimiter">(</span>dice <span class="Number">2</span><span class="Delimiter">))))</span>
<span class="Comment">; (1 6) </span>
<span class="Comment">; 7 </span>
END
))

(make-article
  :title "ボードゲーム「カタンの開拓者」のおすすめローカルルール"
  :time "2017-07-01"
  :tags  '("Common Lisp")
  :contents
  (list
    (:h1 "ボードゲーム「カタンの開拓者」のおすすめローカルルール")
    (:p "普段カタンの開拓者をやるときに採用しているローカルルールを紹介します。")

    (:h1 "カタンの開拓者とは")
    (:p "販売元"
      (:a ((href "http://www.gp-inc.jp/catan/"))
        "株式会社ジーピー")
      "より")
    (:blockquote ((cite "http://www.gp-inc.jp/catan/"))
      "カタンという無人島を舞台に、拠点となる開拓地（家）を建ててそこから島全体を開拓していきます。複数の対戦相手との開拓競争で、
      最初に10点（例：開拓地1点）とった人が勝者となります。
      具体的には、サイコロによって島から5種類の資源が算出されるので、その資源を元に次の開拓地を建てていきます。 
      　　ですが、なかなか必要な資源が集まらないこともあります。時には対戦相手と協力して資源を獲得し、時には陣地の獲得競争を行う
      エキサイティングなゲームです！　カタン島の支配者は一人だけ！　誰が勝者となるのか・・・")
    (:p "ドイツボードゲーム大賞も受賞しているらしいです。")

    (:h1 "おすすめのローカルルール")
    (:p
      "おすすめのローカルルールなんて言っているけど、
      実は普段やっているメンバー以外とカタンをやる機会があって、
      その際、普段やっているルールがローカルルールだとわかっただけです、すみません（笑）
      追加するのは次のルール一つのみです。")
    (:p
      "サイコロを振る人は、出た目の土地のカードをもらう。
      ただし、土地に盗賊がいる場合はカードは受け取れない。")
    (:p
      "先日、初めて正式ルールで遊ぶことにより、
      ローカルルールには次の特徴があると思いました。")
    (:ol
      (:li "ゲームのテンポがよい")
      (:li "サイコロを振る楽しみがある")
      (:li "運要素が多い")
      (:li "逆転要素がある"))
    (:h2 "ゲームのテンポがよい")
    (:p
      "ローカルルールでは、サイコロを振った人は土地の有無に関わらず出た目のカードがもらえるため、
      通常のカタンよりもテンポがいいです。
      ３人だと平均１時間程度で４人だと１時間半で終わります。")
    (:h2 "サイコロを振る楽しみがある")
    (:p
      "正式ルールでは、７を除いて誰が振っても結果は同じです。
      ローカルルールでは出た目の土地のカードがもらえるのでサイコロを振る楽しみがあります。")
    (:h2 "運要素が多い")
    (:p
      "ローカルルールでは、自分の隣接していない土地からもサイコロの目によってはカードが得られます。
      そのため正式ルールのほうが、より実力が試されるのかもしれません。")
    (:h2 "逆転要素がある")
    (:p "ローカルルールでは出目によって逆転することがあります。")

    (:h1 "まとめ")
    (:p "次のような方にこのローカルルールをおすすめします。")
    (:ol
      (:li "短く終わらせたい")
      (:li "楽しくやりたい")
      (:li "運要素がほしい"))

    (:h1 "おまけ")
    (:p
      "普段やっているメンバーとカタンをやるときは、電子サイコロを用いることがありました。
      一応技術ブログですので、それにこじつけてサイコロを振るソースを掲載しておきます。")
    (to-pre-code (pop *source*))
    (:p
      "何回かこれを使って、タイマーで時間制限を設けてやることもあったんだけど、
      結局サイコロを振るほうがボードゲームっぽくてよかったです。
      ただ、プログラムだと最後に出た目の分布とか出せて振り返ることができるのは良かったですね。")))
