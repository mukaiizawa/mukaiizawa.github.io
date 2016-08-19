
(require "xml-manager" *module-xml-manager*)

(princ
  (DSL->xml
    (:!DOCTYPE "html")
    (:html ((lang "ja"))
      (:head
        (:meta ((charset "utf-8")))
        (:meta ((name "viewport") (content "width=device-width")))
        (:link ((href "resources/fonts/font-awesome-4.6.3/font-awesome.css") (rel "stylesheet")))
        (:link ((href "resources/css/style.css") (rel "stylesheet"))))
      (:body
        (:div ((class "wrapper"))
          (:header
            (:h1
              (:a ((href "#")) "GoTo Great")
              (:p "偉大なエンジニアを目指して")))
          (:div ((class "center-box"))
            (:div ((class "contents"))
              (:article
                (:header
                  (:span ((class "fa fa-clock-o"))) (:htime ((datetime "2016-08-19")) "2016-08-19")
                  ; (:span ((class "fa fa-tag")) "html")
                  )
                (:h1 "ブログ開設しました")
                ; (:h2 "h2")
                (:p "vimとかLispについて備忘録を書いていく予定です．")))
            (:div ((class "sidemenu"))
              (:aside ((class "profile"))
                (:h1 "プロフィール")
                (:a ((href "#"))
                  (:img ((src "resources/images/profile_picture.png") (alt "photo of mukaiizawa") (width "80px") (height "80px;"))))
                (:ul
                  (:li (:a ((href "#")) (:span ((class "fa fa-male")) "mukaiizawa")))
                  (:li (:a ((href "https://github.com/mukaiizawa") (target "_blank")) (:span ((class "fa fa-github")) "github")))
                  (:li (:a ((href "mailto:mukaiizawa@yahoo.co.jp")) (:span ((class "fa fa-envelope-o")) "mukaiizawa@yahoo.co.jp")))))
              (:aside
                (:h1 "記事一覧")
                (:ul
                  (:li (:a ((href "#")) (:span ((class "fa fa-caret-right")) "page0")))
                  (:li (:a ((href "#")) (:span ((class "fa fa-caret-right")) "page1")))
                  (:li (:a ((href "#")) (:span ((class "fa fa-caret-right")) "page2")))
                  (:li (:a ((href "#")) (:span ((class "fa fa-caret-right")) "page3")))))))
          (:footer ((class "page"))
            (:p "Copyright © mukaiizawa")))))))

