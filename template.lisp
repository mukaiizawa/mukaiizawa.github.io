
(require "xml-manager" *module-xml-manager*)
(provide "template")

(defmacro to-absolute (str)
  (mkstr "https://mukaiizawa.github.io/" str))

(defmacro link-vim-org ()
  `(:a ((href "http://www.vim.org/download.php")) "vim.org"))

(defmacro default-page-header ()
  `(:header
     (:h1
       (:a ((href (to-absolute "index.html"))) "GoTo Great")
       (:p "偉大なエンジニアを目指して"))))

(defmacro default-head (title)
  `(list
     (:meta ((charset "utf-8")))
     (:meta ((name "viewport") (content "width=device-width")))
     (:link ((href (to-absolute "resources/fonts/font-awesome-4.6.3/font-awesome.css")) (rel "stylesheet")))
     (:link ((href (to-absolute "resources/css/style.css")) (rel "stylesheet")))
     (:title ,title)))

(defmacro default-profile ()
  `(:aside ((class "profile"))
     (:h1 "プロフィール")
     (:a ((href "#"))
       (:img ((src (to-absolute "resources/images/profile_picture.png")) (alt "photo of mukaiizawa") (width "80px") (height "80px;"))))
     (:ul
       (:li (:a ((href "#")) (:span ((class "fa fa-male")) "mukaiizawa")))
       (:li (:a ((href "https://github.com/mukaiizawa") (target "_blank")) (:span ((class "fa fa-github")) "github")))
       (:li (:a ((href "mailto:mukaiizawa@yahoo.co.jp")) (:span ((class "fa fa-envelope-o")) "mukaiizawa@yahoo.co.jp"))))))

(defmacro default-sidemenu ()
  `(:aside
     (:h1 "最新記事")
     (:ul
       (:li (:a ((href (to-absolute "articles/2016/0819.html"))) "Linux MintでVimをビルドしてみた")))))

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
             (:div ((class "center-box"))
               (:div ((class "contents"))
                 (:article
                   (:header
                     (:span ((class "fa fa-clock-o"))) (:htime ((datetime (article-time ,article))) (article-time ,article))
                     (loop for tag in (article-tags ,article)
                           collect
                           (:span ((class "fa fa-tag")) tag)))
                   (article-article ,article)))
               (:div ((class "sidemenu"))
                 (article-profile ,article)
                 (article-sidemenu ,article)))
             (:footer ((class "page"))
               (:p "Copyright © mukaiizawa"))))))))

