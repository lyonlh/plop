#| Copyright 2008 Google Inc. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License")
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an AS IS BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Author: madscience@google.com (Moshe Looks) 

expected utility calculations |#
(in-package :plop)

;fixme
(defun find-max-utility (pnodes 
			 &aux (best nil) (err most-positive-single-float))
  (maphash-keys (lambda (x) 
		  (when (< (pnode-err x) err)
		    (setf best x err (pnode-err x))))
		pnodes)
  best)
;;   (rotatef (car pnodes) 
;; 	   (nth (max-position pnodes #'< :key #'pnode-err) pnodes))
;;   pnodes)
