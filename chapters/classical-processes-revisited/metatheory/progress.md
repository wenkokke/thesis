# Progress {#cp-progress}

What should the canonical forms be for processes in CP?
The usual starting point would be to ask what the canonical forms are for *closed* processes. For instance, in the λ-calculus, a closed process of the function type must be a lambda, and in the π-calculus, a closed process must be equivalent to the terminated process.
Alas, that question is meaningless for CP, which *has no closed processes*.
Any closed process would correspond to a proof of the empty sequent, which is not provable in CLL.
A CP process is never *done*. There is no terminated process. There are only processes that are temporarily stuck, blocked on a free endpoint---one endpoint of a channel whose other endpoint has not yet been connected.
Unfortunately, it is not sufficient to simply require that the process contains an action on a free endpoint. For instance, the process
$$
\cpNew(\cpx\cpx')(
  \cpWait\cpa.\cpP\cpPar
    \cpNew(\cpy\cpy')(
      \cpClose\cpy.0\cpPar\cpWait{\cpy'}.\cpQ))
$$
has an action that is blocked on an external channel, but it can still reduce.
Hence, the definition of canonical form should also capture the fact that no further reduction rules can be applied.
Unsurprisingly, that condition is in and of itself sufficient, so let us formalise it as a starting point.

The simplest and most useless definition would be to say that $\cpP$ is in canonical form if and only if $\cpP\cpEval/$.
However, it would be more satisfying if we could characterise the conditions under which no reduction rules apply.

First, note that \Rule{C-E-Link} acts differently from most reduction rules.
Most reduction rules, i.e., \Rule{C-E-Send}, \Rule{C-E-Close}, \Rule{C-E-Select1}, and \Rule{C-E-Select2}, are synchronous interactions between two processes and are blocked unless both processes are ready to act on dual endpoints.
However, link is *asynchronous*. Any ready link can evaluate to a renaming in the process it communicates with, regardless of whether that process is ready to act on the relevant channel.

To capture this difference, I divide reduction into α-reduction, which captures link evaluating as α-renaming, and β-reduction, which captures all other reduction. In essence, α-reduction captures asynchronous reduction, and β-reduction captures synchronous reduction.

Definition (α-Reduction) {#cp-a-reduction}.
  ~ A process $\cpP$ α-reduces to $\cpQ$, written $\cpP \cpEvalA \cpQ$, if there exists a reduction $\cpP \cpEval \cpQ$ which only uses the rules \Rule{C-E-Link}, \Rule{C-E-Cong}, and \Rule{C-E-Equiv}.

Definition (β-Reduction) {#cp-b-reduction}.
  ~ A process $\cpP$ β-reduces to $\cpQ$, written $\cpP \cpEvalB \cpQ$, if there exists a reduction $\cpP \cpEval \cpQ$ that does not use the rule \Rule{C-E-Link}.

Any reduction is either an α-reduction or a β-reduction.

I could say that $\cpP$ is in canonical form if and only if $\cpP\cpEvalA/$ and $\cpP\cpEvalB/$.
However, I have already given a tighter characterisation above.
A process $\cpP$ is in canonical form if and only if

  1.  $\cpP$ contains no link thread ready to act on a bound endpoint; and
  2.  $\cpP$ contains no two threads ready to act on dual endpoints.

If (1) does not hold, \Rule{C-E-Link} applies, and if (2) does not hold, at least one of the other reduction rules applies... *and that is progress in a nutshell!*

Definition (Canonical Form) {#cp-canonical-form}.
  ~ A process $\cpP$ is in *canonical form*, written $\canonical(\cpP)$, if $\cpP$ is of the form $\cpCC^n[\cpT_1\cptm,\cptm\dots\cptm,\cpT_n]$ (for some $n \geq 1$) and (for $1 \leq i, j \leq n$)

    1.  no $\cpT_i$ is a link thread ready to act on an endpoint $\cpx\in\bn(\cpCC)$; and
    2.  no $\cpT_i$ and $\cpT_j$ are ready to act on dual endpoints $\{\cpx,\cpx'\}\in\dn(\cpCC)$.

    If condition (1) holds, $\cpP\cpEvalA/$.
    If condition (2) holds, $\cpP\cpEvalB/$.

If a process contains two threads ready to act on dual endpoints, then it can reduce. The following lemma abstracts over the reduction rules for CP's many dual actions.

Lemma (Reduction) {#cp-reduce-dual}.
  ~ If $\cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)\cpSeq\cpGG$, and $\cpP$ and $\cpQ$ are ready to act on $\cpx$ and $\cpx'$, respectively, there exists some $\cpR$ such that $\cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)\cpEval\cpR$.

```include
proofs/cp-reduce-dual.md
```

Progress states that any process is either in canonical form or can reduce.
In essence, the proof shows that conditions (1) and (2) of the definition of canonical form correspond to the absence of α- and β-reduction.

Proposition (Progress) {#cp-progress}.
  ~ If $\cpP\cpSeq\cpGG$, then either $\cpP$ is in canonical form, or there exists some $\cpQ$ such that $\cpP\cpEval\cpQ$.

```include
proofs/cp-progress.md
```
