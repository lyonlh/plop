# Rationale #

The first phase of the plop project is to create the world's first competent general program evolution system. _Competent_ denotes scalability, generality, and robustness. There are many "overfitting" dangers in program induction, all of which plop attempts to avoid, and are tested against in the benchmarks enumerated herein:
  * broadly applicable, robust but doesn't scale
    * prophylactic: large parity & multiplexer problems, large deceptive problems, etc.
  * doesn't handle noise
    * prophylactic: noisy optimization problems, noisy version of the artificial ant,  machine learning problems with noisy data
  * narrowly applicable
    * prophylactic: test problems from many domains
  * doesn't handle functions with side-effects
    * prophylactic: side-effectful problems such as the artificial ant & blocksworld
  * doesn't handle iteration
    * prophylactic: problems that can only be solved via iteration (list parity, sorting, list reversal, etc.)

In addition, there are simple "sanity check" problems for most categories, that should be easy to solve by any method.

The second stage of the plop project involves exploiting background knowledge and doing meta-learning across sequences of problems. It is of course very important that we don't get bogged down and overfit a solution the challenges of phase one, regardless of its generality in the sense outlined above!

# The Problems #

## Boolean functions ##
  * The easy boolean function `(OR (AND X Z) (AND (NOT X) Y))`
  * N-ary AND and OR and NAND for N in 1...100
  * N-even-parity for N in 2...7
  * N-multiplexer for N in 3,6,11,20

## Numerical functions ##
  * The easy numerical function `(+ 0.1 (* 2 X))`
  * N-ary linear functions with Gaussian random constants for N in 1...100
  * Koza's polynomial (sum for k from 1 to N x^k) for N in 1...8
  * The hard numerical function from Salustowicz & Schmidhuber (Probabilistic incremental program evolution, Evolutionary Computation, 1997):
> `(* (expt x 3) (exp (- x)) (cos x) (+ (* (expt (sin x) 2) (cos x)) -1))` in comparison to PIPE and PEEL

## Timeseries ##
  * Sunspot timeseries
  * Translated scaled sine
  * Noisy translated scaled sine
  * Fibonacci
  * Noisy Fibonacci

## List manipulation functions ##

The first 4 of these have been solved by [Olsson's ADATE](http://www-ia.hiof.no/~rolando/)), the last two by [Clack & Yu](http://citeseer.ist.psu.edu/clack97performance.html).

  * Sort (on a list of ts with a provided comparator)
  * Even-parity (on a list of bools)
  * List reversal (on a list of ts)
  * Duplicate detection on a list of ts with an equality predicate
  * The nth-3 function  takes two arguments, an integer N and a list L, and returns the Nth element of L. If N < 1, it returns the first element of L. If N > length(L), it returns the last element of L.
  * Mapcar

## Action-perception problems ##
  * Artificial ant on the Santa-Fe trail, a well-studied GP problem with a simple set of primitives - learn a control program to eat a bunch of food pellets scattered in a rough trail
  * A "noisy ant" problem where the ant sometimes executes an incorrect command
  * Blocksworld stack-matching problem (see Eric Baum's papers on solving blocksworld with Hayek3 and Hayek4 for description & references http://whatisthought.com/eric.html#economies)

## Supervised classification problems ##
  * Simple visual reasoning on binary matrices:
    * distinguishing between hand-drawn As and Bs
    * recognizing containment
    * when is a line-drawn maze solvable
  * Some gene-expression problems (e.g. cancer datasets)
    * find the best solution
    * find the pareto front
  * Some problem with compellingly missing data

## Datamining/compression ##
  * Compress a short English text
  * Cluster simple 2D overlapping Guassians

## Discrete optimization problems ##
  * The k-deceptive traps for k=3,4,5 and N=60,120,180,300,600,1200
  * Onemax for N=60,120,180,300,600,1200
  * hIFF, hXOR, and hTrap for N=128,256,512,1028
  * Hierarchical massively multimodal deceptive function for k=5 and k=6
  * All of the above with additive Gaussian noise (excepting the largest size)

## Continuous optimization problems ##
  * Bosman & Grahls' pathological yet easy optimzation problem, described in Matching Inductive Search Bias and Problem Structure in Continuous Estimation-of-Distribution Algorithms, (European Journal of Operational Research, 2008)
  * De Jong's test suite (http://www.denizyuret.com/pub/aitr1569/node19.html); sphere, rosenbrock, step, quartic, & foxholes
  * Ocenasek's two-deceptive continuous optimization problem

## Mixed discrete-continuous optimization problems ##
  * Ocenasek & Schwartz's mixed problem (Estimation of Distribution Algorithm for mixed continuous-discrete optimization problems, Euro-International Symposium on Computational Intelligence, 2002) http://jiri.ocenasek.com/papers/eisci02.pdf