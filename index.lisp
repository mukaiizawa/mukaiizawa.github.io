
(require "xml-manager" *module-xml-manager*)
(load "template")

(with-open-file (out "index.html"
                     :direction :output
                     :if-exists :supersede
                     :if-does-not-exist :create)
  (let ((*standard-output* out))
    (mkarticle
      (make-article
        :title "Goto Great"
        :time "2016-08-19"
        :tags  '("Linux" "Vim")
        :article (:article
                   (:a ((href (to-absolute "articles/2016/0819.html")))
                     (:h1 "Linux MintでVimをビルドしてみた")))))))


