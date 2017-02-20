
(require :template)

;; *source* {{{

(defparameter *source* '(
#<< END
<span class="Delimiter">(</span><span class="Statement">defvar</span> dic <span class="Delimiter">'</span><span class="Special">(</span>進捗 どう です か ???<span class="Special">)</span><span class="Delimiter">)</span>

<span class="Delimiter">(</span><span class="Statement">defun</span> main <span class="Delimiter">(</span>lis<span class="Delimiter">)</span>
  <span class="Delimiter">(</span><span class="Statement">if</span> lis
    <span class="Delimiter">(</span><span class="Statement">let</span> <span class="Delimiter">((</span>sym <span class="Delimiter">(</span><span class="Statement">nth</span> <span class="Delimiter">(</span><span class="Statement">random</span> <span class="Delimiter">(</span><span class="Statement">length</span> dic<span class="Delimiter">))</span> dic<span class="Delimiter">)))</span>
      <span class="Delimiter">(</span><span class="Statement">princ</span> sym<span class="Delimiter">)</span>
      <span class="Delimiter">(</span><span class="Statement">if</span> <span class="Delimiter">(</span><span class="Statement">eq</span> sym <span class="Delimiter">(</span><span class="Statement">first</span> lis<span class="Delimiter">))</span>
        <span class="Delimiter">(</span>main <span class="Delimiter">(</span><span class="Statement">rest</span> lis<span class="Delimiter">))</span>
        <span class="Delimiter">(</span>main dic<span class="Delimiter">)))))</span>

<span class="Delimiter">(</span>main dic<span class="Delimiter">)</span>
END
))

;; }}}

(make-article
  :title "Common Lispで進捗どうですか"
  :time "2017-02-20"
  :tags  '("Common Lisp")
  :article
  (list
    (:h1 "Common Lispで進捗どうですか")
    (:p
      "今更感が拭えないのですが，暇つぶしにCommon Lispで進捗どうですかをつくりました．")
    (to-pre-code (pop *source*))))
