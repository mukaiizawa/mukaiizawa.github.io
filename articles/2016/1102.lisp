
(require :template)

;; *source* {{{

(defparameter *source*
#<< END

<span class="Statement">package</span> main

<span class="Statement">import</span> (
  <span class="String">&quot;image&quot;</span>
  <span class="String">&quot;image/color&quot;</span>
  <span class="String">&quot;image/gif&quot;</span>
  <span class="String">&quot;math&quot;</span>
  <span class="String">&quot;os&quot;</span>
)

<span class="Comment">// x = r(cos(t))^3 = r*(3cos(t)+cos(3t))/4</span>
<span class="Comment">// y = r(sin(t))^3 = r*(3sin(t)-sin(3t))/4</span>

<span class="Statement">var</span> palette = []color.Color{color.Black, color.RGBA{<span class="Number">0x0</span>, <span class="Number">0xff</span>, <span class="Number">0x0</span>, <span class="Number">0xff</span>}, color.RGBA{<span class="Number">0xff</span>, <span class="Number">0x0</span>, <span class="Number">0x0</span>, <span class="Number">0xff</span>}}

<span class="Statement">const</span> (
  BLACK = <span class="Number">0</span>
  GREEN = <span class="Number">1</span>
  RED = <span class="Number">2</span>
  r = <span class="Number">100</span>
)

<span class="Statement">func</span> astroid() {
  anim := gif.GIF{}
  <span class="Statement">for</span> t := <span class="float">0.0</span>; t &lt; <span class="Number">2</span>*math.Pi; t += <span class="float">0.02</span>{
    rect := image.Rect(<span class="Number">0</span>, <span class="Number">0</span>, <span class="Number">2</span>*r, <span class="Number">2</span>*r)
    img := image.NewPaletted(rect, palette)
    <span class="Statement">for</span> ds := <span class="Number">0</span>; ds &lt;= <span class="Number">2</span>*r; ds++ {
      <span class="Comment">// coordinate axes</span>
      img.SetColorIndex(r, ds, GREEN)
      img.SetColorIndex(ds, r, GREEN)
    }
    <span class="Statement">for</span> ds := <span class="float">0.0</span>; ds &lt;= r/<span class="Number">4</span>; ds += <span class="float">1.0</span> {
      <span class="Comment">// cardioid axes</span>
      x := ds*math.Cos(-<span class="Number">3</span>*t) + (r*<span class="Number">3</span>/<span class="Number">4</span>)*math.Cos(t)
      y := ds*math.Sin(-<span class="Number">3</span>*t) + (r*<span class="Number">3</span>/<span class="Number">4</span>)*math.Sin(t)
      img.SetColorIndex(r+<span class="Type">int</span>(x), r+<span class="Type">int</span>(y), RED)
    }
    <span class="Statement">for</span> dθ := <span class="float">0.0</span>; dθ &lt;= <span class="Number">2</span>*math.Pi; dθ += <span class="float">0.001</span> {
      <span class="Comment">// small circle </span>
      x1 := (<span class="Number">3</span>*r/<span class="Number">4</span>)*math.Cos(t) + (r/<span class="Number">4</span>)*math.Sin(dθ)
      y1 := (<span class="Number">3</span>*r/<span class="Number">4</span>)*math.Sin(t) + (r/<span class="Number">4</span>)*math.Cos(dθ)
      img.SetColorIndex(r+<span class="Type">int</span>(x1), r+<span class="Type">int</span>(y1), GREEN)
      <span class="Comment">// large circle</span>
      x2 := r * math.Cos(dθ)
      y2 := r * math.Sin(dθ)
      img.SetColorIndex(r+<span class="Type">int</span>(x2), r+<span class="Type">int</span>(y2), GREEN)
    }
    <span class="Statement">for</span> dt := <span class="float">0.0</span>; dt &lt;= t; dt += <span class="float">0.001</span>{
      <span class="Comment">// trajectory</span>
      x := r * (<span class="Number">3</span>*math.Cos(dt) + math.Cos(<span class="Number">3</span>*dt)) / <span class="Number">4</span>
      y := r * (<span class="Number">3</span>*math.Sin(dt) - math.Sin(<span class="Number">3</span>*dt)) / <span class="Number">4</span>
      img.SetColorIndex(r+<span class="Type">int</span>(x), r+<span class="Type">int</span>(y), RED)
    }
    anim.Delay = <span class="Statement">append</span>(anim.Delay, <span class="Number">6</span>)
    anim.Image = <span class="Statement">append</span>(anim.Image, img)
  }
  gif.EncodeAll(os.Stdout, &amp;anim)
}

<span class="Statement">func</span> main() {
  astroid()
}

END)

;; }}}

(make-article
  :title "Goでアストロイド曲線描いてみた"
  :time "2016-11-02"
  :tags  '("Go")
  :article
  (list
    (:h1 "Goでアストロイド曲線描いてみた")
    (:p
      "最近媒介変数曲線描くのにはまってしまったのだが，今日はアストロイド描いて見ました．
      今までの記事はこちら．"
      (:ul
        (:li (:a ((href (to-absolute "articles/2016/1028.html"))) "Goでリサージュ曲線書いてみた"))
        (:li (:a ((href (to-absolute "articles/2016/1031.html"))) "Goでサイクロイド曲線書いてみた"))))
    (:h2 "ソースコード")
    (:p
      "なかの円を描くのに手間取ってしまった．
      原点のとり方って大事だよなーと座標変換しながら思う今日このごろ．")
    (to-pre-code *source*)
    (import-img "2016/1102_01.gif" "アストロイド曲線")
    (:p "アストロイド曲線和む．")))


