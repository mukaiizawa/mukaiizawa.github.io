
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
        (:div ((class "wrapper"))
          (title)
          (:div ((class "boxA"))
            (:div ((class "box3"))
              (:article ((class "content"))
                (:h1 "もぎたてトマトをおいしく食べたい")
                (:p
                  "もぎたてのトマトを食べたくなって，ちょっと郊外にあるトマトの農家さんの直売所まで行ってきました．
                  ここのトマトは新鮮で，おいしくて，お安いという，とってもお買い得なトマトなんです．")
                (:p
                  "もぎたての新鮮なトマトは，下手が緑色でみずみずしく，シャキっとしてます．
                  赤い実は皮がピンと張り，つるっと丸いものがいいのだとか．糖度の高いトマトは水に沈むそうですが，
                  何でも甘ければよいというものではないので，好みの味のトマトを作る農家さんを見つけたいところです．")))
                  (:div ((class "box4"))
                    (:aside "box4"
                      )))
                  (:div ((class "box5")) "box5")
                  )))))

