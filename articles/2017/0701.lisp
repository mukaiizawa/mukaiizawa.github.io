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
    (:h1 "おすすめのローカルルール")
    (:p "普段、次のようなローカルルールを適用してカタンをしている。"

      (to-pre-code
"サイコロを振る人は、出た目の土地のカードをもらう。
ただし、土地に盗賊がいる場合はカードは受け取れない。"))

    (:p "正式ルールに比べると次のような特徴がある。"
      (:ul
        (:li "ゲームのテンポがよい")
        (:li "サイコロを振る楽しみがある")
        (:li "運要素が多い")
        (:li "交渉の機会が減る")))
    (:h2 "ゲームのテンポがよい")
    (:p "サイコロを振った人は土地の有無に関わらず出た目のカードがもらえるため、"
      "通常のカタンよりも資源の周りがよくテンポが早くなる。"
      "３人だと平均１時間程度で４人だと１時間半で終わる。")
    (:h2 "サイコロを振る楽しみがある")
    (:p "正式ルールでは、７を除いて誰が振っても資源の供給は変わらないのに対し、"
      "出た目の土地のカードが貰えるようになるためサイコロを振る楽しみある。")
    (:h2 "運要素が多い")
    (:p "各々のプレーヤーの出す目が勝敗が密に依存するため、運要素が強くなる。")
    (:h2 "交渉の機会が減る")
    (:p "出した目により、算出しない資源が手に入る可能性があるためその分交渉が減る。")
    (:h1 "まとめ")
    (:p "次のような方にこのローカルルールをおすすめします。")
    (:ol
      (:li "短く終わらせたい")
      (:li "楽しくやりたい")
      (:li "運要素がほしい"))
    (:h1 "おまけ")
    (:p "電子サイコロが必要なとき、次のスクリプトを使っている。")
    (to-pre-code (pop *source*))
    (:p "タイマーも実装しで時間制限を設けてやることもあったけど、"
      "結局サイコロを振るほうがボードゲームっぽくてやらなくなった。"
      "プログラムだと最後に出た目の分布とか容易に出せるのがよかったんだけどね。")))
