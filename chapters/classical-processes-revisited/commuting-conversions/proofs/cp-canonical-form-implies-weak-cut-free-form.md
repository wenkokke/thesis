Proof.
  ~ There are two cases:

    1.  If $\cpP$ is ready, it is in weak cut-free form.
    2.  Otherwise, we have
        $\cpP\cpEquiv\cpNew(\cpx_1\cpx'_1)(\cpP_1\cpPar\cptm\cdots\cpNew(\cpx_n\cpx'_n)(\cpP_n\cpPar\cpP_{n+1})\cptm\cdots)$
        such that (1) each $\cpP_i$ is ready; (2) no $\cpP_i$ is a link; and (3) no $\cpP_i$ and $\cpP_j$ are ready to act on dual endpoints of the same channel.

        At least one process $\cpP_i$ is ready to act on a free endpoint: There are $n$ pairs of dual endpoints ($\cpx_1$, $\cpx'_1$, ..., $\cpx_n$, $\cpx'_n$) and $n+1$ processes ($\cpP_1$, ..., $\cpP_{n+1}$). By (1), each process $\cpP_i$ is ready. If all $n+1$ processes $\cpP_1$, ..., $\cpP_{n+1}$ are ready to act on endpoints from the bound channels $\cpx_1$, $\cpx'_1$, ..., $\cpx_n$, $\cpx'_n$, at least two processes must be ready to act on dual endpoints, which contradicts (3).

        By (2), the process ready to act on a free endpoint cannot be a link.
        Therefore, we can use the commuting conversion to propagate that action to the top, and get the reduction $\cpP\cpEvalCC*\cpP'$ such that $\cpP'$ is in weak cut-free form.
