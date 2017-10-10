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
END

#<< END
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
    (:h1 "Common Lispでモンティーホール問題のシミュレーション")
    (:p
      "暇つぶしにモンティーホール問題をCommon Lispでシミュレーションする機会があり、
      綺麗に書くことができたので記事にしようと思い立ちました。")

    (:h1 "モンティーホール問題とは")
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
        )
      "
      私も他の人が考えるであろう選択肢を変えようが変えまいが、
      当たる確率は1/2だと思っていたのでとりあえずシミュレーションすることにしました。
      ")

    (:h1 "シミュレーション")
    (:p "まずはソースコードを載せます。")
    (to-pre-code (pop *source*))
    (:p
      "
      do-gameは一回ゲームを試行する関数です。
      ゲームをする際にモンティーがドアを開けた後に選択を変更する否かを決める引数を一つ受け取ります。
      この関数はユーザが勝ったか(モンティと選択が一致したか)否かを返します。
      ユーザとモンティの選択はそれぞれ0から2の数字で表現されています。
      ユーザが選択を変更する場合、モンティーが開けなかったドアを選択します。
      その後、ユーザとモンティが一致しているか判定した結果を返します。
      ")

    (:p
      "
      monty-hole-problemはグローバル変数*test-times*に代入されている回数だけdo-gameを試行し、
      ユーザが選択を固定した場合とそうでない場合の勝率を集計して結果を表示します。
      本当は、選択を固定する場合とそうでない場合で、
      do-gameを実行する乱数のシードは同じにすべきですが、
      試行回数が十分に多ければ統計として確からしいこととしました。
      ") 

    (:h1 "実行結果")
    (:p "関数を呼び出します。")
    (to-pre-code (pop *source*))
    (:p "実行結果はこうなりました。")
    (to-pre-code (pop *source*))
    (:p "このように、選択を常に変更する場合は2/3の確率となり、常に変更しない場合は1/3となります。")

    (:h1 "考察")
    (:p
      "モンティがドアを開けた後から来た人からすると、
      確かにこのゲームの勝率はどのようにユーザが振る舞っても1/2になると思います。"
      (:q "つまり、残る２つのドアのうちどちらかに当たりがあります。")
      "という状況。")
      (:p
        "
        この問題が面白いのは、最初からゲームに参加していた人には、
        ドアを開ける前にユーザが選んでいた選択が当たりの確立は1/3で、
        その他の2つのドアに当たりがある確率が2/3であることがわかるということです。
        この単純な仕組みに気づければ、残りの２つの選択肢のうちモンティが勝手に候補を減らしてくれるので残りの一枚を選択すると2/3の確率で当たるわけです。
        説明されると納得できるものですが、最初からこの事実に気づくのは難しいですね。
        ")))
