# Separation {#hcp-separation}

Separation relates configuration contexts and evaluation contexts---it 'zooms in', from viewing a process as a series of connected processes, to viewing two specific processes and the cut connecting them.
Separation also captures an essential property of HCP's type system: dual endpoints must be in distinct processes, separated by a parallel composition.

Whereas CP has one separation lemma, HCP has two. One for parallel composition, and one for name restriction.

Lemma {#hcp-separation-par}.
  ~ If $\hpP\hpSeq\hpHG\hpHTens\hpGG,\hpx:\hpA\hpHTens\hpGD,\hpx':\co\hpA$,
    $\hpCC^n$ is a configuration context such that $\hpP=\hpCC^n[\hpP_1,\hptm\dots,\hpP_n]$ (for some $n \geq 2$), and there exists some $\{\hpx,\hpx'\}\in\fn(\hpP)$ such that $\hpx\in\fn(\hpP_i)$ and $\hpx'\in\fn(\hpP_j)$ (for some $1 \leq i, j \leq n$), there exist $\hpEE$, $\hpEF_i$, and $\hpEF_j$ such that

    1. $\hpP=\hpEE[\hpEF_i[\hpP_i]\hpPar\hpEF_j[\hpP_j]]$, or
    2. $\hpP=\hpEE[\hpEF_j[\hpP_j]\hpPar\hpEF_i[\hpP_i]]$.

```include
proofs/hcp-separation-par.md
```

Lemma (Separation) {#hcp-separation}.
  ~ If $\hpP\hpSeq\hpHG$, and $\hpCC^n$ is a configuration context such that $\hpP=\hpCC^n[\hpP_1,\hptm\dots,\hpP_n]$ (for some $n \geq 2$), and there exists some $\{\hpx,\hpx'\}\in\dn(\hpCC)$ such that $\hpx\in\fn(\hpP_i)$ and $\hpx'\in\fn(\hpP_j)$ (for some $1 \leq i, j \leq n$), there exist $\hpEE_1$, $\hpEE_2$, $\hpEF_i$, and $\hpEF_j$ such that either

    1. $\hpP=\hpEE_1[\hpNew(\hpx\hpx')(\hpEE_2[\hpEF_i[\hpP_i]\hpPar\hpEF_j[\hpP_j]])]$,
    2. $\hpP=\hpEE_1[\hpNew(\hpx'\hpx)(\hpEE_2[\hpEF_i[\hpP_i]\hpPar\hpEF_j[\hpP_j]])]$,
    3. $\hpP=\hpEE_1[\hpNew(\hpx\hpx')(\hpEE_2[\hpEF_j[\hpP_j]\hpPar\hpEF_i[\hpP_i]])]$, or
    4. $\hpP=\hpEE_1[\hpNew(\hpx'\hpx)(\hpEE_2[\hpEF_j[\hpP_j]\hpPar\hpEF_i[\hpP_i]])]$.

```include
proofs/hcp-separation.md
```

The separation lemma is rather precise, and gives us one of four equalities. However, all cases are equivalent up to structural congruence. Usually, it is easier to forget the exact case.

Corollary (Separation) {#hcp-separation}.
  ~ If $\hpP\hpSeq\hpHG$, $\hpCC^n$ is a configuration context such that $\hpP=\hpCC^n[\hpP_1,\hptm\dots,\hpP_n]$ (for some $n \geq 2$), and there exists some $\{\hpx,\hpx'\}\in\dn(\hpCC)$ such that $\hpx\in\fn(\hpP_i)$ and $\hpx'\in\fn(\hpP_j)$ (for some $1 \leq i, j \leq n$), there exist $\hpEE_1$, $\hpEE_2$, $\hpEF_i$, and $\hpEF_j$ such that $\hpP\hpEquivLPS\hpEE_1[\hpNew(\hpx\hpx')(\hpEE_2[\hpEF_i[\hpP_i]\hpPar\hpEF_j[\hpP_j]])]$.

Proof.
  ~ By @lemma:hcp-separation, \Rule{H-SC-NewComm}, and \Rule{H-SC-ParComm}.

Evaluation contexts commute with name restriction and parallel composition.

Lemma {#hcp-evaluation-context-commute-new}.
  ~ If $\hpx,\hpx'\notin\fn(\hpEE)\cup\bn(\hpEE)$,
    then $\hpEE[\hpNew(\hpx\hpx')\hpP]\hpEquivLPS\hpNew(\hpx\hpx')(\hpEE[\hpP])$.

```include
proofs/hcp-evaluation-context-commute-new.md
```

Lemma {#hcp-evaluation-context-commute-par}.
  ~ If $\fn(\hpP)\cap\bn(\hpEE)=\emptyset$,
    then $\hpEE[\hpP\hpPar\hpQ]\hpEquivLPS\hpP\hpPar\hpEE[\hpQ]$.

```include
proofs/hcp-evaluation-context-commute-par.md
```

Corollary {#hcp-evaluation-context-commute-nil}.
  ~ If $\fn(\hpP)\cap\bn(\hpEE)=\emptyset$,
    then $\hpEE[\hpP]\hpEquivLPS\hpEE[\hpZ]\hpPar\hpP$.

```include
proofs/hcp-evaluation-context-commute-nil.md
```
