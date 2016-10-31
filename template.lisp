
(require "xml-manager" *module-xml-manager*)
(provide "template")

(defparameter *http-root-path* "https://mukaiizawa.github.io/")

;; to-absolute {{{

(defun to-absolute (str)
  (mkstr *http-root-path* str))

;; }}}
;; import-img {{{

(defmacro import-img (str alt &optional (width 200) (height 200))
  `(:img ((src ,(image-path str)) (alt ,alt) (width ,width) (height ,height))))

;; }}}
;; resource-path {{{

(defun resource-path (str)
  (to-absolute (mkstr "resources/" str)))

;; }}}
;; image-path {{{

(defun image-path (str)
  (resource-path (mkstr "images/" str)))

;; }}}
;; link-vim-org {{{

(defmacro link-vim-org ()
  `(:a ((href "http://www.vim.org/download.php")) "vim.org"))

;; }}}

;; default-head {{{

(defmacro default-head (title)
  `(list
     (:meta ((charset "utf-8")))
     (:meta ((name "viewport") (content "width=device-width")))
     (:link ((href (resource-path "fonts/font-awesome-4.6.3/font-awesome.css")) (rel "stylesheet")))
     (:link ((href (resource-path "css/style.css")) (rel "stylesheet")))
     (:title ,title)))

;; }}}
;; default-page-header {{{

(defmacro default-page-header ()
  `(:header
     (:h1
       (:a ((href (to-absolute "index.html"))) "GoTo Great")
       (:p "偉大なエンジニアを目指して"))))

;; }}}
;; default-article-header {{{

(defmacro default-article-header (time tags)
  `(:header
     (:span ((class "fa fa-clock-o"))) (:time ((datetime ,time)) ,time)
     (loop for tag in ,tags
           collect
           (:span ((class "fa fa-tag")) tag))))

;; }}}
;; default-profile {{{

(defmacro default-profile ()
  `(:aside ((class "profile"))
     (:h1 "プロフィール")
     (:a ((href (to-absolute "profile.html")))
       (:img ((src (resource-path "images/profile_picture.png")) (alt "photo of mukaiizawa") (width "80px") (height "80px;"))))
     (:ul
       (:li (:a ((href "#")) (:span ((class "fa fa-male")) "mukaiizawa")))
       (:li (:a ((href "https://github.com/mukaiizawa") (target "_blank")) (:span ((class "fa fa-github")) "github")))
       (:li (:a ((href "mailto:mukaiizawa@yahoo.co.jp")) (:span ((class "fa fa-envelope-o")) "mukaiizawa@yahoo.co.jp"))))))

;; }}}
;; default-sidemenu {{{

(defmacro default-sidemenu ()
  `(:aside
     (:h1 "最新記事")
     (:ul
       (:li (:a ((href (to-absolute "articles/2016/1031.html"))) "Goでサイクロイド曲線描いてみた"))
       (:li (:a ((href (to-absolute "articles/2016/1028.html"))) "Goでリサージュ曲線描いてみた"))
       (:li (:a ((href (to-absolute "articles/2016/0822.html"))) "cssで段組を実装してみた"))
       (:li (:a ((href (to-absolute "articles/2016/0819.html"))) "Linux MintでVimをビルドしてみた"))
       )))

;; }}}
;; default-page-footer {{{

(defmacro default-page-footer ()
  `(:footer (:p "Copyright © mukaiizawa")))

;; }}}
;; default-scripts {{{

(defmacro default-scripts ()
  `(list
     (:script ((src (resource-path "scripts/jquery.js"))))
     (:script ((src (resource-path "scripts/common.js"))))))

;; }}}

(defstruct article
  (title "Goto Great")
  (article "comming soon...")
  (time "9999-99-99")
  (tags nil)
  (profile (default-profile))
  (sidemenu (default-sidemenu)))

(defmacro mkarticle (article)
  `(princ
     (DSL->xml
       (:!DOCTYPE "html")
       (:html ((lang "ja"))
         (:head (default-head (article-title ,article)))
         (:body
           (:div ((class "wrapper"))
             (default-page-header)
             (:div ((class "inline"))
               (:div ((class "contents"))
                 (:article
                   (default-article-header (article-time ,article) (article-tags ,article))
                   (article-article ,article)))
               (:div ((class "sidemenu"))
                 (article-profile ,article)
                 (article-sidemenu ,article)))
             (default-page-footer))
           (default-scripts))))))

