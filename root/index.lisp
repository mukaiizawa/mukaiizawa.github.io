
(require "xml-manager" *module-xml-manager*)

(princ
  (DSL->xml
    (:!DOCTYPE "html")
    (:html
      (:meta ((charset "utf-8")))
      (:head
        (:link ((href "css/common.css") (rel "stylesheet"))))
      (:body
        (:a ((href "#")) "comming soon.")))))

