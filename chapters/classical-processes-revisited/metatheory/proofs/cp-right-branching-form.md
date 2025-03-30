Proof.
  ~ By @proposition:cp-connection-tree, $\connection(\cpP)$ is a tree.
    Let $\cpT_i$ be any leaf of $\connection(\cpP)$ (for $1 \leq i \leq \card{\vertices[\connection(\cpP)]}$).
    As $\cpT_i$ is a leaf, exactly one free endpoint in $\cpT_i$ is bound in $\cpP$.
    Let us name that endpoint $\cpx$.
    There exist some $\cpEE$, $\cpEF$, and $\cpP'$ such that:
    $$
    \begin{array}{l@{\;\cpEquivLPS\;}ll}
    \cpP
    &
    \cpEE[
      \cpNew(\cpx\cpx')(
        \cpEF[\cpT_i]
        \cpPar
        \cpP'
      )
    ]
    &
    \langle\text{by~\cref{corollary:cp-separation}}\rangle
    \\
    &
    \cpEE[\cpEF[
      \cpNew(\cpx\cpx')(
        \cpT_i
        \cpPar
        \cpP'
      )
    ]]
    &
    \langle\text{by~\cref{lemma:cp-evaluation-context-commute} and \Rule{C-SC-CutComm}}\rangle
    \\
    &
    \cpNew(\cpx\cpx')(
      \cpT_i
      \cpPar
      \cpEE[\cpEF[\cpP']]
    )
    &
    \langle\text{by Lemma~\ref{lemma:cp-evaluation-context-commute}}\rangle
  \end{array}
    $$
    By @lemma:cp-preservation-equiv, $\cpEE[\cpEF[\cpP']]$ is well-typed.
    By induction on the process $\cpEE[\cpEF[\cpP']]$, there exists some $\cpQ'$ such that $\cpEE[\cpEF[\cpP']]\cpEquivLPS\cpQ'$ and $\cpQ'$ is in right-branching form.
    Let $\cpQ$ be $\cpNew(\cpx\cpx')(\cpT_i\cpPar\cpQ')$.
    The result follows, as $\cpP\cpEquivLPS\cpQ$ and $\cpQ$ is in right-branching form.
