Expressions with corresponding pnodes are ordered by the expected utility using them as exemplars for optimization (utility for short), which is defined as `E*P`.

## Intuition ##

Consider (thanks to Nil for the example) two expressions, `A` and `B`. `A` is surrounded by vastly many better sub-optimal candidates, let's call them `better_A_neigh`. `B` has only a few better neighbors but they are optimal. And of course `A` has a better score than `B` to
make things harder (an also `better_A_neigh` are syntactically far away from the optimal solution)... So the only way to solve the problem is to focus optimization around `B`, by using it as an exemplar.

This is addressed in the way that utility is calculated by preferring to search around `A` vs. `B` based not just on the mean fitness of nearby solutions, which will indeed be higher for `A`, but also on the (weighted) variance around `A` vs. `B`. My working understanding
(may be wrong) is that even if exploring around `A` at first has higher expected utility, after spending some time searching there our estimated variance will decrease (while our estimated variance around B should actually **increase** - see the way V2 is defined below). And, importantly, our estimated variance for points near `A` (`better_A_neigh`) will decrease along with our estimated variance for `A`. These changes **should** (if my intuitions about the math are correct) cause `A` and `better_A_neigh`'s utilities to decrease, while `B`'s will increase.

## The Gory Details ##

`E` is the conditional expectation of `(score - best)/N`, where `score` is the score of the first "significant" improvement we will discover in the course of optimization, `best` is the previous best score of any expression found (or should we instead use the score of the exemplar expression itself?), and `N` is the number of moves (i.e. calls to the fitness function) it takes us to find such an improvement. `E` is conditional on us finding such an improvement.

`P` is the probability of finding such an improvement in the course of optimization.

This may be broken down by considering `score_i`, the score of the expression to be found on the `i`th call to the fitness function, assuming we optimize on the given exemplar (`i >= 1`). Let `stuck` be the number of calls to the fitness function we will consider before giving up (in practice we will use the expected value).

We can now write the utility out as:

```
utility = sum_{i=1}^{stuck} P(score_i > best | score_j are <= best, for j<i) *
          [ E(score_i | score_i > best and score_j are <= best, for j<i) -
            best ] / i
```

The (unconditional) probability P(score\_1 > best) can be estimated based on the expected mean and variance of the score over the neighborhood of the expression, based on previously sampled points. In a simple model, we can consider _all_ of the expressions we have observed, with their relevance to the neighborhood of `expr` falling off geometrically with "distance" from `expr`. So we can use the [weighted mean](http://en.wikipedia.org/wiki/Weighted_mean)  `sum(w_i * score_i)` over all points `i`, where `w_i` is `c^d_i`, `d_i` is the distance from point i to the expr, and c is in (0,1) and is an measure of fitness-distance correlation. We can use the unbiased estimator of the weighted variance, `[1 / (1 - V2)] * sum(w_i *(score_i - mean)^2)`, where `V2 = sum(w_i * w_i)` (over all points `i`). So if all `N` points are all equidistant (all `w_i` are equal), then `V2` attains its minimal value of `1 / N` (and our estimate of the variance is not inflated very much). In contrast, for very skewed weightings, `V2` goes toward 1, and our estimate of the variance can be quite inflated.

For setting c, consider the normalized measure of score divergence between two expressions `i` and `j`, `|s_i - s_j| / max(s_i, s_j)`. Discounting by distance and averaging over all moves from between expressions gives us

```
delta = (1 / sum_{(i,j) in Moves} distance(i,j)) *
        sum_{(i,j) in Moves} |s_i - s_j| /
                             (max(s_i, s_j) * distance(i,j))
c = 1 - delta
```

What distance metric is appropriate here? In principle one should use a suitable edit distance, but this is much too slow, so we will use minimum distances on addresses instead. Since the contribution of points will fall off very quickly (geometric sequence goes quickly to zero), we will only look at nearby points, and for these, the difference between address-distance and edit-distance should not be too severe.

What about sampling bias in the points that we have scoring information for? This should be aleviated somewhat by the presence of a fixed percentage of metropolis picks and macromutations in our sampling/optimization algorithm. And again, the falloff from distance should be much more significant than the sampling bias.

We can use our estimated mean and variance for score\_1 to compute `P(score_1 > best)`, treating score\_1 as following a Gaussian distribution. Now, how to compute the conditional expectation?

The expectation here is a conditional tail expectation (cf [Panjer, 2001](http://www.stats.uwaterloo.ca/stats_navigation/IIPR/2001Reports/01-15.pdf)), and, for a normal distribution:

```
E(score | score > best) = 
mu + sqrt(sigma / pi) * exp(-(best - mu)^2 / 2 * sigma^2) / 
                        (1 - erf((best - mu) / (sigma * sqrt(2))))
```

where mu is the mean and sigma is the standard deviation.

Now all that is left is to handle the conditional probabilities in our first `utility` equation.

On the one hand, the conditional probabilities may decrease as we discover more bad points in regions we previously considered promising. On the other, future (focused) samples may be better allocated based on this information. Also, in many cases we will be evaluating `k` neighboring points simultaneously (to do parallel processing), and will have no parameter updates inbetween. So for simplicity lets just assume the same distribution, and a fixed number of trials. This raises the possibility of more than one success, so we must use the binomail distribution:

```
P = P(score > best), E = E(score | score > best)
utility = (sum_{i=1}^{stuck} binomial(P, stuck, i) * i * [E - best]) / stuck
```

OK, almost done. We still need to estimate `stuck`. But wait! If we just do a bit more simplification we get:

```
utility = ([E - best] / stuck) * sum_{i=1}^{stuck} binomial(P, stuck, i) * i
        = ([E - best] / stuck) * stuck * P
        = [E - best] * P
```

and don't care about `stuck`. And we're done, whew!