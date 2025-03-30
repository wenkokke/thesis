Proof.
  ~ By contradiction.
    We have $\cpP\iotf\cpCC^n[\cpT_1\cptm,\cptm\dots\cptm,\cpT_n]$ (for some $n \geq 1$).
    Assume no thread $\cpT_i$ is ready to act on a free endpoint.
    Then all $n$ threads $\cpT_1$, ..., $\cpT_n$ must be ready to act on bound endpoints.
    By linearity, all $n$ threads $\cpT_1$, ..., $\cpT_n$ must act on distinct bound endpoints.
    By @lemma:cp-configuration-context-bound-name-count, $\cpCC^n$ binds $2(n-1)$ endpoints in $n-1$ dual pairs, so any subset of $n$ bound endpoints must contain at least one dual pair.
    Therefore, at least two threads must be ready to act on dual endpoints, which contradicts the premise that $\cpP$ is in canonical form.
