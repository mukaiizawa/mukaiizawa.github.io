(require :template)

(defparameter *source* '(
#<< END
<span class="Delimiter">(</span><span class="Statement">defparameter</span> <span class="Type">*test-times*</span> <span class="Number">100000</span><span class="Delimiter">)</span>

<span class="Delimiter">(</span><span class="Statement">defun</span> do-game <span class="Delimiter">(</span>change-choice?<span class="Delimiter">)</span>
  <span class="Delimiter">(</span><span class="Statement">let*</span> <span class="Delimiter">((</span>monty-choice <span class="Delimiter">(</span><span class="Statement">random</span> <span class="Number">3</span><span class="Delimiter">))</span>
         <span class="Delimiter">(</span>user-choice <span class="Delimiter">(</span><span class="Statement">random</span> <span class="Number">3</span><span class="Delimiter">))</span>
         <span class="Delimiter">(</span>openable <span class="Delimiter">(</span><span class="Statement">remove-if</span> <span class="Delimiter">(</span><span class="Statement">lambda</span> <span class="Delimiter">(</span>x<span class="Delimiter">)</span>
                                <span class="Delimiter">(</span><span class="Statement">or</span> <span class="Delimiter">(</span><span class="Statement">=</span> x monty-choice<span class="Delimiter">)</span> <span class="Delimiter">(</span><span class="Statement">=</span> x user-choice<span class="Delimiter">)))</span>
                              <span class="Delimiter">(</span><span class="Statement">loop</span> <span class="Statement">for</span> i from <span class="Number">0</span> to <span class="Number">2</span> collect i<span class="Delimiter">))))</span>
    <span class="Delimiter">(</span><span class="Statement">when</span> change-choice?
      <span class="Delimiter">(</span><span class="Statement">let</span> <span class="Delimiter">((</span>open-choice <span class="Delimiter">(</span><span class="Statement">nth</span> <span class="Delimiter">(</span><span class="Statement">random</span> <span class="Delimiter">(</span><span class="Statement">length</span> openable<span class="Delimiter">))</span> openable<span class="Delimiter">)))</span>
        <span class="Delimiter">(</span><span class="Statement">setf</span> user-choice <span class="Delimiter">(</span><span class="Statement">-</span> <span class="Delimiter">(</span><span class="Statement">+</span> <span class="Number">0</span> <span class="Number">1</span> <span class="Number">2</span><span class="Delimiter">)</span> user-choice open-choice<span class="Delimiter">))))</span>
    <span class="Delimiter">(</span><span class="Statement">=</span> monty-choice user-choice<span class="Delimiter">)))</span>

<span class="Delimiter">(</span><span class="Statement">defun</span> monty-hole-problem <span class="Delimiter">()</span>
  <span class="Delimiter">(</span><span class="Statement">let</span> <span class="Delimiter">((</span>win-count-change <span class="Number">0</span><span class="Delimiter">)</span>
        <span class="Delimiter">(</span>win-count-not-change <span class="Number">0</span><span class="Delimiter">))</span>
    <span class="Delimiter">(</span><span class="Statement">dotimes</span> <span class="Delimiter">(</span>i <span class="Type">*test-times*</span><span class="Delimiter">)</span>
      <span class="Delimiter">(</span><span class="Statement">if</span> <span class="Delimiter">(</span>do-game <span class="Statement">t</span><span class="Delimiter">)</span> <span class="Delimiter">(</span><span class="Statement">incf</span> win-count-change<span class="Delimiter">))</span>
      <span class="Delimiter">(</span><span class="Statement">if</span> <span class="Delimiter">(</span>do-game <span class="Statement">nil</span><span class="Delimiter">)</span> <span class="Delimiter">(</span><span class="Statement">incf</span> win-count-not-change<span class="Delimiter">)))</span>
    <span class="Delimiter">(</span><span class="Statement">format</span> <span class="Statement">t</span> <span class="String">&quot;change: ~A~%fix: ~A&quot;</span>
            <span class="Delimiter">(</span><span class="Statement">/</span> win-count-change <span class="Number">1.0</span> <span class="Type">*test-times*</span><span class="Delimiter">)</span>
            <span class="Delimiter">(</span><span class="Statement">/</span> win-count-not-change <span class="Number">1.0</span> <span class="Type">*test-times*</span><span class="Delimiter">))))</span>
END

#<< END
<span class="Delimiter">(</span>monty-hole-problem<span class="Delimiter">)</span>

--

change: 0.66668
fix: 0.33603
END
))

(make-article
  :title "Common Lispでモンティーホール問題のシミュレーション"
  :time "2017-10-10"
  :tags  '("Common Lisp")
  :contents
  (list
    (:h1 "モンティーホール問題")
    (:p
      (:a ((href "https://ja.wikipedia.org/wiki/%E3%83%A2%E3%83%B3%E3%83%86%E3%82%A3%E3%83%BB%E3%83%9B%E3%83%BC%E3%83%AB%E5%95%8F%E9%A1%8C"))
        "ウィキペディア")
      "より"
      (:blockquote ((cite "https://ja.wikipedia.org/wiki/%E3%83%A2%E3%83%B3%E3%83%86%E3%82%A3%E3%83%BB%E3%83%9B%E3%83%BC%E3%83%AB%E5%95%8F%E9%A1%8C"))
        "
        「プレーヤーの前に閉まった3つのドアがあって、1つのドアの後ろには景品の新車が、
        2つのドアの後ろには、はずれを意味するヤギがいる。
        プレーヤーは新車のドアを当てると新車がもらえる。
        プレーヤーが1つのドアを選択した後、
        司会のモンティが残りのドアのうちヤギがいるドアを開けてヤギを見せる。
        ここでプレーヤーは、最初に選んだドアを、残っている開けられていないドアに変更してもよいと言われる。
        プレーヤーはドアを変更すべきだろうか？」
        "
        ))

    (:h1 "ソースコード")
    (:p "次のコードで検証した。")
    (to-pre-code (pop *source*))
    (:p
      "do-gameは一回ゲームを試行する関数である。"
      "ゲームをする際にモンティーがドアを開けた後に選択を変更する否かを決める引数を一つ受け取り、"
      "ユーザが勝ったか(モンティと選択が一致したか)否かを返す。"
      "ユーザとモンティの選択はそれぞれ0から2の数字で表現され、"
      "ユーザが選択を変更する場合、モンティーが開けなかったドアを選択することになる。")
    (:p
      "monty-hole-problemはグローバル変数*test-times*に代入されている回数だけdo-gameを試行し、"
      "ユーザが選択を固定した場合とそうでない場合の勝率を集計して結果を表示する。") 

    (:h1 "実行結果")
    (:p "次のような結果になった。")
    (to-pre-code (pop *source*))
    (:p "結果から、選択を常に変更する場合は2/3の確率となり、常に変更しない場合は1/3となるといえる。")

    (:h1 "考察")
    (:p "モンティがドアを開けた後から来た人からすると、"
      "確かにこのゲームの勝率はどのようにユーザが振る舞っても1/2になる。"
      (:q "つまり、残る２つのドアのうちどちらかに当たりがある。")
      "という状況。")
    (:p "この問題が面白いのは、最初からゲームに参加していた人には、"
      "ドアを開ける前にユーザが選んでいた選択が当たりの確立は1/3で、"
      "その他の2つのドアに当たりがある確率が2/3であることがわかるということである。"
      "この仕組みに気づければ、残りの２つの選択肢のうちモンティが勝手に候補を減らしてくれるので残りの一枚を選択すると2/3の確率で当たる仕組みになってることがわかる。")))
