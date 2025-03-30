# Fission, Fusion, and Disentanglement {#hcp-fission-fusion-and-disentanglement}

In this section, I discuss the correspondence between Hypersequent CP and Multiset CP. The correspondence has three components---the titular components of this section. Fission is a translation from Multiset CP to Hypersequent CP, and, together, fusion and disentanglement are a translation from Hypersequent CP to Multiset CP. I discuss each component of the correspondence in order, starting with the easy one.

## Fission

Fission is a translation from Multiset CP to Hypersequent CP, which splits CP's cut, send, and close into the corresponding HCP processes:
<!--
(The "$\fission$"'s are intended to emphasise the split, and should not be read as part of the process syntax.)
-->
$$
\begin{array}{r@{}l@{\quad\text{to}\quad}r@{\fission}l}
  \cpNew(\cpx\cpx')&\cptm(\cpP\cpPar\cpQ\cptm)
  &
  \hpNew(\hpx\hpx')&\hptm(\hpP\hpPar\hpQ\hptm)
  \\
  \cpSend\cpx\cpy.&\cptm(\cpP\cpPar\cpQ\cptm)
  &
  \hpSend\hpx\hpy.&\hptm(\hpP\hpPar\hpQ\hptm)
  \\
  \cpClose\cpx.&\cpZ
  &
  \hpClose\hpx.&\hpZ
\end{array}
$$
Visually, its definition resembles an elaborate identity function.

Definition {#hcp-fission}.
  ~ Fission, $\CtoH(\cpP)$, translates CP processes into HCP processes by splitting each cut into a separate name restriction and parallel composition, and likewise splitting send and close.
    $$
    \begin{array}{l@{\;\defeq\;}l}
    \CtoH(\cpLink\cpx\cpy)
    &
    \hpLink\hpx\hpy
    \\
    \CtoH(\cpNew(\cpx\cpx')(\cpP\cpPar\cpQ))
    &
    \hpNew(\hpx\hpx')(\CtoH(\cpP)\cpPar\CtoH(\cpQ))
    \\
    \CtoH(\cpSend\cpx\cpy.(\cpP\cpPar\cpQ))
    &
    \hpSend\hpx\hpy.(\CtoH(\cpP)\cpPar\CtoH(\cpQ))
    \\
    \CtoH(\cpRecv\cpx\cpy.\cpP)
    &
    \hpRecv\hpx\hpy.\CtoH(\cpP)
    \\
    \CtoH(\cpClose\cpx.\cpZ)
    &
    \hpClose\hpx.\hpZ
    \\
    \CtoH(\cpWait\cpx.\cpP)
    &
    \hpWait\hpx.\CtoH(\cpP)
    \\
    \CtoH(\cpSelect\cpx<1.\cpP)
    &
    \hpSelect\hpx<1.\CtoH(\cpP)
    \\
    \CtoH(\cpSelect\cpx<2.\cpP)
    &
    \hpSelect\hpx<2.\CtoH(\cpP)
    \\
    \CtoH(\cpOffer\cpx(\cpInl: \cpP; \cpInr: \cpQ))
    &
    \hpOffer\hpx(\hpInl: \CtoH(\cpP); \hpInr: \CtoH(\cpQ))
    \\
    \CtoH(\cpAbsurdZap\cpx\cpNN)
    &
    \hpAbsurdZap\hpx\hpNN
    \end{array}
    $$
    Fission is extended to Multiset CP as follows:
    $$
    \begin{array}{l@{\;\defeq\;}l}
    \MtoH(\cpP)
    &
    \CtoH(\cpP)
    \\
    \MtoH(\mpP\mpPar\mpQ)
    &
    \MtoH(\mpP)\hpPar\MtoH(\mpQ)
    \end{array}
    $$
    Fission is extended to process contexts, where it preserves holes and otherwise acts as it does on processes.
    Fission is the identity on types and typing environments, mapping each connective in CP to the same connective in HCP.

Fission distributes over arbitrary process contexts.

Proposition {#hcp-fission-distributes-over-process-context}.
  ~ $\CtoH(\cptm(\cpCP[\cpQ]\cptm))=\hptm(\CtoH(\cpCP)\hptm)\hptm[\CtoH(\cpQ)\hptm]$

Proof.
  ~ By induction on the structure of the evaluation context $\cpCP$.

Fission preserves types, structural congruence, and reduction.

Proposition {#hcp-fission-preserves-types}.
  ~ If $\cpP\cpSeq\cpGG$, then $\CtoH(\cpP)\hpSeq\CtoH(\cpGG)$.

```include
proofs/hcp-fission-preserves-types.md
```

Proposition {#hcp-fission-preserves-equiv}.
  ~ If $\cpP\cpEquiv\cpQ$, then $\CtoH(\cpP)\hpEquiv\CtoH(\cpQ)$.

```include
proofs/hcp-fission-preserves-equiv.md
```

Proposition {#hcp-fission-preserves-eval}.
  ~ If $\cpP\cpEval\cpQ$, then $\CtoH(\cpP)\hpEval\CtoH(\cpQ)$.

```include
proofs/hcp-fission-preserves-eval.md
```

## Fusion

Fusion is the partial inverse of fission. It fuses an HCP name restriction and parallel composition into a CP cut, an HCP send and parallel composition into a CP send, and an HCP close and parallel composition into a CP close, but *only* if the HCP process already has the form of a CP process.
$$
\begin{array}{r@{\fission}l@{\quad\text{to}\quad}r@{}l}
  \hpNew(\hpx\hpx')&\hptm(\hpP\hpPar\hpQ\hptm)
  &
  \cpNew(\cpx\cpx')&\cptm(\cpP\cpPar\cpQ\cptm)
  \\
  \hpSend\hpx\hpy.&\hptm(\hpP\hpPar\hpQ\hptm)
  &
  \cpSend\cpx\cpy.&\cptm(\cpP\cpPar\cpQ\cptm)
  \\
  \hpClose\hpx.&\hpZ
  &
  \cpClose\cpx.&\cpZ
\end{array}
$$
Visually, its definition likewise resembles an elaborate identity function.

Definition {#hcp-partial-fusion}.
  ~ Fusion, $\HtoC(\cpP)$, translates HCP processes into CP processes by fusing adjacent name restrictions and parallel compositions into cuts, and likewise fusing send and close. Fusion is *partial*.
    $$
    \begin{array}{l@{\;\defeq\;}l}
    \HtoC(\hpLink\hpx\hpy)
    &
    \cpLink\cpx\cpy
    \\
    \HtoC(\hpNew(\hpx\hpx')(\hpP\hpPar\hpQ))
    &
    \cpNew(\cpx\cpx')(\HtoC(\hpP)\cpPar\HtoC(\hpQ))
    \\
    \HtoC(\hpSend\hpx\hpy.(\hpP\hpPar\hpQ))
    &
    \cpSend\cpx\cpy.(\HtoC(\hpP)\cpPar\HtoC(\hpQ))
    \\
    \HtoC(\hpRecv\hpx\hpy.\hpP)
    &
    \cpRecv\cpx\cpy.\HtoC(\hpP)
    \\
    \HtoC(\hpClose\hpx.\hpZ)
    &
    \cpClose\cpx.\cpZ
    \\
    \HtoC(\hpWait\hpx.\hpP)
    &
    \cpWait\cpx.\HtoC(\hpP)
    \\
    \HtoC(\hpSelect\hpx<1.\hpP)
    &
    \cpSelect\cpx<1.\HtoC(\hpP)
    \\
    \HtoC(\hpSelect\hpx<2.\hpP)
    &
    \cpSelect\cpx<2.\HtoC(\hpP)
    \\
    \HtoC(\hpOffer\hpx(\hpInl: \hpP; \hpInr: \hpQ))
    &
    \cpOffer\cpx(\cpInl: \HtoC(\hpP); \cpInr: \HtoC(\hpQ))
    \\
    \HtoC(\hpAbsurdZap\hpx\hpNN)
    &
    \cpAbsurdZap\cpx\cpNN
    \end{array}
    $$
    Fusion is extended to Multiset CP as follows:
    $$
    \begin{array}{l@{\;\defeq\;}l}
    \HtoM(\hpP)
    &
    \begin{cases}
    \HtoM(\hpQ)\mpPar\HtoM(\hpR)
    & \text{if }
      \hpP=\hpQ\hpPar\hpR
    \\
    \HtoC(\hpP)
    & \text{otherwise}
    \end{cases}
    \end{array}
    $$
    Fusion is extended to process contexts, where it preserves holes and otherwise acts as it does on processes.
    Fusion is the identity on types and typing environments, mapping each connective in HCP to the same connective in CP.

    Fusion is the partial inverse of fission.

Fusion distributes over arbitrary process contexts.

Lemma {#hcp-partial-fusion-distributes-over-process-context}.
  ~ $\HtoC(\hpCP[\hpQ])=\HtoC(\hpCP)\cpPlug[\HtoC(\hpQ)]$.

Fusion preserves types.

Proposition {#hcp-fusion-preserves-types}.
  ~ If $\CtoH(\cpP)\hpSeq\CtoH(\cpGG)$, then $\cpP\cpSeq\cpGG$.

```include
proofs/hcp-fusion-preserves-types.md
```

Fusion is defined for all disentangled processes.

Lemma {#hcp-disentanglement-fusion}.
  ~ If $\hpP\hpSeq\hpHG$ and $\hpQ\in\hpBigDis(\hpP)$,
    then $\HtoM(\hpQ)$ is defined.

```include
proofs/hcp-disentanglement-fusion.md
```

The fusions of the disentangled processes are equivalent up to CP's link-preserving structural congruence.

Lemma {#hcp-disentanglement-fusion-equiv}.
  ~ If $\hpP\hpSeq\hpHG$ and $\hpQ,\hpR\in\hpBigDis(\hpP)$,
    then $\HtoM(\hpQ)\mpEquivLP\HtoM(\hpR)$.

```include
proofs/hcp-disentanglement-fusion-equiv.md
```

*Disentanglement into CP* is the composition of disentanglement and fusion.

Definition (Disentanglement into CP) {#hcp-disentanglement-cp}.
  ~ The *disentanglement* of $\hpP$ into CP, $\DisHtoM(\hpP)$, is the composition of disentanglement and fusion.
    Formally,
    $$
      \DisHtoM(\hpP)
      \defeq
      \{
        \HtoM(\hpQ)
        \vert
        \hpQ\in\hpBigDis(\hpP)
      \}
    $$
    By @lemma:hcp-disentanglement-fusion and @lemma:hcp-disentanglement-fusion-equiv, the set $\DisHtoM(\hpP)$ is non-empty for any $\hpP$, and all elements of $\DisHtoM(\hpP)$ are equivalent to each other under Multiset CP's link-preserving structural congruence.
    I use $\DisHtoM$ as functional up to structural congruence, and write $\DisHtoM(\hpP)\mpEquivLP\mpQ$ to mean $\mpQ$ is an arbitrary element of $\DisHtoM(\hpP)$.

Disentanglement into CP does not distribute over process contexts, as disentanglement normalises the entire maximum configuration context of a process in a single step.
Consequently, when doing proof by induction over the structure of a process, we must generalise the cases for name restriction and parallel composition to cover the entire maximum configuration context, as done in, e.g., the proof of @proposition:hcp-disentanglement-cp-equiv.

Disentanglement into CP preserves types, structural congruence, and reduction.

Proposition {#hcp-preservation-disentanglement-cp}.
  ~ If $\hpP\hpSeq\hpHG$ and $\DisHtoM(\hpP)\mpEquivLP\mpP$,
    then $\mpP\mpSeq\HtoM(\hpHG)$.

```include
proofs/hcp-preservation-disentanglement-cp.md
```

Proposition {#hcp-disentanglement-cp-equiv}.
  ~ If $\hpP\hpSeq\hpHG$ and $\hpP\hpEquiv\hpQ$,
    then $\DisHtoM(\hpP)\mpEquiv\DisHtoM(\hpQ)$.

```include
proofs/hcp-disentanglement-cp-equiv.md
```

Lemma {#hcp-canonical-reduction}.
  ~ Any derivation of a reduction $\hpP\hpEval\hpQ$ can be rewritten to
    $$
      \AXC{$\hpP \hpEquiv \hpEE[\hpNew(\hpx\hpx')(\hpP_1\hpPar\hpP_2)]$}
      \AXC{}
      \RightLabel{$r$}
      \UIC{$\hpNew(\hpx\hpx')(\hpP_1\hpPar\hpP_2) \hpEval \hpR$}
      \UIC{$\hpEE[\hpNew(\hpx\hpx')(\hpP_1\hpPar\hpP_2)] \hpEval \hpEE[\hpR]$}
      \AXC{$\hpEE[\hpR] \hpEquiv \hpQ$}
      \TIC{$\hpP \hpEval \hpQ$}
      \DP
    $$
    where $r$ is \Rule{H-E-Link}, \Rule{H-E-Send}, \Rule{H-E-Close}, \Rule{H-E-Select1}, or \Rule{H-E-Select2}.

```include
proofs/hcp-canonical-reduction.md
```

Proposition {#hcp-disentanglement-cp-eval}.
  ~ If $\hpP\hpSeq\hpHG$ and $\hpP\hpEval\hpQ$,
    then $\DisHtoM(\hpP)\mpEval\DisHtoM(\hpQ)$.

```include
proofs/hcp-disentanglement-cp-eval.md
```
