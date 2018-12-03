(require :template)

(defparameter *source* (list
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

(make-article
  :title "VimでJavaのgetterとsetterを作成する"
  :time "2016-11-03"
  :tags  '("Vim" "Java")
  :contents
  (list
    (:h1 "経緯")
    (:p "Vimでメンバを書き殴った後にEclipseにgetterとsetterを生成させていたんだけれども、"
      "そろそろVimで完結できるようにする。")
    (:p "要件は次の通り。"
      (:ul
        (:li "getterとsetterを同時に作成する")
        (:li "複数のメンバのアクセサを一括生成できる")
        (:li "余計な機能がない")))
    (:h1 "ソースコード")
    (:p "本当は字句解析して生成すべきなんだろうけど、"
      "VimScriptをごりごり書かけないので、nnoremapで済ませた。")
    (:p "次のソースコードを'~/.vim/after/ftplugin/java.vim'に記述する。"
      (to-pre-code (pop *source*)))
    (:p "<buffer> sa でバッファローカルなキーマップを定義。"
      "^で行のprivateに移動してtを使用して次のスペースの前まで移動。"
      "このため、型の宣言部にスペースを含んでいるとうまく動作しない。")
    (:p "maで現在の位置をマークし最後に戻るようにしてある。")
    (:p "記述順が、" (:br)
      (to-pre-code "メンバ->アクセサ->メンバ->アクセサ...")
      "よりも"
      (to-pre-code "メンバ->メンバ-> ... ->アクセサ->アクセサ...")
      "のほうが好みなので、G{でファイルの末尾の方にジャンプしている。")
    (:p "後は、レジスタtとnにそれぞれ型と変数名を登録し、アクセサを生成している。")
    (:p "最後に編集開始位置にジャンプし終了。")
    (:h2 "実行例")
    (:p "実行前" (to-pre-code (pop *source*))
      "実行後" (to-pre-code (pop *source*))
      "ちなみにvisualモード時に:'<,'>normal saで一括で作成可能。")
    (:h2 "注意事項")
    (:p "次の場合には期待通りの動作にならない。"
      (:ul
        (:li "変数名が一文字のとき")
        (:li "クラスの閉じカッコ}の上の行が空行でないとき")
        (:li "既存のgetter、setterは考慮しません")
        (:li "型名にスペースが含まれる場合(Map<String, int>等)")))))
