
(require "template")

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
  <span class="String">&quot;strconv&quot;</span>
)

<span class="Comment">// x = sin(a*t + phase)</span>
<span class="Comment">// y = sin(b*t)</span>

<span class="Statement">var</span> palette = []color.Color{color.Black, color.RGBA{<span class="Number">0x0</span>, <span class="Number">0xff</span>, <span class="Number">0x0</span>, <span class="Number">0xff</span>}}

<span class="Statement">const</span> (
  BLACK = <span class="Number">0</span>
  GREEN = <span class="Number">1</span>
  r = <span class="Number">100</span>
  delay = <span class="Number">6</span>
)

<span class="Statement">func</span> lissajous(a <span class="Type">float64</span>, b <span class="Type">float64</span>) {
  anim := gif.GIF{}
  <span class="Statement">for</span> phase := <span class="float">0.0</span>; phase &lt; <span class="Number">2</span>*math.Pi; phase += math.Pi/<span class="Number">64</span> {
    rect := image.Rect(<span class="Number">0</span>, <span class="Number">0</span>, <span class="Number">2</span>*r, <span class="Number">2</span>*r)
    img := image.NewPaletted(rect, palette)
    <span class="Statement">for</span> t := <span class="float">0.0</span>; t &lt; <span class="Number">2</span>*math.Pi; t += <span class="float">0.0001</span> {
      x := math.Sin(a*t)
      y := math.Sin(b*t + phase)
      img.SetColorIndex(r+<span class="Type">int</span>(x*r), r+<span class="Type">int</span>(y*r), GREEN)
    }
    <span class="Statement">for</span> i := <span class="Number">0</span>; i &lt;= <span class="Number">2</span>*r; i++ {
      img.SetColorIndex(r, i, GREEN)
      img.SetColorIndex(i, r, GREEN)
    }
    anim.Delay = <span class="Statement">append</span>(anim.Delay, delay)
    anim.Image = <span class="Statement">append</span>(anim.Image, img)
  }
  gif.EncodeAll(os.Stdout, &amp;anim)
}

<span class="Statement">func</span> main() {
  a := <span class="float">1.0</span>
  b := <span class="float">1.0</span>
  argc := <span class="Statement">len</span>(os.Args[<span class="Number">1</span>:])
  <span class="Statement">if</span> <span class="Number">1</span> &lt;= argc &amp;&amp; argc &lt;= <span class="Number">2</span>{
    a, _ = strconv.ParseFloat(os.Args[<span class="Number">1</span>], <span class="Number">64</span>)
  }
  <span class="Statement">if</span> argc == <span class="Number">2</span> {
    b, _ = strconv.ParseFloat(os.Args[<span class="Number">2</span>], <span class="Number">64</span>)
  }
  lissajous(a, b)
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
      "先日" (:a ((href (to-absolute "articles/2016/1028.html"))) "Goでリサージュ曲線書いた")
      "ので，ついでにサイクロイド曲線も書いてみました．
      最小作用の原理と最速効果曲線の話を思い出したりしたりしなかったり．")
    (:h2 "ソースコード")
    (:p
      "特にプログラム的には特殊なことはしていません．
      物理屋さんは座標系のとり方に違和感を覚えるかもしれませんが，座標変換めんどいのでこのままで．")
    (to-pre-code *source*)
    (import-img "2016/1031_01.gif" "サイクロイド曲線")
    (:p "サイクロイド曲線和む．")))

