
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
                (:h1 "プロフィール")
                (:p
                  "Common LispとVimが好きです．"
                  "このブログも実はLispで書かれていたりいなかったりして．"
                  "ですがEmacsは使えません．生粋のVimmerです．")
                (:p
                  "たくさんの先人のVimmerの方々のWebの情報により，ここまで成長することができました．"
                  "感謝の気持ちを込めてVimmer入門のためVimtutor for Webの作成を考えております．"
                  "このサイトもたくさんの人々の役に立ちますように．")))
            (:div ((class "sidemenu"))
              (default-profile)
              (default-sidemenu)))
          (default-page-footer)))))
  "profile.html")
