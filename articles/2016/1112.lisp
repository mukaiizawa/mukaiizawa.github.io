
(require :template)

;; *source* {{{

(defparameter *source*
  (list
;; {{{
#<< END

<span class="Comment">&quot; add accessor</span>
<span class="Statement">nnoremap</span> <span class="Delimiter">&lt;</span><span class="Special">buffer</span><span class="Delimiter">&gt;</span> sa ^t mawv;&quot;ty;wve&quot;nyG{o
<span class="Special">      \\\\</span> public &lt;C-r&gt;t get&lt;C-r&gt;n&lt;ESC&gt;,3l~A() {&lt;CR&gt;
<span class="Special">      \\\\</span>   <span class="Statement">return</span> this<span class="Statement">.</span><span class="Delimiter">&lt;</span><span class="Special">C-r</span><span class="Delimiter">&gt;</span>n;<span class="Delimiter">&lt;</span><span class="Special">CR</span><span class="Delimiter">&gt;</span>
<span class="Special">      \\\\</span> }<span class="Delimiter">&lt;</span><span class="Special">CR</span><span class="Delimiter">&gt;&lt;</span><span class="Special">Esc</span><span class="Delimiter">&gt;</span><span class="Delimiter">{</span><span class="Statement">=</span>ap<span class="Delimiter">}</span><span class="Identifier">o</span>
<span class="Special">      \\\\</span> public void <span class="Statement">set</span><span class="PreProc">&lt;</span>C-r&gt;n<span class="PreProc">&lt;</span>Esc&gt;,3l~A(<span class="PreProc">&lt;</span>C-r&gt;t <span class="PreProc">&lt;</span>C-r&gt;n) {<span class="Special">&lt;CR&gt;</span>
<span class="Special">      \\\\</span>   this<span class="Statement">.</span><span class="Delimiter">&lt;</span><span class="Special">C-r</span><span class="Delimiter">&gt;</span>n <span class="Statement">=</span> <span class="Delimiter">&lt;</span><span class="Special">C-r</span><span class="Delimiter">&gt;</span>n;<span class="Delimiter">&lt;</span><span class="Special">CR</span><span class="Delimiter">&gt;</span>
<span class="Special">      \\\\</span> }<span class="Delimiter">&lt;</span><span class="Special">CR</span><span class="Delimiter">&gt;&lt;</span><span class="Special">Esc</span><span class="Delimiter">&gt;</span><span class="Delimiter">{</span><span class="Statement">=</span>ap<span class="Delimiter">}</span>`<span class="Statement">a</span>

END
;; }}}
;; {{{
#<< END

<span class="Type">public</span> <span class="Type">class</span> Test {

  <span class="Type">private</span> <span class="Type">int</span> id;

  <span class="Type">private</span> String str = <span class="String">&quot;a&quot;</span>;

  <span class="Type">private</span> Map&lt;String,String&gt; test;

  <span class="Type">public</span> <span class="Type">static</span> <span class="Type">void</span> main(String[] args) {
    <span class="Comment">// do main...</span>
  }

}

END
;; }}}
;; {{{
#<< END

<span class="Type">public</span> <span class="Type">class</span> Test {

  <span class="Type">private</span> <span class="Type">int</span> id;

  <span class="Type">private</span> String str = <span class="String">&quot;a&quot;</span>;

  <span class="Type">private</span> Map&lt;String,String&gt; test;

  <span class="Type">public</span> <span class="Type">static</span> <span class="Type">void</span> main(String[] args) {
    <span class="Comment">// do main...</span>
  }

  <span class="Type">public</span> <span class="Type">int</span> getId() {
    <span class="Statement">return</span> id;
  }

  <span class="Type">public</span> <span class="Type">void</span> setId(<span class="Type">int</span> id) {
    <span class="Type">this</span>.id = id;
  }

  <span class="Type">public</span> String getStr() {
    <span class="Statement">return</span> str;
  }

  <span class="Type">public</span> <span class="Type">void</span> setStr(String str) {
    <span class="Type">this</span>.str = str;
  }

  <span class="Type">public</span> Map&lt;String,String&gt; getTest() {
    <span class="Statement">return</span> test;
  }

  <span class="Type">public</span> <span class="Type">void</span> setTest(Map&lt;String,String&gt; test) {
    <span class="Type">this</span>.test = test;
  }

}

END
;; }}}
))

;; }}}

(make-article
  :title "VimでJavaのgetterとsetterを作成する"
  :time "2016-11-03"
  :tags  '("Vim" "Java")
  :article
  (list
    (:h1 "VimでJavaのgetterとsetterを作成する")
    (:p
      "従来はVimでメンバを書き散らしてからEclipseにgetterとsetterを生成させていたんだけれども，
      最近javaを書くときにgetterとsetterを書く機会が非常に増えたので，
      そろそろVimで完結させなきゃなと思ったので調べてみた．")
    (:s "CLOSみたいにアクセサくらい自動で生成してくれればいいのに．")
    (:h2 "Vimでgetterとsetterを生成")
    (:p
      "当然ながらすでにjavaのgetterとsetterを生成するプラグインは沢山あるようでした．
      個人的には"
    (:ul
      (:li "getterとsetterを同時に作成する")
      (:li "複数のメンバのアクセサを一括生成できる")
      (:li "余計な機能がない")
      (:li "使う人が挙動を把握できる"))
      "を満たしていればいいかなと．")
    (:p
      "そういった意味では個人的な趣味に合うものがなかったため今回は自作することにしました．")
    (:h2 "ソースコード")
    (:p
      "本当は字句解析して生成すべきなんだろうけど，
      VimScriptをごりごり書くことはできないため今回はファイルタイプごとのバッファーローカルなキーマップで済ませます．"
      (to-pre-code (pop *source*))
      "ソースを見てもらうとわかりますが，かなり愚直にやってます．")
    (:h2 "実行結果")
    (:p
      "こんな感じの動作をします．
      getterとsetterを追加したいメンバの行で`sa'を実行．" (:br)
      "実行前"
      (to-pre-code (pop *source*))
      "実行後"
      (to-pre-code (pop *source*))
      "ちなみにvisualモードからの:'<,'>normal saでも一括で行けていい感じです．")
    (:h2 "ソースコード解説")
    (:p
      "<buffer> sa でバッファローカルなキーマップを提供します．
      saは自分でもかなり微妙なマップだと思ってるのでお好みで．
      これでjavaファイルを開いた時のみ使えるマップとなります．
      ^で行のprivateに移動してtを使用して次のスペースの前まで移動します．
      このため，型の宣言部にスペースを含んでいるとうまく動作しません．
      maで現在の位置をマークして後で戻るために使用します．
      G{でファイルの最後の方にアクセサを記述します．" (:br)
      "メンバ->アクセサ->メンバ->アクセサ..." (:br)
      "よりも" (:br)
      "メンバ->メンバ-> ... ->アクセサ->アクセサ..." (:br)
      "のほうが好みなのでこうしています．
      wv;で型情報を範囲選択して，\"tyによりレジスタtに登録します．
      ;で次のスペースの手前まで移動して同じ要領で変数名をレジスタnに登録します．
      次の行からは見たまんまですね．
      レジスタに登録した型情報と変数名を使いながら無理やりアクセサを生成します．
      ~でアクセサの変数名の最初の文字を大文字にしているのは注意です．
      最後に編集開始位置にもどって終了です．")
    (:h2 "注意事項")
    (:p
      "自分が使うときには特に気にならないけど，以下の点には注意してください．"
    (:ul
      (:li "変数名が一文字のとき")
      (:li "クラスの閉じカッコ}の上の行が空行でないとき")
      (:li "既存のgetter，setterは考慮しません")
      (:li "型名にスペースが含まれる場合(Map<String, int>等)"))
      "これくらい気をつけておけば期待通りに動きます．")))


