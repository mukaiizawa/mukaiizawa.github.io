(require :stdlib *module-stdlib*)
(load "template")

(defmacro default-head (title)
  `(list
     (:meta ((charset "utf-8")))
     (:meta ((name "viewport") (content "width=device-width")))
     (:link ((href (resource-path "fonts/font-awesome-4.6.3/font-awesome.css"))
             (rel "stylesheet")))
     (:link ((href (resource-path "css/style.css")) (rel "stylesheet")))
     (:link ((href (resource-path "css/code.css")) (rel "stylesheet")))
     (:title ,title)))

(defmacro site-banner ()
  `(:header
     (:h1
       (:a ((href (to-absolute "index.html"))) "GoTo Great")
       (:p "偉大なエンジニアを目指して"))))

(defmacro article-header (article)
  `(when (article-time ,article)
     (:header ((class "article-header"))
       (:span ((class "fa fa-clock-o")))
       (:time ((datetime (article-time ,article))) (article-time ,article))
       (loop for tag in (article-tags ,article)
             collect (:span ((class "fa fa-tag")) tag)))))

(defmacro default-scripts ()
  `(list
     (:script ((src (resource-path "scripts/jquery.js"))))
     (:script ((src (resource-path "scripts/common.js"))))))

(defmacro site-footer ()
  `(:footer (:p "Copyright © 2016-2018 mukaiizawa")))

(defparameter *articles*
  (let ((articles nil))
    (mapfile (lambda (path)
               (with-open-file (in path :direction :input)
                 (let1 (article (do ((val (eval (read in t))
                                          (eval (read in t))))
                                  ((typep val 'article) val)))
                   (setf (article-path article)
                         (make-pathname :directory (list* :relative
                                                          (last (pathname-directory path) 2))
                                        :name (pathname-name path)
                                        :type "html"))
                   (push article articles))))
             :directory "articles"
             :extension 'lisp
             :recursive t)
    articles))

(defparameter *sidemenu*
  (list
    (:aside
      (:h1 "プロフィール")
      (:a ((href (to-absolute "profile.html")))
        (:img ((src (resource-path "images/profile_picture.png"))
               (alt "photo of mukaiizawa")
               (width "80px")
               (height "80px;"))))
      (:ul
        (:li (:a ((href (to-absolute "profile.html")))
               (:span ((class "fa fa-male")) "mukaiizawa")))
        (:li (:a ((href "https://github.com/mukaiizawa")
                  (target "_blank"))
               (:span ((class "fa fa-github")) "github")))
        (:li (:a ((href "mailto:mukaiizawa@yahoo.co.jp"))
               (:span ((class "fa fa-envelope-o")) "mukaiizawa@yahoo.co.jp")))))
    (:aside
      (:h1 "最新記事")
      (:ul
        (loop for article in *articles*
              collect
              (:li (:a ((href (to-absolute (article-path article))))
                     (article-title article))))))))

(defun make-index-page ()
  (make-article
    :title "記事一覧"
    :time nil
    :tags nil
    :path (make-pathname :directory '(:relative) :name "index" :type "html")
    :contents
    (list
      (loop for article in *articles*
            collect
            (:article
              (article-header article)
              (:a ((href (to-absolute (article-path article))))
                (:h1 (article-title article))))))))


(defun make-profile-page ()
  (make-article
    :title "プロフィール"
    :time nil
    :tags nil
    :path (make-pathname :directory '(:relative) :name "profile" :type "html")
    :contents
    (list
      (:h1 "プロフィール")
      (:p
        "Common LispとVimが好きです．
        このブログも実はLispで生成しています．
        ですがEmacsは使えません．生粋のVimmerです．"))))

(defmacro mkarticle (article)
  `(princ
     (DSL->xml
       (:!DOCTYPE "html")
       (:html ((lang "ja"))
         (:head (default-head (article-title ,article)))
         (:body
           (:div ((id "wrapper"))
             (site-banner)
             (:div ((class "line"))
               (:div ((id "contents"))
                 (:article
                   (article-header ,article)
                   (article-contents ,article)))
               (:div ((id "sidemenu")) *sidemenu*))
             (site-footer))
           (default-scripts))))))

(defun make-articles ()
  (dolist (article (list* (make-index-page) (make-profile-page) *articles*))
    (print (article-path article))
    (let ((pathname-html (make-pathname
                           :type "html"
                           :defaults (article-path article))))
      (with-open-file (out pathname-html 
                           :direction :output
                           :if-exists :supersede
                           :if-does-not-exist :create)
        (let ((*standard-output* out))
          (mkarticle article))))))

(make-articles)
