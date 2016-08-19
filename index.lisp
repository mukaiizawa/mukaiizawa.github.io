
(require "xml-manager" *module-xml-manager*)
(load "template")

(with-open-file (out "index.html"
                     :direction :output
                     :if-exists :supersede
                     :if-does-not-exist :create)
  (let ((*standard-output* out))
    (mkarticle
      :title "hello"
      :article (list (:article "comming soon...")
                     (:article "comming soon...")))))


