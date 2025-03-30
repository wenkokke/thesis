# Preservation {#cp-preservation}

Structural congruences preserve typing. If some process $\cpP$ is well-typed and is equivalent to some process $\cpQ$ under structural congruence, then $\cpQ$ is well-typed under the same typing environment.

Lemma {#cp-preservation-equiv}.
  ~ If $\cpP\cpEquiv\cpQ$,
    then $\cpP\cpSeq\cpGG$ if and only if $\cpQ\cpSeq\cpGG$.

```include
proofs/cp-preservation-equiv.md
```

Renaming preserves typing. If a process is well-typed, then renaming any free endpoint does not affect its typing.

Lemma {#cp-preservation-subst}.
  ~ If $\cpP\cpSeq\cpGG,\cpx:\cpA$,
    then $\cpP\cpSubst\cpw\cpx\cpSeq\cpGG,\cpw:\cpA$.

```include
proofs/cp-preservation-subst.md
```

Plugging with any form of process context preserves typing.

Lemma {#cp-process-context-preservation}.
  ~ If $\cpCP^n\cpSeq\cpGG_1\mid\dots\mid\cpGG_n\cpSeqTo\cpGG$ and $\cpQ_i\cpSeq\cpGG_i$ (for $1 \leq i \leq n$), then $\cpCP^n[\cpQ_1,\cptm\ldots,\cpQ_n]\cpSeq\cpGG$.

```include
proofs/cp-process-context-preservation.md
```

Reduction preserves typing. If a process $\cpP$ is well-typed and reduces to some other process $\cpQ$, then $\cpQ$ is well-typed under the same typing environment.

Proposition (Preservation) {#cp-preservation}.
  ~ If $\cpP\cpSeq\cpGG$ and $\cpP\cpEval\cpQ$,
    then $\cpQ\cpSeq\cpGG$.

```include
proofs/cp-preservation.md
```
