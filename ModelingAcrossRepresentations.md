In the initial incarnation of MOSES, when a new representation (program subspace) gets selected for optimization over, an entirely new probabilistic model is constructed over it. This model begins with no dependencies between variables, and assigns no especial importance to any particular variable. This is not very efficient, because of course we have often done optimization over "similar" program subspaces, and have accumulated evidence as to which variables are most useful to vary, and which variables have nonlinear interactions with each other (i.e. dependencies). Accordingly, we would like to start optimization with a nonuniform prior that exploits this knowledge. Similarly, if we later go back and perform additional optimization in a previously explored similar subspace, we would like to exploit the knowledge we have acquired in the meantime.

# Details #

The basic idea that I have for implementing this is that when a new representation is created, to tree-align (via dynamic programming) its exemplar program with the exemplar programs of its parent-representation(s). Then, for setting on every knob in the new representation that is affixed to a subexpression with corresponding subexpression(s) in the parents, we search for a setting of some knob in the parents' representation that has an identical effect. If one is found, then these settings are considered to be in correspondence. Then, we can use the knowledge we have accumulated by doing optimization on these representations to bias the construction of our new probabilistic model, and correspondingly propagate new knowledge (frequencies and structure) back upwards.

## Questions ##

  * What to do if only some settings on a knob correspond to the new settings? What if two knobs are in correspondence, but no settings exactly match?
  * What if one mapping implies a certain order of dependencies (A -> B), but another implies an order that would lead to circularity (B -> A)?
  * When propagating frequencies across representations, do the propagated frequencies have equal weight to actual frequencies?
  * What about higher-order statistics on knob types?
  * When computing new linkages, which knobs and statistics should be considered?