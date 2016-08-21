
(require "xml-manager" *module-xml-manager*)
(load "template")

(write-to!
  (DSL->xml
    (:!DOCTYPE "html")
    (:html ((lang "ja"))
      (:head (default-head "プロフィール"))
      (:body
        (:div ((class "wrapper"))
          (default-page-header)
          (:div ((class "center-box"))
            (:div ((class "contents"))
              (:article
                (default-article-header "2016-08-19" '("Linux" "Vim"))
                (:a ((href (to-absolute "articles/2016/0819.html")))
                  (:h1 "Linux MintでVimをビルドしてみた"))))
            (:div ((class "sidemenu"))
              (default-profile)
              (default-sidemenu)))
          (default-page-footer)))))
  "index.html")

