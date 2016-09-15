
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
                (:h1 "プロフィール")
                (:p
                  "Common LispとVimが好きです．"
                  "このブログも実はLispで生成しています．"
                  "ですがEmacsは使えません．生粋のVimmerです．")))
            (:div ((class "sidemenu"))
              (default-profile)
              (default-sidemenu)))
          (default-page-footer)
          (default-scripts)))))
  "profile.html")
