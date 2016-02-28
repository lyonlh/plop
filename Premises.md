# Premise #0: Human Intelligence #

A principled approach to designing an intelligent system to learn and reason
about programs requires some understanding of intelligence. One way to go about
this is to consider that humans are intelligent, and are capable of learning
and reasoning about programs, at least to some extent. It is possible to derive
a "cognitive core" of essential capabilities by considering the defining
features of human intelligence on Marr's level computational theory. To the
extent that we actually _understand_ cognition this core will less and
less resemble a descriptive account of human thought (while still accounting
for human thought as a special case). The Turing Test definition of
intelligence accordingly corresponds to the degenerate case of no actual
understanding (premise #2 elaborates on why this is the case).


## Rationale ##

See [Mixing Cognitive Science Concepts with Computer Science Algorithms and Data Structures](http://metacog.org/aicog.pdf), by Moshe Looks and
Ben Goertzel.

# Premise #1: Insufficient Knowledge and Resources #

My work herein is based on what [Pei Wang](http://nars.wang.googlepages.com/) has termed the _assumption of insufficient knowledge and
resources_ (AIKR). The system resembles a functional programming language
inasmuch as it contains the usual mechanisms for defining and invoking
functions, passing around arguments (including functions themselves),
etc. However, it is a programming language designed such that individual
functions, and in many cases pieces of functions, are not only organized by
type and scope, but also by degree of belief, expected utility, and
computational overhead.

The system has the top-level goal of obtaining the most certain result or range
of results of executing the user's program, given user-specified constraints on
resource usage (time and space). A usual programming language may be seen as
the special case of completely certain knowledge and unlimited time in which to
execute the user's program (although of course speedier execution is still
generally preferred!). Note that we cannot assume that the "best result"
provided to the user will be especially good. Contrariwise, in a usual
programming language, the system can either evaluate an expression to obtain
_the_ result, or it cannot obtain any result at all.

## Rationale ##

See [The Logic of Intelligence](http://nars.wang.googlepages.com/wang.logic_intelligence.pdf), by Pei Wang.

# Premise #2: Understanding equals Compression #

As clearly articulated by [Eric Baum](http://whatisthought.com/)

(and as has been observed dating back to Leibnitz), understanding is in many
respects equivalent to compression. A compact program that accurately models
some dataset not only deciphers the structure of the data; it will also aid us
in understanding related data. Many problems are thus best solved by searching
for compact programs that exploit (i.e. map to) problem structure.

One important refinement to the classical Kolmogorov complexity approach to
defining compact programs is needed, however. This is to consider compactness
in terms of general resource consumption (program length, speed, runtime memory
usage, etc.), rather than program length alone. This loses some useful
theoretical properties, but gains a very important one (the complexity measure
is now computable), and in practice has few downsides. Two examples of this
approach are Levin's complexity Kt and Schmidhuber's
[Speed Prior](http://www.idsia.ch/~juergen/speedprior.html).

## Rationale ##

See [A Working Hypothesis for General Intelligence](http://whatisthought.com/working.pdf), by Eric Baum.

# Premise #3: Necessary Inductive Bias #

Discovering compact programs to explain data is computationally costly, and
effectively intractable in most cases. Assuming insufficient knowledge and
resources at first seems to make this even worse. One way to make program
induction tractable is with useful prior knowledge, of the particular problem
or problem class at hand, the general domain, or both. More generally,
"inductive bias" may refers to any knowledge/assumptions we can use to direct
search, whether coded or taught.

Which biases are pertinent here? The aim is not to encode "commonsense
knowledge", but rather sufficient bias to make _the learning of_ common
sense tractable. These are the inductive biases pertaining to: space, time,
action, perception, causality, theory-of-mind, and reflection. Teaching (and
compactly describing) biases across all of these areas will require embodiment
in one or more interactive, partially observable environments.

## Rationale ##

### Space and Time ###

A significant proportion of human cognition is spatiotemporal in nature, and
performs structured inference based on proximity, trajectories through space,
containment, etc. There are biases in examining data with a spatiotemporal
interpretation, for example, to focus on searching for relationships among
proximate elements. Data structures such as stacks and queues are clearly
grounded in our basic physical intuitions relating to actual stacks and
queues.

As another example, the algebra of containment is widely applicable:

  * visuospatial (the block is in the box)
  * abstracted spatial (San Francisco is in California)
  * organizational (Fred is in the CIA)
  * temporal (the murder scene is in the second act)
  * metaphorical-spatial (he's in his own world)
  * etc.


These situations are all "the same" in the sense that they all invoke a visual
frame of reference with characteristic inferences (if A is in B and B is in C
then A is in C, if A is in B then you will have to reach/go into B to get to A,
etc.).

### Causality and Theory-of-Mind ###

Causality and theory-of-mind are employed when we speak about agents (typically
other people and ourselves) having beliefs and desires, and causing things to
happen, e.g.:

  * Fred knows where the box is
  * Fred picked up the glass of water so he could drink it
  * Fred doesn't know that I know where the box is
  * The rooster crowed because the sun rose
  * That rock is not an agent - it has no beliefs or desires, and cannot cause things to happen.

### Reflexivity, Perception, and Action ###

By reflective knowledge, I mean that the regularities in and relationships
amongst the system's primitive functions should be declared and exploited
whenever possible in the course of searching for compact programs (e.g. a + b
is always equal to b + a, etc.). This includes imprecise knowledge - if A is
near B and B is near C then we can speculatively conclude that A is probably
near C to some degree (but quantifying the degree of nearness requires specific
domain knowledge that the system may or may not possess).

This sort of reflexivity is also paramount in relating action to perception. A
very important bias is to associate perceptions with related actions -
observing something to one's left and moving to the left, for instance. This
may be quite easy to learn, but to admit the possibility puts constraints on
the system's design.

# Premise #4: Sufficient Inductive Bias #

While the third premise posits the necessity of extensive inductive bias in
order to make general-purpose program induction tractable, the fourth and final
premise posits sufficiency; specifically that an adequate core for an
[artifical general intelligence](http://nars.wang.googlepages.com/wang.AGI-Intro.htm) (AGI) may be designed without addressing natural language
processing, real-world perception and action, or real-time
interaction. Certainly these capabilities are immensely useful, and will be
needed eventually - the fourth premise states, rather, that they may be added
on top of an initial system that does not contain them, without a need for
significant redesign.

## Rationale ##

### Language ###

The intrinsic complexity of language, given the necessary inductive biases of
the third premise (along with embodied interactive learning), is much less than
the converse. That is to say, whereas an integrated system with a grounded
understanding of space, time, causality, and theory-of-mind should have great
inductive biases for learning language, a system with an ungrounded
understanding language will have comparatively little usable bias for learning
about space, time, causality, theory-of-mind, etc. The hard part of
language-learning is not the acquiring the sort of declarative knowledge found
in databases such as [WordNet](http://wordnet.princeton.edu/), but
rather associating words and phrases with _programs_ which serve to
construct and manipulate the mental spaces associated with language
comprehension (a dynamic, contextual process).

This viewpoint is supported by our understanding of how language functions in
humans. Modern language arguably arose only 50,000 years ago (far later than
control of fire, hunting with stone tools, etc.). Many grammatical features may
be seen as having a basis in physical inference (cf. "Grammatical Processing
Using the Mechanisms of Physical Inference", by Nick Cassmatis). Research into
analogy and metaphor
(cf. [Mappings in Thought and Language](http://books.google.com/books?id=2Gfol9An-wEC&dq=Mappings+in+Thought+and+Language&pg=PP1&ots=P2N3skQ-ux&source=bn&sig=6A78r04xHc5Fo4AjyqDxNeawcjk&hl=en&sa=X&oi=book_result&resnum=4&ct=result), by Gilles Fauconnier), and work on how
language arose concurrently with evolutionary adaptations enabling disparate
mental modules to be linked together in cognition
(cf. [The Prehistory of Mind](http://books.google.com/books?id=crp0HAAACAAJ&dq=The+Prehistory+of+Mind&ei=wpIYSbv8CYuCswPD0J2UAg), by Steven Mithen) clearly indicate that linguistic
capability is not an independent module, or a foundational style of cognition,
but rather an ensemble of competencies seated on top of preexisting and more
fundamental modes of cognition.

### Real-World and Real-Time ###

The argument for the omission of real-world perception and action stems from
the observation that in neural processing, the most immediate representations
of perception (e.g. the firings of individual photreceptor cells) and action
(e.g. individual muscle contractions) are generally processed in very rigid
ways, and cut off from the rest of cognition (a much stronger argument along
these lines may be found in Jerry Fodor's
[The Language of Thought](http://books.google.com/books?id=dDu9AAAACAAJ&dq=The+Language+of+Thought&ei=8pIYSbr_HpjOtAOB3LziDw)). This rigidity and isolation gradually decrease as
one ascends the perception-action hierarchy. Accordingly, a system with greatly
simplified low-level perception and action subsystems should be extensible to
contain these facilities without any significant redesign of the core.

Some aspects real-time interaction are simply extreme cases of the assumption
of insufficient knowledge and resources, and do not require additional
mechanisms. Where real-time interaction _will_ require new design
principles is with respect to the general issue of the allocation of
attention. When operating outside of a read-eval-print loop, with multiple
competing goals and shifting contexts, augmentations will be needed to
prioritize computations and actions, and to achieve adequate credit allocation
when causes and effects occur far apart in time. Fortunately, the core
mechanisms used for the general probabilistic learning of programs will be
suitable for solving most of the hard computational problems that will arise
here.