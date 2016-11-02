
(require :template)

;; *source* {{{

(defparameter *source*
#<< END

package main

import (
  "image"
  "image/color"
  "image/gif"
  "math"
  "os"
)

// x = 2r(1+cos(t))cos(t)
// y = 2r(1+cos(t))sin(t)

var palette = []color.Color{color.Black, color.RGBA{0x0, 0xff, 0x0, 0xff}, color.RGBA{0xff, 0x00, 0x0, 0xff}}

const (
  BLACK = 0
  GREEN = 1
  RED = 2
  r = 40
)

func cardioid() {
  anim := gif.GIF{}
  for t := 0.0; t < 2*math.Pi; t += 0.02 {
    rect := image.Rect(0, 0, 6*r, 6*r)
    img := image.NewPaletted(rect, palette)
    for ds := 0; ds <= 6*r; ds++ {
      // coordinate axes
      img.SetColorIndex(3*r, ds, GREEN)
      img.SetColorIndex(ds, 3*r, GREEN)
    }
    for dθ := 0.0; dθ <= 2*math.Pi; dθ += 0.001 {
      // center circle
      x1 := r * math.Cos(dθ)
      y1 := r * math.Sin(dθ)
      img.SetColorIndex(3*r+int(x1), 3*r+int(y1), GREEN)
      // outer circle 
      x2 := 2*r*math.Cos(t) + r*math.Cos(dθ)
      y2 := 2*r*math.Sin(t) + r*math.Sin(dθ)
      img.SetColorIndex(3*r+int(x2), 3*r+int(y2), GREEN)
    }
    for ds := 0.0; ds <= r; ds += 1.0 {
      // cardioid axes
      x := ds*math.Cos(2*t) + 2*r*math.Cos(t)
      y := ds*math.Sin(2*t) + 2*r*math.Sin(t)
      img.SetColorIndex(3*r+int(x), 3*r+int(y), RED)
    }
    for dt := 0.0; dt <= t; dt += 0.001{
      // trajectory
      x := 2 * r * (1 + math.Cos(dt)) * math.Cos(dt)
      y := 2 * r * (1 + math.Cos(dt)) * math.Sin(dt)
      img.SetColorIndex(2*r+int(x), 3*r+int(y), RED)
    }
    anim.Delay = append(anim.Delay, 6)
    anim.Image = append(anim.Image, img)
  }
  gif.EncodeAll(os.Stdout, &anim)
}

func main() {
  cardioid()
}

END)

;; }}}

(make-article
  :title "Goでカージオイド曲線描いてみた"
  :time "2016-11-03"
  :tags  '("Go")
  :article
  (list
    (:h1 "Goでカージオイド曲線描いてみた")
    (:p
      "最近媒介変数曲線描くのにはまってしまったのだが，今日はアストロイド描いて見ました．
      今までの記事はこちら．"
      (:ul
        (:li (:a ((href (to-absolute "articles/2016/1028.html"))) "Goでリサージュ曲線書いてみた"))
        (:li (:a ((href (to-absolute "articles/2016/1031.html"))) "Goでサイクロイド曲線書いてみた"))
        (:li (:a ((href (to-absolute "articles/2016/1102.html"))) "Goでアストロイド曲線書いてみた")))
      "最近媒介変数曲線ばっかり書いていてGo的には何も成長していない．当初の目的からだいぶ外れちゃった気がするけど，
       かなり楽しめているからいいか．でもそろそろ文法も勉強しなきゃだな．")
    (:h2 "ソースコード")
    (:p
      "今回は外側の円の棒も描いてみました．これで軌跡が追いやすくなりましたとさ．
      相変わらず，座標変換には苦戦しています．")
    (to-pre-code *source*)
    (import-img "2016/1103_01.gif" "カージオイド曲線")
    (:p
      "かれこれ５年前になるけども，
      大学１年の年賀状にカージオイド描いてくれた" (:s "変態") "友人がいたなと．
      カージオイド曲線和む．")))

