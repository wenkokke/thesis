Proof.
  ~ $\cpP$ is of the form $\cpCC^n[\cpT_1\cptm,\cptm\dots\cptm,\cpT_n]$ (for some $n \geq 1$).

    If $\cpP$ is in canonical form, the result follows.

    Otherwise, $n \geq 2$, and there are two cases:

    Condition (1) does not hold.
    Some $\cpT_i$ (for $1 \leq i \leq n$) is a link thread ready to act on an endpoint $\cpx\in\bn(\cpCC)$.
    By definition, there exists some $\{\cpx,\cpx'\}\in\dn(\cpCC)$.
    By @corollary:cp-separation and @proposition:cp-linearity, there exists some $\cpP_j$ (for $1 \leq j \leq n$ and $i \neq j$) such that $\cpx'\in\fn(\cpP_j)$.

    $\!\!%
    \begin{array}{lrll}
    \cpP
    & \cpEquivS
    & \cpEE[\cpNew(\cpx\cpx')(\cpEF_1[\cpLink\cpx\cpy]\cpPar\cpEF_2[\cpP_j])]
    & \langle
      \text{by~\cref{corollary:cp-separation} and \Rule{C-SC-LinkComm}}
      \rangle
    \\
    & \cpEquivS
    & \cpEE[\cpEF_1[\cpNew(\cpx\cpx')(\cpLink\cpx\cpy\cpPar\cpEF_2[\cpP_j])]]
    & \langle
      \text{by \cref{lemma:cp-evaluation-context-commute}}
      \rangle
    \\
    & \cpEquivS
    & \cpEE[\cpEF_1[\cpEF_2[\cpNew(\cpx\cpx')(\cpLink\cpx\cpy\cpPar\cpP_j)]]]
    & \langle
      \text{by \cref{lemma:cp-evaluation-context-commute}}
      \rangle
    \\
    & \cpEval
    & \cpEE[\cpEF_1[\cpEF_2[\cpP_j\cpSubst\cpy{\cpx'}]]]
    & \langle
      \text{by \Rule{C-E-Link} and \Rule{C-E-Cong}}
      \rangle
    \end{array}$

    Condition (2) does not hold.
    Some threads $\cpT_i$ and $\cpT_j$ (for $1 \leq i, j \leq n$) are ready to act on dual endpoints $\{\cpx,\cpx'\}\in\dn(\cpCC)$.

    $\!\!%
    \begin{array}{lrll}
      \cpP
      & \cpEquivS
      & \cpEE[
          \cpNew(\cpx\cpx')(
            \cpEF_i[\cpT_i]\cpPar\cpEF_j[\cpT_j])]
      & \langle
        \text{by \cref{corollary:cp-separation}}
        \rangle
      \\
      & \cpEquivS
      & \cpEE[\cpEF_i[
          \cpNew(\cpx\cpx')(\cpT_i\cpPar
            \cpEF_j[\cpT_j])]]
      & \langle
        \text{by \cref{lemma:cp-evaluation-context-commute}}
        \rangle
      \\
      & \cpEquivS
      & \cpEE[\cpEF_i[\cpEF_j[
          \cpNew(\cpx\cpx')(\cpT_i\cpPar\cpT_j)
          ]]]
      & \langle
        \text{by \cref{lemma:cp-evaluation-context-commute}}
        \rangle
      \\
      & \cpEval
      & \cpEE[\cpEF_i[\cpEF_j[\cpR]]]
      & \langle
        \text{by \cref{lemma:cp-reduce-dual} and \Rule{C-E-Cong}}
        \rangle
    \end{array}$
