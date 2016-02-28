**Required:** An implementation of Common Lisp. Plop has been tested under [CLISP](http://clisp.cons.org/) and [SBCL](http://www.sbcl.org/). Nil Geisweiller has reported that plop doesn't compile under an older SBCL (1.0.18), so if you encounter trouble here please first try upgrading SBCL. If you find that it does or does not work under some other implementation, please let me know!

**Recommended:** [ASDF](http://www.cliki.net/asdf) (included with sbcl) for easy builds, and [Maxima](http://maxima.sourceforge.net/) for numerical simplification.

**Setup:** Check out the [source code](http://code.google.com/p/plop/source/checkout) to path `foo` (e.g. `/home/madscience/plop/`). Create a symbolic link to `foo/plop/trunk/src/plop.asd` from your asdf central registry (e.g. `ln -s foo/trunk/src/plop.asd /central-regisitry-path/plop.asd`). If you don't happen to already have the [anaphora](http://common-lisp.net/project/anaphora/) and [cl-utilities](http://common-lisp.net/project/cl-utilities/) packages installed, create symbolic links to `foo/trunk/thirdparty/anaphora/anaphora.asd` and `foo/trunk/thirdparty/cl-utilities/cl-utilities.asd` as well.

**Customization:** If you want to enable (disable) the use of Maxima, comment (uncomment) `(:file "maxima")` from `trunk/plop.asd`.

**Loading:** In your Common Lisp (or in Maxima, after doing `to_lisp()`) do:
  * `(load "foo/trunk/thirdparty/lisp-unit.lisp")` (where `foo` is where you put the code, as above)
  * `(asdf:operate 'asdf:load-op 'cl-utilities)`
  * `(asdf:operate 'asdf:load-op 'anaphora)`
  * `(asdf:operate 'asdf:load-op 'plop)`
You probably want to add the first three of these to your lisp implementation's startup file (`~/.clisprc.lisp` for CLISP `~/.sbclrc` for SBCL).

**Testing:** Evaluate `(in-package plop) (run-tests)`. At the end of the output you should see something like `TOTAL: 13489 assertions passed, 0 failed, 0 execution errors.`. Note that currently the `conditional-tail-expectation` test fails under sbcl without maxima - don't worry about it...

**Examples:**
```
CL-USER> (in-package plop) ; all the code lives here
#<PACKAGE PLOP>
PLOP> %(and x y) ; % is the quote operator used for expressions in the plop 
                 ; language
((AND) X Y)
PLOP> (p2sexpr (qreduct %(and (or x y) (or (not x) z z) (or y z)))) 
      ; qreduct does simplification with no assumptions and infers the type of
      ; the expression - p2sexpr converts the result into a human-friendly 
      ; s-expression
(AND (OR X Y) (OR (NOT X) Z))
PLOP> (truth-table %(and (or x y) (or (not x) z))) ; verify the new truth-table
(T NIL T NIL T T NIL NIL)
PLOP> (truth-table %(and (or x y) (or (not x) z z) (or y z))) ; vs. original
(T NIL T NIL T T NIL NIL)
PLOP> (p2sexpr (qreduct %(log (exp (+ 2 x 3))))) ; with Maxima, numerical exprs
                                                 ; get simplified as well
(+ 5 X)
PLOP> (p2sexpr (qreduct %(if (not (not (not x))) 42 (+ 1 2 y)))) 
      ; conditionals and mixed-type exprs
(IF X (+ 3 Y) 42)
PLOP> (p2sexpr (bool-hillclimb-with-target-truth-table 
                '(t nil t nil t t nil nil) 10000 '(x y z)))
      ; time for some learning - lets try the boolean function used above
      ; 10000 is the maximum # of evaluations of sample programs (not that we 
      ; need nearly this many for such an easy problem)

EVALS LEFT 10000 
NEW-BEST -4 
NEW-BEST -2 
IMPROVED-TO Z 
LOCAL-MAXIMUM Z 8 
LOCAL-MAXIMUM Y 8 
NEW-BEST -1 
IMPROVED-TO (AND Z (OR X (AND Y Z) (AND (NOT Y) (NOT Z)))) 
LOCAL-MAXIMUM (AND Z (OR X (AND Y Z) (AND (NOT Y) (NOT Z)))) 42 
IMPROVED-TO Z 
LOCAL-MAXIMUM Z 8 
IMPROVED-TO (AND Z (OR (NOT X) Y)) 
IMPROVED-TO Y 
LOCAL-MAXIMUM Y 8 
IMPROVED-TO FALSE 
IMPROVED-TO Z 
LOCAL-MAXIMUM Z 8 
IMPROVED-TO (AND (NOT X) Y) 
IMPROVED-TO (OR Z (AND (NOT X) Y)) 
NEW-BEST 0 
IMPROVED-TO (OR (AND X Z) (AND (NOT X) Y)) 
FINAL BEST SCORE 0 
(OR (AND X Z) (AND (NOT X) Y))
PLOP> (let* ((xs '(-1 .3 .5)) (ys (mapcar (lambda (x) (+ 0.1 (* 2 x))) xs)))
        (p2sexpr (num-hillclimb-with-target-values xs ys 10000 '(x))))
      ; a linear function - quite easy, but the hillclimber is very simplistic

EVALS LEFT 10000 
NEW-BEST -3.6999999999999997 
NEW-BEST -3.3000000000000003 
IMPROVED-TO 1 
NEW-BEST -1.9 
IMPROVED-TO X 
NEW-BEST -1.891584962500721 
IMPROVED-TO (+ 0.01 X) 
NEW-BEST -0.3015849625007213 
IMPROVED-TO (* 2 X) 
NEW-BEST -0.2723219280948875 
IMPROVED-TO (+ 0.01 (* 2.0 X)) 
NEW-BEST -0.24232192809488745 
IMPROVED-TO (* 2 (+ 0.01 X)) 
EVALS LEFT 9500 
NEW-BEST -0.21280735492205768 
IMPROVED-TO (+ #1=0.01 (* 2 (+ #1# X))) 
NEW-BEST -0.1823219280948874 
IMPROVED-TO (* 2 (+ 0.02 X)) 
NEW-BEST -0.15280735492205763 
IMPROVED-TO (+ 0.01 (* 2 (+ 0.02 X))) 
EVALS LEFT 9000 
NEW-BEST -0.12232192809488747 
IMPROVED-TO (* 2 (+ 0.03 X)) 
NEW-BEST -0.09280735492205769 
IMPROVED-TO (+ 0.01 (* 2 (+ 0.03 X))) 
EVALS LEFT 8500 
NEW-BEST -0.062321928094887416 
IMPROVED-TO (* 2 (+ 0.04 X)) 
NEW-BEST -0.03280735492205763 
IMPROVED-TO (+ 0.01 (* 2 (+ 0.04 X))) 
NEW-BEST -0.0023219280948873623 
IMPROVED-TO (* 2 (+ 0.05 X)) 
FINAL BEST SCORE -0.0023219280948873623 
(* 2 (+ 0.05 X))
```