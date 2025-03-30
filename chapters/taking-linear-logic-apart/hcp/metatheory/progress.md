# Progress {#hcp-progress}

What should the canonical forms be for processes in HCP?

Unlike CP, HCP has syntax for the terminated process.
We could make the distinction between *normal form* and *neutral form*.
The normal form is the terminated process.
The neutral forms are processes stuck on a free name, i.e., processes whose communication is blocked on a free channel.

Is that distinction meaningful?
No, not in the context of HCP's reduction semantics.
HCP processes do not *reduce to* normal form.
After all, HCP preserves CP's semantics.
Any process that does *anything* is never done.

Let us stick with the terminology "canonical form" for now.
CP's definition for canonical form is adapted almost effortlessly.
An HCP process $\hpP$ is in canonical form if and only if

  1.  $\hpP$ contains no link thread ready to act on a bound endpoint; and
  2.  $\hpP$ contains no two processes ready to act on dual endpoints.

Case (1) rules out α-reduction---any link evaluating as α-renaming.
Case (2) rules out β-reduction---any other reduction.
(The definitions of α- and β-reduction are unchanged from @cp-progress.)

Definition (α-Reduction) {#hcp-a-reduction}.
  ~ A process $\hpP$ α-reduces to $\hpQ$, written $\hpP \hpEvalA \hpQ$, if there exists a reduction $\hpP \hpEval \hpQ$ which only uses the rules \Rule{H-E-Link}, \Rule{H-E-Cong}, and \Rule{H-E-Equiv}.

Definition (β-Reduction) {#hcp-b-reduction}.
  ~ A process $\hpP$ β-reduces to $\hpQ$, written $\hpP \hpEvalB \hpQ$, if there exists a reduction $\hpP \hpEval \hpQ$ that does not use the rule \Rule{H-E-Link}.

I divide reduction into α-reduction, which captures link evaluating as α-renaming, and β-reduction, which captures all other reduction. In essence, α-reduction captures asynchronous reduction, and β-reduction captures synchronous reduction.

Canonical forms are defined, as described above, by the forms of processes that cannot α- or β-reduce. The definition does not require that terminated processes are normalised to $\hpZ$, e.g., $\hpZ\hpPar\hpZ$ is considered canonical. This simplifies the statement of progress, as we do not need to make allowances for processes such as $\hpZ\hpPar\hpZ$ that do not reduce, but are not exactly $\hpZ$, and lets us defer proving @lemma:hcp-hyper-consistency.
(The definition for canonical forms is adjusted to permit maximum configuration contexts with zero holes, i.e., the canonical forms of terminated processes.)

Definition (Canonical Form) {#hcp-canonical-form}.
  ~ A process $\hpP$ is in *canonical form*, written $\canonical(\hpP)$, if $\hpP\iotf\hpCC^n[\hpT_1,\hptm\dots,\hpT_n]$ (for some $n \geq 0$) and (for $1 \leq i, j \leq n$) and

    1.  no $\hpT_i$ is a link thread ready to act on an endpoint $\hpx\in\bn(\hpCC)$; and
    2.  no $\hpT_i$ and $\hpT_j$ are ready to act on dual endpoints $\{\hpx,\hpx'\}\in\dn(\hpCC)$.

    If condition (1) holds, $\hpP\hpEvalA/$.
    If condition (2) holds, $\hpP\hpEvalB/$.

If a process contains two processes ready to act on dual endpoints, then it can reduce. The following lemma abstracts over the reduction rules for HCP's many dual actions, and is unchanged from CP.

Lemma (Reduction) {#hcp-reduce-dual}.
  ~ If $\hpNew(\hpx\hpx')(\hpP\hpPar\hpQ)\hpSeq\hpHG$, and $\hpP$ and $\hpQ$ are ready to act on $\hpx$ and $\hpx'$, respectively, there exists some $\hpR$ such that $\hpNew(\hpx\hpx')(\hpP\hpPar\hpQ)\hpEval\hpR$.

```include
proofs/hcp-reduce-dual.md
```

Progress states that any process is either in canonical form or can reduce.
In essence, the proof shows that conditions (1) and (2) of the definition of canonical form correspond to the absence of α- and β-reduction.

Proposition (Progress) {#hcp-progress}.
  ~ If $\hpP\hpSeq\hpHG$,
    then either $\hpP$ is in canonical form, or
    there exists some $\hpQ$ such that $\hpP\hpEval\hpQ$.

```include
proofs/hcp-progress.md
```

<!--
Progress only requires *shallow* structural congruence.
We never need to rewrite a process that is under an action.
Therefore, we can refine the reduction as follows.

Definition {#hcp-eval-s}.
  ~ *Reduction up to shallow structural congruence* is the smallest relation on processes defined by the rules in @figure:hcp-eval with \Rule{H-E-Equiv} replaced by the following rule:
    $$
    \begin{RuleWithLabel}{H}{E-EquivS}[E-Equiv\textsubscript{S}]
      \AXC{$\hpP \hpEquivS \hpP'$}
      \AXC{$\hpP' \hpEvalS \hpQ'$}
      \AXC{$\hpQ' \hpEquivS \hpQ$}
      \TIC{$\hpP \hpEvalS \hpQ$}
      \DP
    \end{RuleWithLabel}
    $$

Reduction up to shallow structural congruence lets us show (1) that reduction can be decomposed into a reduction up to shallow structural congruence and a separate structural congruence, and (2) that reduction preserves structural congruence.

Proposition {#hcp-eval-s}.
  ~ If $\hpP\hpSeq\hpHG$, then:

    $\!\!\qquad%
    \begin{array}{l@{\ }l@{\;}r@{\;}l}
    \text{1.} & \hpP\hpEval\hpQ          & \implies & \hpP\hpEvalS\hpEquiv\hpQ
    \\
    \text{2.} & \hpP\hpEquiv\hpEvalS\hpQ & \iff     & \hpP\hpEvalS\hpEquiv\hpQ
    \end{array}$
-->
