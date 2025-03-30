# Separation {#cp-separation}

Separation relates configuration contexts and evaluation contexts---it 'zooms in', from viewing a process as a series of connected processes, to viewing two specific processes and the cut connecting them.
Separation also captures an essential property of CP's type system: dual endpoints must be in distinct processes, separated by a cut.

Lemma (Separation) {#cp-separation}.
  ~ If $\cpP\cpSeq\cpGG$, $\cpCC^n$ is a configuration context such that $\cpP=\cpCC^n\cptm[\cpP_1\cptm,\cptm\dots\cptm,\cpP_n\cptm]$ (for some $n \geq 2$), and there exists some $\{\cpx,\cpx'\}\in\dn(\cpCC)$ such that $\cpx\in\fn(\cpP_i)$ and $\cpx'\in\fn(\cpP_j)$ (for some $1 \leq i, j \leq n$), there exist $\cpEE$, $\cpEF_i$, and $\cpEF_j$ such that either

    1. $\cpP=\cpEE[\cpNew(\cpx\cpx')(\cpEF_i[\cpP_i]\cpPar\cpEF_j[\cpP_j])]$, or
    2. $\cpP=\cpEE[\cpNew(\cpx'\cpx)(\cpEF_j[\cpP_j]\cpPar\cpEF_i[\cpP_i])]$.

```include
proofs/cp-separation.md
```

The separation lemma is rather precise, and gives us one of two equalities. However, both cases are equivalent up to structural congruence.

Corollary (Separation) {#cp-separation}.
  ~ If $\cpP\cpSeq\cpGG$, $\cpCC^n$ is a configuration context such that $\cpP=\cpCC^n\cptm[\cpP_1\cptm,\cptm\dots\cptm,\cpP_n\cptm]$ (for some $n \geq 2$), and there exists some $\{\cpx,\cpx'\}\in\dn(\cpCC)$ such that $\cpx\in\fn(\cpP_i)$ and $\cpx'\in\fn(\cpP_j)$ (for some $1 \leq i, j \leq n$), there exist $\cpEE$, $\cpEF_i$, and $\cpEF_j$ such that $\cpP\cpEquivLPS\cpEE[\cpNew(\cpx\cpx')(\cpEF_i[\cpP_i]\cpPar\cpEF_j[\cpP_j])]$.

Proof.
  ~ By @lemma:cp-separation and \Rule{C-SC-CutComm}.

Evaluation contexts commute with cuts.

Lemma {#cp-evaluation-context-commute}.
  ~ If $\fn(\cpP)\cap\bn(\cpEE)=\emptyset$,
    then $\cpEE[\cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)]\cpEquivLPS\cpNew(\cpx\cpx')(\cpP\cpPar\cpEE[\cpQ])$.

Proof.
  ~ By induction on the structure of the evaluation context $\cpEE$.
