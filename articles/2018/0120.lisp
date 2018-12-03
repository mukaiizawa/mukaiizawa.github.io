(require :template)

(defparameter *source* '(
#<< END

<span class="Delimiter">(</span><span class="Statement">macrolet</span> <span class="Delimiter">((</span><span class="Statement">and</span> <span class="Delimiter">(</span><span class="Type">&amp;rest</span> <span class="Statement">args</span><span class="Delimiter">)</span> <span class="Statement">t</span><span class="Delimiter">))</span>
  <span class="Delimiter">(</span><span class="Statement">if</span> <span class="Delimiter">(</span><span class="Statement">and</span> <span class="Delimiter">(</span><span class="Statement">=</span> a <span class="Number">1</span><span class="Delimiter">)</span> <span class="Delimiter">(</span><span class="Statement">=</span> a <span class="Number">2</span><span class="Delimiter">)</span> <span class="Delimiter">(</span><span class="Statement">=</span> a <span class="Number">3</span><span class="Delimiter">))</span>
    <span class="Delimiter">(</span><span class="Statement">print</span> <span class="Delimiter">'</span><span class="Identifier">hello</span><span class="Delimiter">)))</span>

END

))

(make-article
  :title "Common Lispで「(a ==1 && a== 2 && a==3)」の結果を真にする"
  :time "2018-01-20"
  :tags  '("Common Lisp")
  :contents
  (list
    (:h1 "ソースコード")
    (:p (:a ((href "https://stackoverflow.com/questions/48270127/can-a-1-a-2-a-3-ever-evaluate-to-true"))
          "Stack Overflow")
      "で白熱しているということで、便乗してCommon Lispで書いてみた。")
    (to-pre-code (pop *source*))))
