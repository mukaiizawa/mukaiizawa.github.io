
(require "stdlib" *module-stdlib*)
(load "module")

(mapfile (lambda (pathname)
           (unless (and (string= "lisp" (pathname-type pathname))
                        (or (string= "make" (pathname-name pathname))
                            (string= "module" (pathname-name pathname))))
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
         :recursive t)

