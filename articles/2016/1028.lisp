(require :template)

(defparameter *source* (list
; lissajous {{{

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

END

; }}}
; cycloid {{{

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

END

; }}}
; astroid {{{

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

END

; }}}
; cardioid {{{

#<< END

<span class="Statement">package</span> main

<span class="Statement">import</span> (
  <span class="String">&quot;image&quot;</span>
  <span class="String">&quot;image/color&quot;</span>
  <span class="String">&quot;image/gif&quot;</span>
  <span class="String">&quot;math&quot;</span>
  <span class="String">&quot;os&quot;</span>
)

<span class="Comment">// x = 2r(1+cos(t))cos(t)</span>
<span class="Comment">// y = 2r(1+cos(t))sin(t)</span>

<span class="Statement">var</span> palette = []color.Color{color.Black, color.RGBA{<span class="Number">0x0</span>, <span class="Number">0xff</span>, <span class="Number">0x0</span>, <span class="Number">0xff</span>}, color.RGBA{<span class="Number">0xff</span>, <span class="Number">0x00</span>, <span class="Number">0x0</span>, <span class="Number">0xff</span>}}

<span class="Statement">const</span> (
  BLACK = <span class="Number">0</span>
  GREEN = <span class="Number">1</span>
  RED = <span class="Number">2</span>
  r = <span class="Number">40</span>
)

<span class="Statement">func</span> cardioid() {
  anim := gif.GIF{}
  <span class="Statement">for</span> t := <span class="float">0.0</span>; t &lt; <span class="Number">2</span>*math.Pi; t += <span class="float">0.02</span> {
    rect := image.Rect(<span class="Number">0</span>, <span class="Number">0</span>, <span class="Number">6</span>*r, <span class="Number">6</span>*r)
    img := image.NewPaletted(rect, palette)
    <span class="Statement">for</span> ds := <span class="Number">0</span>; ds &lt;= <span class="Number">6</span>*r; ds++ {
      <span class="Comment">// coordinate axes</span>
      img.SetColorIndex(<span class="Number">3</span>*r, ds, GREEN)
      img.SetColorIndex(ds, <span class="Number">3</span>*r, GREEN)
    }
    <span class="Statement">for</span> dθ := <span class="float">0.0</span>; dθ &lt;= <span class="Number">2</span>*math.Pi; dθ += <span class="float">0.001</span> {
      <span class="Comment">// center circle</span>
      x1 := r * math.Cos(dθ)
      y1 := r * math.Sin(dθ)
      img.SetColorIndex(<span class="Number">3</span>*r+<span class="Type">int</span>(x1), <span class="Number">3</span>*r+<span class="Type">int</span>(y1), GREEN)
      <span class="Comment">// outer circle </span>
      x2 := <span class="Number">2</span>*r*math.Cos(t) + r*math.Cos(dθ)
      y2 := <span class="Number">2</span>*r*math.Sin(t) + r*math.Sin(dθ)
      img.SetColorIndex(<span class="Number">3</span>*r+<span class="Type">int</span>(x2), <span class="Number">3</span>*r+<span class="Type">int</span>(y2), GREEN)
    }
    <span class="Statement">for</span> ds := <span class="float">0.0</span>; ds &lt;= r; ds += <span class="float">1.0</span> {
      <span class="Comment">// cardioid axes</span>
      x := ds*math.Cos(<span class="Number">2</span>*t) + <span class="Number">2</span>*r*math.Cos(t)
      y := ds*math.Sin(<span class="Number">2</span>*t) + <span class="Number">2</span>*r*math.Sin(t)
      img.SetColorIndex(<span class="Number">3</span>*r+<span class="Type">int</span>(x), <span class="Number">3</span>*r+<span class="Type">int</span>(y), RED)
    }
    <span class="Statement">for</span> dt := <span class="float">0.0</span>; dt &lt;= t; dt += <span class="float">0.001</span>{
      <span class="Comment">// trajectory</span>
      x := <span class="Number">2</span> * r * (<span class="Number">1</span> + math.Cos(dt)) * math.Cos(dt)
      y := <span class="Number">2</span> * r * (<span class="Number">1</span> + math.Cos(dt)) * math.Sin(dt)
      img.SetColorIndex(<span class="Number">2</span>*r+<span class="Type">int</span>(x), <span class="Number">3</span>*r+<span class="Type">int</span>(y), RED)
    }
    anim.Delay = <span class="Statement">append</span>(anim.Delay, <span class="Number">6</span>)
    anim.Image = <span class="Statement">append</span>(anim.Image, img)
  }
  gif.EncodeAll(os.Stdout, &amp;anim)
}

<span class="Statement">func</span> main() {
  cardioid()
}

END

; }}}
))

(make-article
  :title "Go言語で媒介変数表示された曲線の描画"
  :time "2016-10-28"
  :tags  '("Go")
  :contents
  (list
    (:h1 "経緯")
    (:p "最近Goの勉強をはじめてみた。"
      "とりあえず、プログラミング言語Go (ADDISON-WESLEY PROFESSIONAL COMPUTING SERIES COMPUTING SERIES)"
      "Alan A.A. Donovan (著), Brian W. Kernighan (著), 柴田 芳樹 (翻訳)を読んでいる。")
    (:p "例題にリサージュ曲線の描画があったから、触発されていろんな媒介変数表示された曲線を描いてみた。")
    (:h1 "リサージュ曲線")
    (:p "例題から、好きなリサージュ曲線を描けるようにコマンドライン引数を受け取るように修正。"
      (to-pre-code (pop *source*))
      "a=1, b=1"
      (import-img "2016/1028_01.gif" "リサージュ曲線1") (:br)
      "a=1, b=2"
      (import-img "2016/1028_02.gif" "リサージュ曲線2") (:br)
      "a=3, b=4"
      (import-img "2016/1028_03.gif" "リサージュ曲線3"))
    (:h1 "サイクロイド曲線")
    (:p "最速降下曲線。"
      (to-pre-code (pop *source*))
      (import-img "2016/1028_04.gif" "サイクロイド曲線"))
    (:h1 "アステロイド曲線")
    (:p "座標系の取り方があれなので、若干ソースが。"
      (to-pre-code (pop *source*))
      (import-img "2016/1028_05.gif" "アストロイド曲線"))
    (:h1 "カージオイド曲線")
    (:p "大学１年の年賀状にカージオイド描いてくれた"
      (:s "変態") "友人がいたなと思い出す。"
      (to-pre-code (pop *source*))
      (import-img "2016/1028_06.gif" "カージオイド曲線"))))
