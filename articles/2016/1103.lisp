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
      "最近媒介変数曲線描くのにはまってしまったのだが，今日はカージオイド描いてみました．
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
