
(require :template)

;; *source* {{{

(defparameter *source*
#<< END

<span class="Statement">package</span> main

<span class="Statement">import</span> (
  <span class="String">&quot;image&quot;</span>
  <span class="String">&quot;image/color&quot;</span>
  <span class="String">&quot;image/gif&quot;</span>
  <span class="String">&quot;os&quot;</span>
  <span class="String">&quot;math&quot;</span>
)

<span class="Comment">// x = r(t - sin(t))</span>
<span class="Comment">// y = r(1 - cos(t))</span>

<span class="Statement">var</span> palette = []color.Color{color.Black, color.RGBA{<span class="Number">0x0</span>, <span class="Number">0xff</span>, <span class="Number">0x0</span>, <span class="Number">0xff</span>}, color.RGBA{<span class="Number">0xff</span>, <span class="Number">0x00</span>, <span class="Number">0x0</span>, <span class="Number">0xff</span>}}

<span class="Statement">const</span> (
  BLACK = <span class="Number">0</span>
  GREEN = <span class="Number">1</span>
  RED = <span class="Number">2</span>
  r = <span class="Number">50</span>
  Δ = <span class="float">0.0001</span>
)

<span class="Statement">func</span> cycloid() {
  anim := gif.GIF{}
  <span class="Statement">for</span> t := <span class="float">0.0</span>; t &lt; <span class="Number">4</span>*math.Pi; t += <span class="float">0.1</span> {
    rect := image.Rect(<span class="Number">0</span>, <span class="Number">0</span>, <span class="Number">14</span>*r, <span class="Number">4</span>*r)
    img := image.NewPaletted(rect, palette)
    <span class="Comment">// circle</span>
    <span class="Statement">for</span> dθ := <span class="float">0.0</span>; dθ &lt; <span class="Number">2</span>*math.Pi; dθ += Δ {
      x := r*math.Cos(dθ) + r*t
      y := r*math.Sin(dθ) + r
      img.SetColorIndex(<span class="Type">int</span>(x), <span class="Type">int</span>(y), GREEN)
    }
    <span class="Comment">// circle axes</span>
    <span class="Statement">for</span> ds := <span class="float">0.0</span>; ds &lt;= r; ds += <span class="float">1.0</span> {
      x := -ds*math.Cos(t-math.Pi/<span class="Number">2</span>) + r*t
      y := ds*math.Sin(t-math.Pi/<span class="Number">2</span>) + r
      img.SetColorIndex(<span class="Type">int</span>(x), <span class="Type">int</span>(y), RED)
    }
    <span class="Comment">// trajectory</span>
    <span class="Statement">for</span> dt := <span class="float">0.0</span>; dt &lt; t; dt += Δ {
      dx := r*(dt - math.Sin(dt))
      dy := r*(<span class="Number">1</span> - math.Cos(dt))
      img.SetColorIndex(<span class="Type">int</span>(dx), <span class="Type">int</span>(dy), RED)
    }
    anim.Delay = <span class="Statement">append</span>(anim.Delay, <span class="Number">8</span>)
    anim.Image = <span class="Statement">append</span>(anim.Image, img)
  }
  gif.EncodeAll(os.Stdout, &amp;anim)
}

<span class="Statement">func</span> main() {
  cycloid()
}

END)

;; }}}

(make-article
  :title "Goでサイクロイド曲線描いてみた"
  :time "2016-10-31"
  :tags  '("Go")
  :article
  (list
    (:h1 "Goでサイクロイド曲線描いてみた")
    (:p
      "先日" (:a ((href (to-absolute "articles/2016/1028.html"))) "Goでリサージュ曲線書いてみた")
      "ので，ついでにサイクロイド曲線も書いてみました．
      最小作用の原理と最速効果曲線の話を思い出したりしたりしなかったり．")
    (:h2 "ソースコード")
    (:p
      "特にプログラム的には特殊なことはしていません．
      物理屋さんは座標系のとり方に違和感を覚えるかもしれませんが，座標変換めんどいのでこのままで．")
    (to-pre-code *source*)
    (import-img "2016/1031_01.gif" "サイクロイド曲線" "400" "200")
    (:p "サイクロイド曲線和む．")))

