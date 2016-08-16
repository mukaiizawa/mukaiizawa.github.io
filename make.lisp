
(require "stdlib" *module-stdlib*)

(mapfile (lambda (pathname)
           (unless (find ".git" (pathname-directory pathname) :test 'equal)
             (princln pathname)
             (let ((pathname-html (make-pathname
                                    :type "html"
                                    :defaults pathname)))
               (with-open-file (out pathname-html 
                                    :direction :output
                                    :if-exists :supersede
                                    :if-does-not-exist :create)
                 (let ((*standard-output* out))
                   (load pathname))))))
         :extension 'lisp
         :directory "./root"
         :recursive t)

