Proof.
  ~ The process $\hpP\iotf\hpCC^n[\hpT_1,\hptm\dots,\hpT_n]$ (for some $n \geq 0$).

    If $\hpP$ is in canonical form, the result follows.

    Otherwise, $n \geq 2$, and there are two cases:

    Condition (1) does not hold.
    Some $\hpT_i$ (for $1 \leq i \leq n$) is a link thread ready to act on an endpoint $\hpx\in\bn(\hpCC)$.
    By \Rule{H-SC-LinkComm}, $\hpT_i\hpEquivS\hpLink\hpx\hpy$.
    By definition, there exists some $\{\hpx,\hpx'\}\in\dn(\hpCC)$.
    By @corollary:hcp-separation and @proposition:hcp-linearity, there exists some $\hpT_j$ (for $1 \leq j \leq n$ and $i \neq j$) such that $\hpx'\in\fn(\hpT_j)$.

    $\!\!%
    \begin{array}{lrll}
    \hpP
    & \hpEquivS
    & \hpEE_1[\hpNew(\hpx\hpx')(\hpEE_2[\hpEF_1[\hpLink\hpx\hpy]\hpPar\hpEF_2[\hpT_j]])]
    & \langle
      \text{by \cref{corollary:hcp-separation} and \Rule{H-SC-LinkComm}}
      \rangle
    \\
    & \hpEquivS
    & \hpEE_1[\hpEE_2[\hpNew(\hpx\hpx')(\hpEF_1[\hpLink\hpx\hpy]\hpPar\hpEF_2[\hpT_j])]]
    & \langle
      \text{by \cref{lemma:hcp-evaluation-context-commute-new}}
      \rangle
    \\
    & \hpEquivS
    & \hpEE_1[\hpEE_2[\hpEF_1[\hpNew(\hpx\hpx')(\hpLink\hpx\hpy\hpPar\hpEF_2[\hpT_j])]]]
    & \langle
      \text{by \cref{lemma:hcp-evaluation-context-commute-par}}
      \rangle
    \\
    & \hpEquivS
    & \hpEE_1[\hpEE_2[\hpEF_1[\hpEF_2[\hpNew(\hpx\hpx')(\hpLink\hpx\hpy\hpPar\hpT_j)]]]]
    & \langle
      \text{by \cref{lemma:hcp-evaluation-context-commute-par}}
      \rangle
    \\
    & \hpEval
    & \hpEE_1[\hpEE_2[\hpEF_1[\hpEF_2[\hpT_j\hpSubst\hpy{\hpx'}]]]]
    & \langle
      \text{by \Rule{C-E-Link} and \Rule{C-E-Cong}}
      \rangle
    \end{array}$

    Condition (2) does not hold.
    Some $\hpT_i$ and $\hpT_j$ (for $1 \leq i, j \leq n$) are ready to act on dual endpoints $\{\hpx,\hpx'\}\in\dn(\hpCC)$.

    $\!\!%
    \begin{array}{lrll}
    \hpP
    & \hpEquivS
    & \hpEE_1[\hpNew(\hpx\hpx')(\hpEE_2[\hpEF_i[\hpT_i]\hpPar\hpEF_j[\hpT_j]])]
    & \langle
      \text{by \cref{corollary:hcp-separation}}
      \rangle
    \\
    & \hpEquivS
    & \hpEE_1[\hpEE_2[\hpNew(\hpx\hpx')(\hpEF_i[\hpT_i]\hpPar\hpEF_j[\hpT_j])]]
    & \langle
      \text{by \cref{lemma:hcp-evaluation-context-commute-new}}
      \rangle
    \\
    & \hpEquivS
    & \hpEE_1[\hpEE_2[\hpEF_i[\hpNew(\hpx\hpx')(\hpT_i\hpPar\hpEF_j[\hpT_j])]]]
    & \langle
      \text{by \cref{lemma:hcp-evaluation-context-commute-par}}
      \rangle
    \\
    & \hpEquivS
    & \hpEE_1[\hpEE_2[\hpEF_i[\hpEF_j[\hpNew(\hpx\hpx')(\hpT_i\hpPar\hpT_j)]]]]
    & \langle
      \text{by \cref{lemma:hcp-evaluation-context-commute-par}}
      \rangle
    \\
    & \hpEval
    & \hpEE_1[\hpEE_2[\hpEF_i[\hpEF_j[\hpR]]]]
    & \langle
      \text{by \cref{lemma:hcp-reduce-dual} and \Rule{C-E-Cong}}
      \rangle
    \end{array}$
