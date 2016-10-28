
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

<span class="Comment">// x = sin(a*t + delta)</span>
<span class="Comment">// y = sin(b*t)</span>

<span class="Statement">var</span> palette = []color.Color{color.Black, color.White, color.RGBA{<span class="Number">0x0</span>, <span class="Number">0xff</span>, <span class="Number">0x0</span>, <span class="Number">0xff</span>}}

<span class="Statement">const</span> (
  BLACK = <span class="Number">0</span>
  WHITE = <span class="Number">1</span>
  GREEN = <span class="Number">2</span>
  r = <span class="Number">100</span>
  frame = <span class="Number">10</span>
  delay = <span class="Number">10</span>
)

<span class="Statement">func</span> lissajous(a <span class="Type">float64</span>, b <span class="Type">float64</span>) {
  anim := gif.GIF{LoopCount: frame}
  phase := <span class="Float">0.0</span>
  <span class="Statement">for</span> i := <span class="Number">0</span>; i &lt; frame; i++ {
    rect := image.Rect(<span class="Number">0</span>, <span class="Number">0</span>, <span class="Number">2</span>*r, <span class="Number">2</span>*r)
    img := image.NewPaletted(rect, palette)
    <span class="Statement">for</span> t := <span class="Float">0.0</span>; t &lt; <span class="Number">2</span>*math.Pi; t += <span class="Float">0.0001</span> {
      x := math.Sin(a * t)
      y := math.Sin(b * t + phase)
      img.SetColorIndex(r+<span class="Type">int</span>(x*r), r+<span class="Type">int</span>(y*r), GREEN)
    }
    <span class="Statement">for</span> i := <span class="Number">0</span>; i &lt;= <span class="Number">2</span>*r; i++ {
      img.SetColorIndex(r, i, GREEN)
      img.SetColorIndex(i, r, GREEN)
    }
    phase += <span class="Float">0.1</span>
    anim.Delay = <span class="Statement">append</span>(anim.Delay, delay)
    anim.Image = <span class="Statement">append</span>(anim.Image, img)
  }
  gif.EncodeAll(os.Stdout, &amp;anim)
}

<span class="Statement">func</span> main() {
  a := <span class="Float">1.0</span>
  b := <span class="Float">1.0</span>
  argc := <span class="Statement">len</span>(os.Args[<span class="Number">1</span>:])
  <span class="Statement">if</span> argc &gt;= <span class="Number">1</span>  &amp;&amp; argc &lt;= <span class="Number">2</span>{
    a, _ = strconv.ParseFloat(os.Args[<span class="Number">1</span>], <span class="Number">64</span>)
  } <span class="Statement">else</span> <span class="Statement">if</span> argc == <span class="Number">2</span> {
    b, _ = strconv.ParseFloat(os.Args[<span class="Number">2</span>], <span class="Number">64</span>)
  }
  lissajous(a, b)
}

END
)

;; }}}

(make-article
  :title "Goでリサージュ曲線描いてみた"
  :time "2016-10-28"
  :tags  '("Go")
  :article
  (list
    (:h1 "Goでリサージュ曲線描いてみた")
    (:p "最近Goの勉強をはじめてみました．
      いままでLispしか真面目に勉強した言語がないのでいろいろ戸惑っています．
      プログラミング言語Go (ADDISON-WESLEY PROFESSIONAL COMPUTING SERIES COMPUTING SERIES)
      Alan A.A. Donovan (著), Brian W. Kernighan (著), 柴田 芳樹 (翻訳)を読んで勉強してます．
      チュートリアルの章から良書の予感．今日はその中でリサージュ曲線描くプログラムがあったのでそれを改造したものを紹介します．")
    (:h2 "ソースコード")
    (:p
      "ぐだぐだ説明するよりも出来上がったGIFとソースコードを見ていただいたほうが早いので掲載します．
      リサージュ曲線和む．")
    (to-pre-code *source*)
    (:p
      "原本はランダムでリサージュ図形が作成される実装になっていたけども，
      好きなリサージュ曲線を描けるようにコマンドライン引数を使えるようにしました．")
    (:img ((src (to-absolute "resources/images/1028_01.gif")) (alt "リサージュ曲線")))
    (:p "a=1, b=1")
    (:img ((src (to-absolute "resources/images/1028_02.gif")) (alt "リサージュ曲線")))
    (:p "a=1, b=2")
    (:img ((src (to-absolute "resources/images/1028_03.gif")) (alt "リサージュ曲線")))
    (:p "a=3, b=4")
    (:p "リサージュ曲線和む．")))
