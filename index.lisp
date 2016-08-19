
(require "xml-manager" *module-xml-manager*)

(princ
  (DSL->xml
    (:!DOCTYPE "html")
    (:html ((lang "ja"))
      (:head
        (:meta ((charset "utf-8")))
        (:meta ((name "viewport") (content "width=device-width")))
        (:link ((href "resources/css/style.css") (rel "stylesheet"))))
      (:body
        (title)
        (:div ((class "box1")) "box1")
        (:div ((class "box2")) "box2")
        (:div ((class "boxA"))
          (:div ((class "box3")) "box3")
          (:div ((class "box4")) "box4"))
        (:div ((class "box5")) "box5")
        ))))

