(require :stdlib *module-stdlib*)
(load "template")

(defun get-article (pathname)
  (with-open-file (in pathname :direction :input)
    (do ((val (eval (read in t))
              (eval (read in t))))
      ((typep val 'article) val))))

(mapfile (lambda (pathname)
           (princln pathname)
           (let ((pathname-html (make-pathname
                                  :type "html"
                                  :defaults pathname)))
             (with-open-file (out pathname-html 
                                  :direction :output
                                  :if-exists :supersede
                                  :if-does-not-exist :create)
               (let ((*standard-output* out))
                 (mkarticle (get-article pathname))))))
         :directory "articles/2017"
         :extension 'lisp
         :recursive t)
