(require :stdlib *module-stdlib*)
(load "template")

(defmacro default-head (title)
  `(list
     (:meta ((charset "utf-8")))
     (:meta ((name "viewport") (content "width=device-width")))
     (:link ((href (resource-path "fonts/font-awesome-4.6.3/font-awesome.css"))
             (rel "stylesheet")))
     (:link ((href (resource-path "css/style.css")) (rel "stylesheet")))
     (:link ((href (resource-path "css/code.css")) (rel "stylesheet")))
     (:title ,title)))

(defmacro article-header (article)
  `(when (article-time ,article)
     (list
       (:span ((class "fa fa-clock-o")))
       (:time ((datetime (article-time ,article))) (article-time ,article))
       (loop for tag in (article-tags ,article) collect
             (list (:span ((class "fa fa-tag")))
                   (:span tag))))))

(defmacro default-scripts ()
  `(list
     (:script ((src (resource-path "scripts/jquery.js"))))
     (:script ((src (resource-path "scripts/common.js"))))))

(defmacro site-footer ()
  `(:footer (:p "Copyright © 2016-2018 mukaiizawa")))

(defparameter *articles*
  (let ((articles nil))
    (mapfile (lambda (path)
               (with-open-file (in path :direction :input)
                 (let1 (article (do ((val (eval (read in t))
                                          (eval (read in t))))
                                  ((typep val 'article) val)))
                   (setf (article-path article)
                         (make-pathname :directory
                                        (list* :relative
                                               (last (pathname-directory path)
                                                     2))
                                        :name (pathname-name path)
                                        :type "html"))
                   (push article articles))))
             :directory "articles"
             :extension 'lisp
             :recursive t)
    articles))

;; サイドメニュー
; {{{

(defparameter *sidemenu*
  (list
    (:aside
      (:h1 "プロフィール")
      (:a ((href (to-absolute "profile.html")))
        (:img ((src (resource-path "images/profile_picture.png"))
               (alt "photo of mukaiizawa")
               (width "80px")
               (height "80px;"))))
      (:ul
        (:li (:a ((href (to-absolute "profile.html")))
               (:span ((class "fa fa-male"))) "mukaiizawa"))
        (:li (:a ((href "https://github.com/mukaiizawa") (target "_blank"))
               (:span ((class "fa fa-github"))) "github"))
        (:li (:a ((href "mailto:mukaiizawa@yahoo.co.jp"))
               (:span ((class "fa fa-envelope-o"))) "mukaiizawa@yahoo.co.jp"))))
    (:aside
      (:h1 "最新記事")
      (:ul (loop for article in *articles* collect
                 (:li (:a ((href (to-absolute (article-path article))))
                        (article-title article))))))))

; }}}

;; 記事一覧
; {{{

(defun make-index-page ()
  (make-article
    :title "記事一覧"
    :time nil
    :tags nil
    :path (make-pathname :directory '(:relative) :name "index" :type "html")
    :contents
    (list
      (loop for article in *articles* collect
            (list
              (:header
                (article-header article))
              (:section
                (:a ((href (to-absolute (article-path article))))
                  (article-title article))))))))

; }}}

;; プロフィール
; {{{

(defun make-profile-page ()
  (make-article
    :title "プロフィール"
    :time nil
    :tags nil
    :path (make-pathname :directory '(:relative) :name "profile" :type "html")
    :contents
    (list
      (:h1 "概要")
      (:p "大学では物理を専攻し、どこで間違ったのかプログラマーになった。"
        "Common LispとVimをこよなく愛する。"
        "車輪の再発明が大好きで、日々怪しいものを作成している。"
        "形式言語界隈が好きで勉強中。"
        "仕事はWeb系だけどあまり興味はない（爆）")
      (:p "最近は片手間に軽量プログラミング言語"
        (:a ((href "https://github.com/mukaiizawa/Paren")) "Paren")
        "を作成している。")
      (:p "シンプルを信条にしているが、気づいたらbiggerismに屈していて職場の先輩に馬鹿にされる。")

      (:h1 "言語")
      (:h2 "C")
      (:p "大学卒業まで一切プログラムを書いたことがなかったため、就職前に焦って勉強した言語。"
        "が、今日まで業務で使ったことはない（笑）"
        "Parenの作成に使用するため、必要に迫られて再学習した。")
      (:h2 "Java")
      (:p "業務で使用。"
        "Webアプリケーション等。"
        "趣味ではほとんど使用しない。")
      (:h2 "JavaScript")
      (:p "業務で使用。"
        "使用してもほとんどjQueryで、ピュアなjsはあまり使用したことはない。")
      (:h2 "Common Lisp")
      (:p "最も好きな言語。"
        "趣味で多用。"
        "このブログもS式から生成されている。"
        "ピュアなCommon Lispに、自作のライブラリを使用することが多い。"
        "そのため、パッケージマネージャーや標準でないライブラリには暗い。")
      (:h2 "VimScript")
      (:p "Vimが好きなのでほんの少し読み書き可能。"
        "生粋のVimScript職人の方々には常々脱帽。")
      (:h2 "Paren")
      (:p "現在作成中。学習コストが低く、シンプルなLL言語を目指している。")
      (:h2 "その他")
      (:p "Haskellに興味があるけどなかなか学べていない。")
      (:p "以下、少しでも触ったことがある言語。"
        (:ul
          (:li "Go")
          (:li "PL/0")
          (:li "Perl")
          (:li "Python")
          (:li "Scheme")
          (:li "VBA")))

      (:h1 "エディタ")
      (:p "Vim一筋。Emacs難しすぎた。（Lisperなのに。。。（爆））")
      (:p "そうとう'.vimrc'をいじることに時間を費やしてしまったが、結局素のVimに少しのプラグインに落ち着いた。")

      (:h1 "好きな本")
      (:h2 "データ構造+アルゴリズム=プログラム")
      (:p "職場の先輩に貸していただいた本。悲しことに絶版。")
      (:p "ソーティングアルゴリズム、バックトラックアルゴリズム、PL/0言語のコンパイラ作成等に感銘を受けた。")
      (:p "この業界に釘付けになったのは間違いなく、この本のせい。")
      (:h2 "ソフトウェア作法")
      (:p "ソフトウエア作成の精神を学んだ。今読み返しても学ぶことが多い一冊。")
      (:h2 "Land of Lisp")
      (:p "最初に読んだCommon Lispの本。"
        "当時は手続き的な書き方しか知らなかったため、非常にためになった。")
      (:h2 "On Lisp")
      (:p "Common Lispの良書。マクロをはじめ、多くのことを学べた。")
      (:h2 "ライト、ついてますか")
      (:p "問題解決の本。いかにして問題を解くかよりも砕けていて面白かった。")

      (:h1 "尊敬する人々")
      (:p
        (:ul
          (:li "Niklaus Wirth")
          (:li "Brian W. Kernighan")
          (:li "Paul Graham")
          (:li "Ken'ichi Tokuoka")
          (:li "川合 史朗"))))))

; }}}

(defmacro mkarticle (article)
  `(princ
     (DSL->xml
       (:!DOCTYPE "html")
       (:html ((lang "ja"))
         (:head (default-head (article-title ,article)))
         (:body
           (:div ((id "wrapper"))
             (:header ((id "title"))
               (:h1 (:a ((href (to-absolute "index.html"))) "GoTo Great"))
               (:p  "偉大なエンジニアを目指して"))
             (:div ((class "line"))
               (:div ((id "contents"))
                 (:article
                   (:header
                     (article-header ,article)
                     (:h1 (article-title ,article)))
                   (:section (article-contents ,article))))
               (:div ((id "sidemenu")) *sidemenu*))
             (site-footer))
           (default-scripts))))))

(defun make-articles ()
  (dolist (article (list* (make-index-page) (make-profile-page) *articles*))
    (print (article-path article))
    (let ((pathname-html (make-pathname
                           :type "html"
                           :defaults (article-path article))))
      (with-open-file (out pathname-html 
                           :direction :output
                           :if-exists :supersede
                           :if-does-not-exist :create)
        (let ((*standard-output* out))
          (mkarticle article))))))

(make-articles)

(print :finish)
