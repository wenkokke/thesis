# Zap: The Exceptionally Absurd Offer {#hcp-zap-exceptionally-absurd-offer}

In this section, we revisit the semantics for the absurd offer.
In @cp-the-absurd-offer, we discussed the 'inert' semantics for the absurd offer. It does nothing, just sits around.
If we think of the absurd offer as an exception handler, the inert semantics make sense. It is waiting for an exception that---by the correctness of the type system---will never arrive.
However, the absurd offer is not *quite* an exception handler.
An exception handler handles an exceptional case---either the computation succeeds, and we compute a value, or, in some exceptional circumstances, something goes wrong, and the exception handler is invoked.
The absurd offer deals with the *certainty* that something will go wrong.
If you are certain, why bother waiting?
Under this view, we refer to the absurd offer as *zap* or *zapper*.
It is not inert, and does not wait.
It *zaps* channels, kills processes, and shuts the whole thing down.

Wadler's CP handles zap with a commuting conversion, defined on typing derivations:
$$
  \AXC{}
  \UIC{$\cpAbsurd{\cpa} \cpSeq \cpGG, \cpa:\cpTop, \cpx:\cpA$}
  \AXC{$\cpP \cpSeq \cpGD, \cpx':\co\cpA$}
  \BIC{$\cpNew(\cpx\cpx')(\cpAbsurd{\cpa}\cpPar\cpP) \cpSeq \cpGG, \cpGD, \cpa:\cpTop$}
  \DP
  \quad{\cpEval}\quad
  \AXC{$\vphantom{\co{\co{\cpA}}}$}
  \UIC{$\cpAbsurd{\cpa} \cpSeq \cpGG, \cpGD, \cpa:\cpTop$}
  \DP
$$
As mentioned in @cp-the-absurd-offer, this reduction rule does not satisfy type erasure, since the process $\cpAbsurd\cpx$ does not record which sessions it is allowed to kill.
In HCP and CP, as presented in this thesis, the absurd offer does record these sessions as part of the process syntax.
Hence, we could adapt and repair Wadler's reduction rule.
To save on ink and eye strain, let us write $\hpNN\hptm,\hpx$ to mean $\hpNN\cup\{\hpx\}$ and $\hpNN\hptm,\hpNM$ to mean $\hpNN\cup\hpNM$.
$$
\AXC{$\hpx'\in\fn(\hpP)$}
\AXC{$
    \hpNM
    \defeq
    \fn(\hpP)\setminus\{\hpx'\}
  $}
\RL{\RuleLabel{H}{E-Zap-Now}}
\BIC{$
    \hpNew(\hpx\hpx')(
    \hpAbsurdZap\hpw{\hpNN,\hpx}
    \hpPar
    \hpP
    )
    \hpEval
    \hpAbsurdZap\hpw{\hpNN,\hpNM}
  $}
\DP
$$
The above rule is correct, in the sense that it matches Wadler's semantics, but it is a bit over-eager.
It permits $\hpAbsurdZap\hpw\hpNN$ to kill any process that holds any of the names in $\hpNN$, regardless of whether those processes are currently attempting to communicate on those channels.
Let us consider what requirements this places on an implementation.

- If we wanted to implement this as part of our channel implementation, it would require every process to always be listening on all of their endpoints.
- We could implement this using another mechanism entirely. For instance, using POSIX Threads, we could implement this by decorating each channel with the thread ID of the process on the other end of the channel, and implement kill using `pthread_kill` or `pthread_cancel`.

In either case, the adoption of \Rule{H-E-Zap-Now} significantly complicates an implementation in ways that are not obvious from the description of the formal system.

We can address the over-eagerness by restricting the reduction rule to only apply when the other process is ready:
$$
\AXC{$\readyOn{\hpP}{\hpx'}$}
\AXC{$
    \hpNM
    \defeq
    \fn(\hpP)\setminus\{\hpx'\}
  $}
\RL{\RuleLabel{H}{E-Zap-When-Ready}}
\BIC{$
    \hpNew(\hpx\hpx')(
    \hpAbsurdZap\hpw{\hpNN,\hpx}
    \hpPar
    \hpP
    )
    \hpEval
    \hpAbsurdZap\hpw{\hpNN,\hpNM}
  $}
\DP
$$
What does this semantics require of an implementation?
Any process only needs to monitor the endpoints it is *ready* on, which is certainly an improvement.
What is a zapper ready on?
Consider the two processes
$$
\text{(a) }%
\hpNew(\hpx\hpx')(
  \hpAbsurdZap{\hpa}{\hpNN,\hpx}
  \hpPar
  \hpAbsurdZap{\hpx'}{\hpNM}
)
\qquad
\text{(b) }%
\hpNew(\hpx\hpx')(
  \hpAbsurdZap{\hpa}{\hpNN,\hpx}
  \hpPar
  \hpAbsurdZap{\hpb}{\hpNM,\hpx'}
)
$$
For both of these processes to reduce by \Rule{H-E-Zap-When-Ready}, a zapper $\hpAbsurdZap{\hpx}{\hpNN}$ must be ready on all its endpoints---$\hpx$ and all the endpoints in $\hpNN$.
This reveals an awkwardness: the endpoint $\hpx$ is not special.
A zapper may introduce multiple endpoints of type $\hpTop$.
From the perspective of the logic, there is no way to tell these apart.
The only thing that matters is that there is at least one, and the principal purpose of the syntax $\hpAbsurdZap{\hpx}{\hpNN}$ is to ensure that.
Unfortunately, this makes reduction with \Rule{H-E-Zap-When-Ready} non-confluent. The second process has two reductions, each of which singles out a different endpoint as special.
$$
\begin{tikzpicture}
\node (P) at (0,0) {$
  \hpNew(\hpx\hpx')(
  \hpAbsurdZap{\hpa}{\hpNN,\hpx}
  \hpPar
  \hpAbsurdZap{\hpb}{\hpNM,\hpx'}
  )
  $};
\node (I) [below=0.125em of P] {};
\node (Q) [below=2.000em of P,xshift=-8em]
  {$\hpAbsurdZap{\hpa}{\hpNN,\hpNM,\hpb}$};
\node (R) [below=2.000em of P,xshift=+8em]
  {$\hpAbsurdZap{\hpb}{\hpNN,\hpNM,\hpa}$};
\draw (P.south) edge [->,out=-90,in=90] (Q.north);
\draw (P.south) edge [->,out=-90,in=90] (R.north);
\end{tikzpicture}
$$
Note that Wadler's semantics has the same problem, but, in his case, the non-confluence for the absurd offer is part of the general non-confluence caused by the commuting conversions [see @cp-commuting-conversions].

The solution is simple: treat all endpoints in a zapper the same.
We alter the syntax for zappers to $\hpZapper{\hpNN}$ and alter the typing and reduction rules to reflect the new syntax.
$$
\begin{array}{c}
  \hpP, \hpQ, \hpR
    \Coloneq \dots
    \mid     \mathst{\hpAbsurdZap\hpx\hpNN}
    \mid     \hpZapper\hpNN
\\[1.5em]
\AXC{$\hpNN=\fn(\hpGG)$}
\RL{\RuleLabel{H}{T-Zap}}
\UIC{$
    \hpZapper{\hpNN,\hpx}
    \hpSeq
    \hpGG,\hpx:\hpTop
  $}
\DP
\qquad
\AXC{$\readyOn{\hpP}{\hpx'}$}
\AXC{$\hpNM\defeq\fn(\hpP)\setminus\{\hpx'\}$}
\RL{\RuleLabel{H}{E-Zap}}
\BIC{$
    \hpNew(\hpx\hpx')(
    \hpZapper{\hpNN,\hpx}
    \hpPar
    \hpP
    )
    \hpEval
    \hpZapper{\hpNN,\hpNM}
  $}
\DP
\end{array}
$$
The critical pair is resolved. The two processes are definitionally equal:
$$
\begin{tikzpicture}
\node (P) at (0,0) {$
  \hpNew(\hpx\hpx')(
  \hpZapper{\hpNN,\hpa,\hpx}
  \hpPar
  \hpZapper{\hpNM,\hpb,\hpx'}
  )
  $};
\node (I) [below=0.125em of P] {};
\node (Q) [below=2.000em of P,xshift=-8em]
  {$\hpZapper{\hpNN,\hpNM,\hpa,\hpb}$};
\node (R) [below=2.000em of P,xshift=+8em]
  {$\hpZapper{\hpNN,\hpNM,\hpb,\hpa}$};
\draw (P.south) edge [->,out=-90,in=90] (Q.north);
\draw (P.south) edge [->,out=-90,in=90] (R.north);
\draw (Q.east)  edge [double]           (R.west);
\end{tikzpicture}
$$
Alternatively, if one wishes to avoid definitional set equality, the permutation of the endpoints in $\hpNN$ could be arranged via the structural congruence. In this case, there is no need to add rules for contraction, since the typing rule guarantees the uniqueness of the endpoints in $\hpNN$.

To reflect the fact that a zapper must be ready on all its endpoints, we alter the definition of *ready*.

Definition (Ready) {#hcp-zap-ready}.
  ~ A process $\hpP$ is *ready to act on* $\hpx$, written $\readyOn\hpP\hpx$, if it is of one of the forms:
    $$
    \!\!
    \begin{array}{lllllll}
    \hpLink\hpx\hpy
    &
    \hpSend\hpx\hpy.\hpP
    &
    \hpClose\hpx.\hpP
    &
    \hpSelect\hpx<1.\hpP
    &
    \hpSelect\hpx<2.\hpP
    &
    \hpZapper{\hpNN,\hpx}
    \\
    \hpLink\hpy\hpx
    &
    \hpRecv\hpx\hpy.\hpP
    &
    \hpWait\hpx.\hpP
    &
    \multicolumn{2}{l}{%
    \hpOffer\hpx(\hpInl: \hpP; \hpInr: \hpQ)}
    \end{array}
    $$
    A process $\hpP$ is *ready* if it is ready to act on some endpoint.

The addition of \Rule{H-T-Zap} and \Rule{H-E-Zap} preserves all the metatheoretical properties of HCP presented in this chapter:

- The proof of *preservation* requires an additional case for \Rule{H-E-Zap} (see @proposition:hcp-zap-preservation).
- The proof of *progress* requires no changes.
  All relevant changes are contained in the reduction lemma [see @lemma:hcp-zap-reduce-dual].
- The definitions of canonical form and the dependency and connection graphs are unchanged, as are the corresponding proofs of the adequacy of canonical forms, right-branching form, and disentanglement.
  All relevant changes are contained in the definition of *ready* [see @definition:hcp-zap-ready].
- The calculus continues to be in correspondence with CP, with the caveat that similar changes must be made to CP's syntax and semantics for zappers.
- Finally, we make similar changes to the label-transition system, such that harmony continues to hold.

We presented the updated proofs for preservation and progress and the updated label-transition system.

Proposition (Preservation) {#hcp-zap-preservation}.
  ~ If $\hpP\hpSeq\hpHG$ and $\hpP\hpEval\hpQ$,
    then $\hpQ\hpSeq\hpHG$.

```include
proofs/hcp-zap-preservation.md
```

Lemma (Reduction) {#hcp-zap-reduce-dual}.
  ~ If $\hpNew(\hpx\hpx')(\hpP\hpPar\hpQ)\hpSeq\hpHG$, and $\hpP$ and $\hpQ$ are ready to act on $\hpx$ and $\hpx'$, respectively, there exists some $\hpR$ such that $\hpNew(\hpx\hpx')(\hpP\hpPar\hpQ)\hpEval\hpR$.

```include
proofs/hcp-zap-reduce-dual.md
```

Proposition (Progress) {#hcp-zap-progress}.
  ~ If $\hpP\hpSeq\hpHG$,
    then either $\hpP$ is in canonical form, or
    there exists some $\hpQ$ such that $\hpP\hpEval\hpQ$.

```include
proofs/hcp-zap-progress.md
```

Let us extend the label-transition system and the proof of harmony.
We extend the action labels with two new actions.
$$
\hpAct
\Coloneq \dots
\mid     \hpAbsurdZap{\hpx}{\hpNN}
\mid     \hpAbsurdZop{\hpx}{\hpNN}
$$
The action $\hpAbsurdZap{\hpx}{\hpNN}$ denotes sending a kill signal, and receiving the unused endpoints $\hpNN$ from the killed process.
The action $\hpAbsurdZop{\hpx}{\hpNN}$ denotes the dual, receiving a kill signal, and sending the unused endpoints $\hpNN$.

We add two corresponding action transition rules and one corresponding communication rule.
$$
\!\!%
\begin{array}{
    >{$}p{0.45\linewidth}<{$}
    @{\hspace{0.025\linewidth}}
    >{$}p{0.45\linewidth}<{$}
  }
  \headerrule{Action Rules}
  &
  \headerrule{Communication Rules}
  \\
  \hfill
  \begin{array}{l@{\;}c@{\;}l@{\hspace{0.2\linewidth}}l}
      \hpZapper{\hpNN,\hpx}
    & \hpTo{\hpAbsurdZap{\hpx}{\hpNM}}
    & \hpZapper{\hpNN,\hpNM}
    & \RuleLabel{H}{Act-Kill}
    \\
      \hpP
    & \hpTo{\hpAbsurdZop{\hpx}{\hpNN}}
    & \hpZ
    & \RuleLabel{H}{Act-Die}
    \\
    \multicolumn{4}{r}{%
    \text{if }\readyOn{\hpP}{\hpx}\text{ and }\neg\isZapper{\hpP}}
    \\
    \multicolumn{4}{r}{%
    \text{where }\hpNN\defeq\fn(\hpP)\setminus\{\hpx\}}
  \end{array}
  \hfill
  {}
  &
  \hfill
  \begin{RuleWithLabel}{H}{Tau-Kill-Die}
    \AXC{$
      \hpP
      \hpTo{
        \hpAbsurdZap{\hpx}{\hpNN}
        \hpLabPar
        \hpAbsurdZop{\hpx'}{\hpNN}
      }
      \hpP'
      $}
    \UIC{$
      \hpNew(\hpx\hpx')\hpP
      \hpTTo
      \hpP'
      $}
    \DP
  \end{RuleWithLabel}
  \hfill
  {}
\end{array}
$$

Proposition (Harmony) {#hcp-zap-lts-harmony}.
  ~ If $\hpP\hpSeq\hpHG$,
    then $\hpP\hpTTo\hpEquiv\hpQ\iff\hpP\hpEval\hpQ$.

Proof.
  ~ The proof proceeds as @proposition:hcp-lts-harmony.
    In case ($\Rightarrow$), there is an additional case for \Rule{H-Tau-Kill-Die} with \Rule{H-Act-Kill} and \Rule{H-Act-Die}.
    In case ($\Leftarrow$), there is an additional case for \Rule{H-E-Zap}.

## A Zapper Is Made Of Other, Smaller Zappers

A zapper must be ready to act on all its endpoints in parallel.
Hence, we should think of the zapper $\hpZapper{\hpx_1,\hptm{\dots},\hpx_n}$ as a representation of the parallel composition of individual zappers for each endpoint, i.e., $\hpZapper{\hpx_1}\hpPar\hptm{\dots}\hpPar\hpZapper{\hpx_n}$.
Under this view, the permutation of the endpoints in a zapper follows from the permutation of parallel processes under structural congruence, which is rather pleasing.
This is exactly how zappers are represented in Fowler's Exceptional GV [EGV, @FowlerLMD19:egv].
However, this representation is not well-typed in HCP:
$$
  \AXC{$\vphantom{\co{\co{\hpA}}}$}
  \LL{(a)}
  \UIC{$
    \hpZapper{\hpa,\hpb}
    \hpSeq
    \hpa:\hpTop,
    \hpb:\hpA
    $}
  \DP
  \qquad
  \AXC{}
  \UIC{$
    \hpZapper{\hpa}
    \hpSeq
    \hpa:\hpTop
    $}
  \AXC{}
  \UIC{$
    \hpZapper{\hpb}
    \hpSeq
    \hpb:\hpA
    $}
  \RL{(b)}
  \BIC{$
    \hpZapper{\hpa}
    \hpPar
    \hpZapper{\hpb}
    \hpSeq
    \hpa:\hpTop
    \hpHTens
    \hpb:\hpA
    $}
  \DP
$$
To type (b), we would have to change the local constraint that at least one endpoint introduced by the zapper must have type $\hpTop$ to the *non-local* constraint that at least one zapper must introduce an endpoint with type $\hpTop$.
Since EGV is not interested in preserving consistency and allows exceptions to occur in any context, it does not require this restriction.

To assign (a) and (b) the same type, we would have to admit \RuleName{Mix}, which breaks the connection structure of HCP and the correspondence with CLL. Since EGV is not interested in preserving that correspondence for its runtime terms, it admits \RuleName{Mix} in its runtime type system.

While the representation $\hpZapper{\hpx_1}\hpPar\hptm{\dots}\hpPar\hpZapper{\hpx_n}$ is not a good fit for HCP, it provides an intuition for the implementation of zappers.
A zapper is not a single monolithic process that takes ownership of all the unused resources of the processes it kills, and the killed process should not transfer ownership of all their unused endpoints to such a monolithic zapper.
Zappers are small processes responsible for cleaning up individual resources.
Once a zapper has successfully delivered a kill signal, it may terminate.
The killed process, upon receiving a kill signal, simply spawns off one zapper process for each of its unused resources, and then terminates.

## Could You To Tell Me When You Are Done?

In this section, we have described an exceptional semantics for the absurd offer in which all cancelled endpoints are treated equally.
In this final portion of the section, I hope to convince you that there is no well-behaved interpretation that treats one endpoint specially, as implied by the syntax used in @cp and @hcp, and that this is a direct consequence of the fact that the logical rule corresponding to \Rule{H-T-AbsurdZap} can introduce multiple propositions $\hpTop$ which it cannot distinguish.

Let us consider an alternative interpretation for the zapper $\hpAbsurdZap{\hpx}{\hpNN}$ where the endpoint $\hpx$ *is* special:

- When some process $\hpP$ receives a kill signal on $\hpx$, it becomes the zapper $\hpAbsurdZap{\hpx}{\hpNN}$, where $\hpNN$ contains its unused endpoints, i.e., $\hpNN=\fn(\hpP)\setminus\{\hpx\}$.
- A zapper $\hpAbsurdZap{\hpx}{\hpNN}$ does the following for each endpoint in $\hpNN$ in parallel:

  - It sends a kill signal.
  - It waits to receive a notification to confirm that the process on the other side has finished cleaning up and has terminated.
  - It closes the channel, and removes the endpoint from $\hpNN$.

- When $\hpNN$ is empty, the zapper notifies the process on the other side of $\hpx$ that it has finished cleaning up, and terminates.

Such an interpretation is useful. For instance, if we implement processes as OS threads, then the main thread must not terminate before all the child threads have finished cleaning up.

Under this interpretation, a zapper $\hpAbsurdZap{\hpx}{\hpNN}$ is ready on all the endpoints in $\hpNN$ in parallel, but is blocked on $\hpx$ until $\hpNN$ is empty. Consider the following reduction rules:
$$
\!\!%
\begin{array}{l@{\;\hpEval\;}l@{\quad}l}
  \hpNew(\hpx\hpx')(
    \hpAbsurdZap{\hpw}{\hpNN,\hpx}
    \hpPar
    \hpAbsurdZap{\hpx'}{\hptm{\emptyset}}
  )
& \hpAbsurdZap{\hpw}{\hpNN}
& \RuleLabel{H}{E-Zap-Notify}
\\
  \hpNew(\hpx\hpx')(
    \hpAbsurdZap{\hpw}{\hpNN,\hpx}
    \hpPar
    \hpP
  )
& \hpNew(\hpx\hpx')(
    \hpAbsurdZap{\hpw}{\hpNN,\hpx}
    \hpPar
    \hpAbsurdZap{\hpx'}{\hpNM}
  )
& \RuleLabel{H}{E-Zap-Kill}
\\[0.5ex]
\multicolumn{3}{r}{%
\text{if }\readyOn{\hpP}{\hpx'}\text{ and }\neg\isZapper{\hpP}}
\\[0.5ex]
\multicolumn{3}{r}{%
\text{where }\hpNM\defeq\fn(\hpP)\setminus\{\hpx'\}}
\end{array}
$$
These rules preserve typing. The rule \Rule{H-E-Zap-Kill} rebinds $\hpx$ and $\hpx'$ with types $\hpx:\hpNil$ and $\hpx':\hpTop$, but this is usual for session types.
However, they are only well-behaved under certain circumstances.
Consider the two processes
$$
\text{(a) }%
\hpNew(\hpx\hpx')(
  \hpAbsurdZap{\hpa}{\hpNN,\hpx}
  \hpPar
  \hpAbsurdZap{\hpx'}{\hpNM}
)
\qquad
\hpNew(\hpx\hpx')(
  \hpAbsurdZap{\hpa}{\hpNN,\hpx}
  \hpPar
  \hpAbsurdZap{\hpb}{\hpNM,\hpx'}
)
\text{ (b)}%
$$
If a process up to structural congruence does not contain (b), then progress, termination, and confluence follow by an argument from the structure of the connection graph.
To simplify matters, let us consider a fully-connected process with a single zapper
$$
  \hpCC[\hpAbsurdZap\hpa\hpNN,\hpP_1,\hptm\dots,\hpP_n]
$$
where each $\hpP_i$ is ready on some bound endpoint $\hpx_i$.
The process reduces to a single zapper in $2n$ steps.

1.  By $n$ applications of \Rule{H-E-Zap-Kill}, following the structure of the connection tree outward from the zapper $\hpAbsurdZap\hpa\hpNN$, we convert each process $\hpP_i$ to a zapper $\hpAbsurdZap{\hpx_i}{\hpNN_i}$ where $\hpNN_i=\fn(\hpP_i)\setminus\{\hpx_i\}$.
2.  If $\hpP_i$ is a leaf of the connection graph, it is of the form $\hpAbsurdZap{\hpx_i}{\hptm{\emptyset}}$. By $n$ application of \Rule{H-E-Zap-Notify}, following the structure of the connection tree inwards from the leaves, we convert the entire process to $\hpAbsurdZap{\hpa}{\hpNM}$, where $\hpNM$ contains all the free endpoints from $\hpNN$ and each $\hpNN_i$.

If some $\hpP_i$ is blocked on a free endpoint, reduction becomes blocked as usual.
If the process contains multiple zappers, but the connection structure for these zappers is always as in (a), then that merely reduces the number of uses of \Rule{H-E-Zap-Kill} that are needed.
If the process is not fully-connected, any component with at least zapper reduces to become a single zapper, and the remaining components reduce as usual.

Under this interpretation, $\hpNil$ and $\hpTop$ are assigned dual behaviours---an endpoint of type $\hpNil$ is used to send a kill signal and then wait for confirmation, and an endpoint of type $\hpTop$ is used, dually, to receive a kill signal, and then send confirmation and terminate---and therein lies the problem.
The typing derivation for process (b)
$$
\hpNew(\hpx\hpx')(
  \hpAbsurdZap{\hpa}{\hpNN,\hpx}
  \hpPar
  \hpAbsurdZap{\hpb}{\hpNM,\hpx'}
)
$$
could assign $\hpx:\hpNil$ and $\hpx':\hpTop$, or vice versa, but by \Rule{H-E-Zap-Kill}, they will be treated the same, not dually.
The type system does not have sufficient structure to ensure the desired dual behaviour.
