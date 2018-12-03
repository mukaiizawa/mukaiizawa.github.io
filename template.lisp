(require :xml-manager *module-xml-manager*)
(provide :template)

; (defparameter *http-root-path* "https://mukaiizawa.github.io/")
(defparameter *http-root-path* "C:/Users/lambda/blog/")

(defstruct article
  (title "Goto Great")
  (contents "comming soon...")
  (time "9999-99-99")
  (tags nil)
  (path ""))

(defun to-absolute (str)
  (mkstr *http-root-path* str))

(defun article-absolute-path (article)
  (mkstr *http-root-path* article))

(defmacro import-img (str alt &optional (width 200) (height 200))
  `(:img ((src ,(image-path str)) (alt ,alt) (width ,width) (height ,height))))

(defun resource-path (str)
  (to-absolute (mkstr "resources/" str)))

(defun image-path (str)
  (resource-path (mkstr "images/" str)))
