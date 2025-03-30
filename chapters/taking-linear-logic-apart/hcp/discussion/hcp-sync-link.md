# Synchronous Links and Lazy Forwarders {#hcp-sync-link}

In this section, we revisit the semantics of the link.
In @cp-link, we mentioned that the semantics of link does not explicitly forward messages, but rather treats links as a suspended α-renaming.
Recall that the reduction rule for link is as follows:
$$
\hpNew(\hpx\hpx')(
  \hpLink\hpx\hpy
  \hpPar
  \hpP
)
\hpEval
\hpP\hpSubst{\hpx'}{\hpy}
$$
Let us consider what requirements this places on an implementation.
The process $\hpP$ is not required to be ready to act on the endpoint $\hpx'$, which means that link cannot be implemented in terms of synchronous message passing.
In essence, link is asynchronous. For instance, if every channel has an associated message buffer, link could be implemented by asynchronously sending a redirection notice.

There is a tension between the asynchronous semantics of link, and the synchronous semantics of all other actions in CP.
This is apparent in the definition of canonical form and its adequacy, which have separate cases for link and for all other actions.
There are two options to resolve this tension: we either make link synchronous or all other actions asynchronous.
CP is easily adapted to be asynchronous [see, e.g., the treatment of synchronous and asynchronous GV in @Fowler19:thesis].
In this section, we will consider our options for a synchronous link.

## Blocking Link

The easiest approach to making link synchronous is to require that the other process is ready on the relevant endpoint.
$$
\AXC{$
  \readyOn{\hpP}{\hpx'}
  $}
\RL{\RuleLabel{H}{E-Link-Ready}}
\UIC{$
  \hpNew(\hpx\hpx')(
    \hpLink\hpx\hpy
    \hpPar
    \hpP
  )
  \hpEval
  \hpP\hpSubst{\hpx'}{\hpy}
  $}
\DP
$$
The new rule allows strictly fewer reductions, and as such does not affect the proof of preservation. However, it simplifies the definitions of canonical form and the proof of progress, and strengthens the adequacy of canonical forms.

The definition of canonical form no longer requires condition (1).

Definition (Canonical Form) {#hcp-sync-link-canonical-form}.
  ~ A process $\hpP$ is in *canonical form*, written $\canonical(\hpP)$, if $\hpP\iotf\hpCC^n[\hpT_1,\hptm\dots,\hpT_n]$ (for some $n \geq 0$) and (for $1 \leq i, j \leq n$) no $\hpP_i$ and $\hpP_j$ are ready to act on dual endpoints $\{\hpx,\hpx'\}\in\dn(\hpCC)$.

The proof of progress for HCP [@proposition:hcp-progress] has two cases: either condition (1) fails, or condition (2) fails. The proof of progress for HCP with \Rule{H-E-Link-Ready} no longer requires the first case, as link reduction is fully covered by the second case.

Proposition (Progress) {#hcp-sync-link-progress}.
  ~ If $\hpP\hpSeq\hpHG$,
    then either $\hpP$ is in canonical form, or
    there exists some $\hpQ$ such that $\hpP\hpEval\hpQ$.

The adequacy of canonical forms is strengthened by the change. In HCP with \Rule{H-E-Link-Ready}, "blocked on free endpoints" fully characterises canonical forms.

Corollary {#hcp-sync-link-canonical-is-blocking-free}.
  ~ If $\hpP\hpSeq\hpGG$,
    then $\canonical(\hpP) \iff \blocking(\hpP)\subseteq\fn(\hpP)$.

## Identity Expansion

We could implement a synchronous link using the process calculus equivalent of *identity expansion*---the procedure that rewrites proofs in the logic to remove non-atomic uses of the axiom. Under this view, link is a macro which statically computes the link process from the type, using the following expansions:
$$
\begin{array}{l@{,\:}l@{\;\defeq\;}l}
  \hpLink[\hpA\hpParr\hpB]\hpx\hpy
  & \hpLink[\hpA\hpTens\hpB]\hpy\hpx
  & \hpRecv{\hpx}{\hpz}.
    \hpSend{\hpy}{\hpw}.
    (\hpLink[\hpA]\hpz\hpw\hpPar\hpLink[\hpB]\hpx\hpy)
  \\
  \hpLink[\hpBot]\hpx\hpy
  & \hpLink[\hpOne]\hpy\hpx
  & \hpWait{\hpx}.
    \hpClose{\hpy}.
    \hpZ
  \\
  \hpLink[\hpA\hpWith\hpB]\hpx\hpy
  & \hpLink[\hpA\hpPlus\hpB]\hpy\hpx
  & \hpOffer{\hpx}(
      \hpInl:\hpSelect\hpy<1.\hpLink[\hpA]\hpx\hpy;
      \hpInr:\hpSelect\hpy<2.\hpLink[\hpB]\hpx\hpy)
  \\
  \hpLink[\hpTop]\hpx\hpy
  & \hpLink[\hpNil]\hpy\hpx
  & \hpAbsurdZap{\hpx}{\hpy}
\end{array}
$$
(The type written over the arrow is the type of the left endpoint.)

Identity expansion works when the type is statically known, but it breaks when we add polymorphism, and repairing it requires us to compute the link process dynamically and to keep session types around at runtime.

From the perspective of an implementation, identity expansion also inflates the size of the program, from a single link instruction to a number of instructions equal to the size of the type.

## The Lazy Forwarder

We could implement a synchronous link that performs identity expansion, not based on the type, but based on the messages the link receives.
In response to a send action, the link unfolds into a receive action followed by a send action, and the process reduces by \Rule{H-E-Send}.
$$
\begin{array}{l@{\;}l@{\;}l}
  \hpNew(\hpx\hpx')(
    \hpSend\hpx\hpz.\hpP
    \hpPar
    \hpLink{\hpx'}{\hpy}
  )
& \defeq
& \hpNew(\hpx\hpx')(
    \hpSend\hpx\hpz.\hpP
    \hpPar
    \hpRecv{\hpx'}{\hpz'}.\hpSend{\hpy}{\hpw}.(\hpLink{\hpz'}\hpw\hpPar\hpLink{\hpx'}\hpy)
  )
\\
& \hpEval
& \hpNew(\hpx\hpx')
  \hpNew(\hpz\hpz')(
    \hpP
    \hpPar
    \hpSend{\hpy}{\hpw}.(\hpLink{\hpz'}\hpw\hpPar\hpLink{\hpx'}\hpy)
  )
\end{array}
$$
The operational semantics of the lazy forwarder are easier to understand from the label-transition system, since the reduction rules fold this two-step behaviour into single rule.
The label-transition rules for lazy forwarders are in @figure:hcp-lts-lazy-forwarder.

![Label-Transition System for Lazy Forwarders](figures/lts-lazy-forwarder.tex?as=webp){#figure:hcp-lts-lazy-forwarder}

The lazy forwarder has the same semantics as identity expansion, but works in the presence of polymorphism.
Lazy forwarders are synchronous, rather than asynchronous, but they behave differently from blocking links.
They are directed, as they only forward received messages.
Hence, the following process is stuck:
$$
  \hpNew(\hpx\hpx')(
    \hpLink\hpx\hpy
    \hpPar
    \hpRecv{\hpx'}\hpz.\hpP
  )
$$
This is a direct consequence of the correspondence between the process calculus and the sequent calculus for CLL, since the expansion that sends and then receives---i.e., $\hpSend{\hpy}{\hpw}.\hpRecv{\hpx}{\hpz}.\hptm\lparen\hpLink\hpz\hpw\hpPar\hpLink\hpx\hpy\hptm\rparen$---is not typeable.
However, with delayed actions [@KokkeMP19:dhcp], the process can send and then receive, regardless of the order of the two actions.
Hence, under delayed actions lazy forwarders and blocking link may behave the same.

Lazy forwarders are type preserving by the correctness of identity expansion, and satisfy progress as well as the adequacy of canonical forms. However, the canonical forms are quite different, due to the directionality of lazy forwarders.

Firstly, we must alter the definition of ready, since lazy forwarders are only ready on the endpoint on which they receive, which can be inferred from the types of its endpoints.

Definition (Ready) {#hcp-lazy-forwarder-ready}.
  ~ A process $\hpP$ is *ready to act on* $\hpx$, written $\readyOn\hpP\hpx$, if it is of one of the forms:
    $$
    \!\!
    \begin{array}{llllllllll}
    \hpLink[\hpA\hpParr\hpB]\hpx\hpy
    &
    \hpLink[\hpBot]\hpx\hpy
    &
    \hpLink[\hpA\hpWith\hpB]\hpx\hpy
    &
    \hpLink[\hpTop]\hpx\hpy
    &
    \hpSend\hpx\hpy.\hpP
    &
    \hpClose\hpx.\hpP
    &
    \hpSelect\hpx<1.\hpP
    &
    \hpSelect\hpx<2.\hpP
    &
    \hpAbsurdZap\hpx\hpNN
    \\
    \hpLink[\hpA\hpTens\hpB]\hpy\hpx
    &
    \hpLink[\hpOne]\hpy\hpx
    &
    \hpLink[\hpA\hpPlus\hpB]\hpy\hpx
    &
    \hpLink[\hpNil]\hpy\hpx
    &
    \hpRecv\hpx\hpy.\hpP
    &
    \hpWait\hpx.\hpP
    &
    \multicolumn{2}{l}{%
    \hpOffer\hpx(\hpInl: \hpP; \hpInr: \hpQ)}
    \end{array}
    $$
    A process $\hpP$ is *ready* if it ready to act on some endpoint.

The definition of canonical form and the proof of progress simplify in the same manner as for blocking links. However, while the text defining canonical form is the same, the actual canonical forms are quite different, due to the different definitions of *ready*.
For instance, the previously mentioned stuck process is in canonical form:
$$
  \hpNew(\hpx\hpx')(
    \hpLink[\hpA\hpTens\hpB]\hpx\hpy
    \hpPar
    \hpRecv{\hpx'}\hpz.\hpP
  )
$$
While type annotations are unnecessary at runtime, determining whether or not a lazy forwarder is ready requires case analysis on its type to determine its direction. For the process above, we can infer that the endpoint $\hpx$ has type $\hpA\hpTens\hpB$, and hence the link is only ready on $\hpy$.

The asymmetry of lazy forwarders allows us to simplify the definition of the dependency graph, by removing the special case for link. Links no longer generate undirected edges, but directed arcs which align with their direction:
$$
  \dependency(\hpLink[\hpA\hpParr\hpB]\hpx\hpy)=\arc\hpx\hpy
  \qquad
  \dependency(\hpLink[\hpA\hpTens\hpB]\hpx\hpy)=\arc\hpy\hpx
$$
The adequacy of canonical forms is strengthened in the same manner as with blocking links, i.e., "blocked on free endpoints" fully characterises canonical forms.

Lazy forwarders continue to work in the presence of polymorphism, since the direction of the link is determined dynamically, in response to communication.
<!--
However, we foresee difficulties extending the definition of dependency graph from shallow to deep in the presence of polymorphism and lazy forwarders, since we cannot statically determine the direction of a link in a polymorphic process, i.e., after receiving a type instantiation.
In this setting, we are required to consider all coherence switchings of links.
-->
