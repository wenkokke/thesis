# Label-Transition System and Harmony {#hcp-lts-and-harmony}

In the previous sections, we got HCP up to speed.
We adapted CP's metatheory and showed that HCP enjoys all the same properties, and characterised the exact correspondence between CP and HCP by disentanglement.

In this section, we get to enjoy some of the spoils of all that work.
We introduce the beginnings of a behavioural theory for HCP, *just enough* to relate the use of the label-transition system in the following chapter to the reduction semantics, and to use as a springboard to find and fix further flaws in our present formulation of HCP in the discussion.

The label-transition semantics for HCP, first introduced by @MontesiP18:ct, are given by labelled transition, which is a ternary relation on two processes and a label.
A label is either the internal action label $\hpTau$, an observable action label $\hpAct$, or a pair of parallel observable action labels $\hpAct\hpLabPar\hpAct'$.
$$
  \hpLab
  \Coloneq \hpTau
  \mid     \hpAct
  \mid     \hpAct\hpLabPar\hpAct'
$$
The observable action labels correspond to the action prefixes of processes, except for  the offer labels $\hpOffer\hpx>1$ and $\hpOffer\hpx>2$, which denote the offer of $\hpInl$ or $\hpInr$, respectively, in $\hpOffer\hpx(\hpInl:\hpP;\hpInr:\hpQ)$.
$$
  \hpAct
  \Coloneq \hpLink\hpx\hpy
  \mid     \hpSend\hpx\hpy
  \mid     \hpRecv\hpx\hpy
  \mid     \hpClose\hpx
  \mid     \hpWait\hpx
  \mid     \hpSelect\hpx<1
  \mid     \hpSelect\hpx<2
  \mid     \hpOffer\hpx>1
  \mid     \hpOffer\hpx>2
$$
An endpoint occurs free in an action label in the same cases where it would occur free in a process prefixed by that action. Likewise, an endpoint is bound by an action label in the same cases where it would occur bound in a process prefixed by that action. For instance, $\hpx\in\fn(\hpSend\hpx\hpy)$ and $\hpy\in\bn(\hpSend\hpx\hpy)$.
An endpoint occurs free in $\hpAct\hpLabPar\hpAct'$ when it occurs free in either $\hpAct$ or $\hpAct'$. An endpoint is bound by $\hpAct\hpLabPar\hpAct'$ when it is bound by either $\hpAct$ or $\hpAct'$.
The label $\hpTau$ has no free or bound names.

