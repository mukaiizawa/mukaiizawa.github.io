
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
          (:div ((class "inline"))
            (:div ((class "contents"))
              (:article
                (default-article-header "2016-11-02" '("Go"))
                (:a ((href (to-absolute "articles/2016/1102.html")))
                  (:h1 "Goでアストロイド曲線描いてみた")))
              (:article
                (default-article-header "2016-10-31" '("Go"))
                (:a ((href (to-absolute "articles/2016/1031.html")))
                  (:h1 "Goでサイクロイド曲線描いてみた")))
              (:article
                (default-article-header "2016-10-28" '("Go"))
                (:a ((href (to-absolute "articles/2016/1028.html")))
                  (:h1 "Goでリサージュ曲線描いてみた")))
              (:article
                (default-article-header "2016-08-22" '("html"))
                (:a ((href (to-absolute "articles/2016/0822.html")))
                  (:h1 "cssで段組実装時に２段になってしまう")))
              (:article
                (default-article-header "2016-08-19" '("Linux" "Vim"))
                (:a ((href (to-absolute "articles/2016/0819.html")))
                  (:h1 "Linux MintでVimをビルドしてみた"))))
            (:div ((class "sidemenu"))
              (default-profile)
              (default-sidemenu)))
          (default-page-footer))
        (default-scripts))))
  "index.html")

