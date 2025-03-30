# Preservation {#hcp-preservation}

Structural congruence preserves typing. If some process $\hpP$ is well-typed and is equivalent to some process $\hpQ$ under structural congruence, then $\hpQ$ is well-typed under the same typing environment.

Lemma {#hcp-preservation-equiv}.
  ~ If $\hpP\hpEquiv\hpQ$,
    then $\hpP\hpSeq\hpHG$ if and only if $\hpQ\hpSeq\hpHG$.

```include
proofs/hcp-preservation-equiv.md
```

Renaming preserves typing. If a process is well-typed, then renaming any free endpoint does not affect its typing.

Lemma {#hcp-preservation-subst}.
  ~ If $\hpP\hpSeq\hpHG\hpHTens\hpGG,\hpx:\hpA$,
    then $\hpP\hpSubst\hpw\hpx\hpSeq\hpHG\hpHTens\hpGG,\hpw:\hpA$.

```include
proofs/hcp-preservation-subst.md
```

Plugging with any form of process context preserves typing.

Lemma {#hcp-process-context-preservation}.
  ~ If $\hpCP^n\hpSeq\hpHG_1\mid\dots\mid\hpHG_n\hpSeqTo\hpHG$ and $\hpP_i\hpSeq\hpHG_i$ (for $1 \leq i \leq n$), $\hpCP^n[\hpP_1,\hptm\ldots,\hpP_n]\hpSeq\hpHG$.

```include
proofs/hcp-process-context-preservation.md
```


Reduction preserves typing. If a process $\hpP$ is well-typed and reduces to some other process $\hpQ$, then $\hpQ$ is well-typed under the same typing environment.

Proposition (Preservation) {#hcp-preservation}.
  ~ If $\hpP\hpSeq\hpHG$ and $\hpP\hpEval\hpQ$,
    then $\hpQ\hpSeq\hpHG$.

```include
proofs/hcp-preservation.md
```