Definition (Label-Transition) {#hcp-lts}.
  ~ Label-transition, written $\hpP\hpTo\hpLab\hpQ$, is the smallest ternary relation on two processes and one label defined by the rules in @figure:hcp-lts.

![Label-Transition System for Hypersequent CP](figures/lts.tex?as=webp){#figure:hcp-lts}

What does a label-transition mean?
If a process has an observable action, i.e., a transition with an observable action label $\hpAct$, it means the action $\hpAct$ is observable---some unblocked sub-process is prefixed by the action $\hpAct$ on a free endpoint.
If a process has pair of parallel observable actions, i.e., a transition with a label $\hpAct\hpLabPar\hpAct'$, it means both actions are observable and independent.
If a process has a $\hpTau$-transition, it has some internal, unobservable reduction.
To use familiar terminology:
$$
\begin{array}{l@{\;}c@{\;}lcl@{\;}c@{\;}l}
\hpP & \hpTo{\hpAct} & \hpQ
& \iff
& \hpP & \hpEquiv & \hpAct.\hpP'\hpPar\hpR
\\
\hpP & \hpTo{\hpAct\hpLabPar\hpAct'} & \hpQ
& \iff
& \hpP & \hpEquiv & \hpAct.\hpP_1\hpPar\hpAct'.\hpP_2\hpPar\hpR
\\
\hpP & \hpTTo\hpEquiv & \hpQ
& \iff
& \hpP & \hpEval & \hpQ
\end{array}
$$
These properties are intended to provide an *informal* intuition.
They are not well-formed for the offer, since, e.g., "$\hpOffer\hpx>1.\hpP$" is a syntactically ill-formed process. However, the intuition still applies:
$$
\begin{array}{l@{\;}c@{\;}lcl@{\;}l@{\;}l}
\hpP & \hpTo{\hpOffer\hpx>1} & \hpQ
& \iff
& \hpP & \hpEquiv & \hpOffer\hpx(\hpInl: \hpP_1; \hpInr: \hpP_2)\hpPar\hpR
\\
\hpP & \hpTo{\hpOffer\hpx>2} & \hpQ
& \iff
& \hpP & \hpEquiv & \hpOffer\hpx(\hpInl: \hpP_1; \hpInr: \hpP_2)\hpPar\hpR
\\
\hpP & \hpTo{\hpSelect\hpx<1\hpLabPar\hpOffer\hpx>1} & \hpQ
& \iff
& \hpP & \hpEquiv & \hpSelect\hpx<1.\hpP_1\hpPar\hpOffer\hpx(\hpInl: \hpP_2; \hpInr: \hpP_3)\hpPar\hpR
\\
\hpP & \hpTo{\hpSelect\hpx<2\hpLabPar\hpOffer\hpx>2} & \hpQ
& \iff
& \hpP & \hpEquiv & \hpSelect\hpx<2.\hpP_1\hpPar\hpOffer\hpx(\hpInl: \hpP_2; \hpInr: \hpP_3)\hpPar\hpR
\end{array}
$$
Label-transitions are closed under independent evaluation contexts by \Rule{H-Str-Cong}, which requires that the bound and free endpoints of the evaluation context and the label are disjoint.
Consequently, $\hpTau$-transitions, whose labels have neither free nor bound endpoints, are closed under arbitrary evaluation contexts.

The label-transition system does not use the structural congruence.
As a consequence of a label-transition, a process may change *locally* and it may close the channel or open a new channel.
However, the structure of any name restrictions and parallel compositions *unrelated to* the communication does not change.
On the other hand, the structural congruence does not essentially alter actions.
Label-transition and structural congruence are mutually invariant:
$$
  \hpP\hpEquiv\hpTo\hpLab\hpQ
  \iff
  \hpP\hpTo\hpLab\hpEquiv\hpQ
$$
Reductions may contain arbitrary structural congruence, and change the process structure in ways that are not strictly necessary for the reduction itself.
Hence, while a $\hpTau$-transition corresponds to a reduction, a reduction corresponds to a $\hpTau$-transition *and* a structural congruence.

Label-transition and structural congruence are mutually invariant.

Lemma {#hcp-lts-equiv}.
  ~ If $\hpP\hpEquiv\hpTo\hpLab\hpQ$, then $\hpP\hpTo\hpLab\hpEquiv\hpQ$.

```include
proofs/hcp-lts-equiv.md
```

Any derivation of a label-transition can be normalised, by combining successive uses of the \Rule{H-Str-Cong} rule.
\Cref{lemma:hcp-canonical-transition-act,lemma:hcp-canonical-transition-par,lemma:hcp-canonical-transition-tau} normalise action transitions, parallel action transitions, and $\hpTau$-transitions, respectively.

Lemma {#hcp-canonical-transition-act}.
  ~ Any derivation of a transition $\hpP\hpTo{\hpAct}\hpQ$ can be rewritten to
    $$
      \AXC{}
      \RL{$a$}% Act-*
      \UIC{$
        \hpP_1
        \hpTo{\hpAct}
        \hpP'_1$}
      \RL{\Rule{H-Str-Cong}}% Str-Cong
      \UIC{$
        \hpEF_1[\hpP_1]
        \hpTo{\hpAct}
        \hpEF_1[\hpP'_1]$}
      \DP
    $$
    where $a$ is \Rule{H-Act-Link1}, \Rule{H-Act-Link2}, \Rule{H-Act-send}, \Rule{H-Act-Recv}, \Rule{H-Act-Close}, \Rule{H-Act-Wait}, \Rule{H-Act-Select1}, \Rule{H-Act-Select2}, \Rule{H-Act-Offer1}, or \Rule{H-Act-Offer2}.

```include
proofs/hcp-canonical-transition-act.md
```

Lemma {#hcp-canonical-transition-par}.
  ~ Any derivation of a transition $\hpP\hpTo{\hpAct\hpLabPar\hpAct'}\hpQ$ can be rewritten to
    $$
      % 1.
        \AXC{}
        \RL{$a$}% Act-*
        \UIC{$
          \hpP_1
          \hpTo{\hpAct\vphantom{\hpAct'}}
          \hpP'_1$}
        \RL{\Rule{H-Str-Cong}}% Str-Cong
        \UIC{$
          \hpEF_1[\hpP_1]
          \hpTo{\hpAct\vphantom{\hpAct'}}
          \hpEF_1[\hpP'_1]$}
      % 2.
        \AXC{}
        \RL{$\bar{a}$}% Act-*
        \UIC{$
          \hpP_2
          \hpTo{\hpAct'\vphantom{\hpAct'}}
          \hpP'_2$}
        \RL{\Rule{H-Str-Cong}}% Str-Cong
        \UIC{$
          \hpEF_2[\hpP_2]
          \hpTo{\hpAct'\vphantom{\hpAct'}}
          \hpEF_2[\hpP'_2]$}
      \RL{\Rule{H-Str-Par}}% Str-Par
      \BIC{$
        \hpEF_1[\hpP_1]\hpPar\hpEF_2[\hpP_2]
        \hpTo{\hpAct\hpLabPar\hpAct'}
        \hpEF_1[\hpP'_1]\hpPar\hpEF_2[\hpP'_2]$}
      \RL{\Rule{H-Str-Cong}}% Str-Cong
      \UIC{$
        \hpEE_3[\hpEF_1[\hpP_1]\hpPar\hpEF_2[\hpP_2]]
        \hpTo{\hpAct\hpLabPar\hpAct'}
        \hpEE_3[\hpEF_1[\hpP'_1]\hpPar\hpEF_2[\hpP'_2]]$}
      \DP
    $$
    where $a$ and $\bar{a}$ are one of \Rule{H-Act-Link1}, \Rule{H-Act-Link2}, \Rule{H-Act-send}, \Rule{H-Act-Recv}, \Rule{H-Act-Close}, \Rule{H-Act-Wait}, \Rule{H-Act-Select1}, \Rule{H-Act-Select2}, \Rule{H-Act-Offer1}, or \Rule{H-Act-Offer2}.

```include
proofs/hcp-canonical-transition-par.md
```

Lemma {#hcp-canonical-transition-tau}.
  ~ Any derivation of a transition $\hpP\hpTTo\hpQ$ can be rewritten to
    $$
      % 1.
        \AXC{}
        \RL{$a$}% Act-*
        \UIC{$
          \hpP_1
          \hpTo{\hpAct\vphantom{\hpAct'}}
          \hpP'_1$}
        \RL{\Rule{H-Str-Cong}}% Str-Cong
        \UIC{$
          \hpEF_1[\hpP_1]
          \hpTo{\hpAct\vphantom{\hpAct'}}
          \hpEF_1[\hpP'_1]$}
      % 2.
        \AXC{}
        \RL{$\bar{a}$}% Act-*
        \UIC{$
          \hpP_2
          \hpTo{\hpAct'\vphantom{\hpAct'}}
          \hpP'_2$}
        \RL{\Rule{H-Str-Cong}}% Str-Cong
        \UIC{$
          \hpEF_2[\hpP_2]
          \hpTo{\hpAct'\vphantom{\hpAct'}}
          \hpEF_2[\hpP'_2]$}
      \RL{\Rule{H-Str-Par}}% Str-Par
      \BIC{$
        \hpEF_1[\hpP_1]\hpPar\hpEF_2[\hpP_2]
        \hpTo{\hpAct\hpLabPar\hpAct'}
        \hpEF_1[\hpP'_1]\hpPar\hpEF_2[\hpP'_2]$}
      \RL{\Rule{H-Str-Cong}}% Str-Cong
      \UIC{$
        \hpEE_3[\hpEF_1[\hpP_1]\hpPar\hpEF_2[\hpP_2]]
        \hpTo{\hpAct\hpLabPar\hpAct'}
        \hpEE_3[\hpEF_1[\hpP'_1]\hpPar\hpEF_2[\hpP'_2]]$}
      \RL{$t$}% Tau-*
      \UIC{$
        \hpNew(\hpx\hpx')\hpEE_3[\hpEF_1[\hpP_1]\hpPar\hpEF_2[\hpP_2]]
        \hpTTo
        \hpEE_2[\hpEE_3[\hpEF_1[\hpP'_1]\hpPar\hpEF_2[\hpP'_2]]]$}
      \RL{\Rule{H-Str-Cong}}% Str-Cong
      \UIC{$
        \hpEE_1[\hpNew(\hpx\hpx')\hpEE_3[\hpEF_1[\hpP_1]\hpPar\hpEF_2[\hpP_2]]]
        \hpTTo
        \hpEE_1[\hpEE_2[\hpEE_3[\hpEF_1[\hpP'_1]\hpPar\hpEF_2[\hpP'_2]]]]$}
      \DP
    $$
    where $t$ is one of \Rule{H-Tau-Link}, \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Close-Wait}, \Rule{H-Tau-Select-Offer1}, or \Rule{H-Tau-Select-Offer2}, and $a$ and $\bar{a}$ are one of \Rule{H-Act-Link1}, \Rule{H-Act-Link2}, \Rule{H-Act-send}, \Rule{H-Act-Recv}, \Rule{H-Act-Close}, \Rule{H-Act-Wait}, \Rule{H-Act-Select1}, \Rule{H-Act-Select2}, \Rule{H-Act-Offer1}, or \Rule{H-Act-Offer2}.

```include
proofs/hcp-canonical-transition-tau.md
```

The equivalences between action transitions and parallel action transitions and structural congruence follow as corollaries from \Cref{lemma:hcp-canonical-transition-act,lemma:hcp-canonical-transition-par} and @corollary:hcp-evaluation-context-commute-nil, and their converses follow from @lemma:hcp-lts-equiv.
$$
\begin{array}{l@{\;}c@{\;}lcl@{\;}c@{\;}l}
  \hpP & \hpTo{\hpAct} & \hpQ
  & \iff
  & \hpP & \hpEquiv & \hpAct.\hpP'\hpPar\hpR
  \\
  \hpP & \hpTo{\hpAct\hpLabPar\hpAct'} & \hpQ
  & \iff
  & \hpP & \hpEquiv & \hpAct.\hpP_1\hpPar\hpAct'.\hpP_2\hpPar\hpR
\end{array}
$$
Harmony follows by relating the normal-form derivations of $\hpTau$-transition [@lemma:hcp-canonical-transition-tau] and reduction [@lemma:hcp-canonical-reduction].

Proposition (Harmony) {#hcp-lts-harmony}.
  ~ If $\hpP\hpSeq\hpHG$, then $\hpP\hpTTo\hpEquiv\hpQ\iff\hpP\hpEval\hpQ$.

```include
proofs/hcp-lts-harmony.md
```
