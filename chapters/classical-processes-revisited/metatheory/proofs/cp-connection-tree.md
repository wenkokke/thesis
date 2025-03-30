Proof.
  ~ By induction on the structure of $\cpCC$ and inversion on the structure of $\cpP$ and the derivation of $\cpP\cpSeq\cpGG$.

    There are two cases:

    - Case $\cpCC$ is of the form $\cpNew(\cpx\cpx')(\cpCC_1\cpPar\cpCC_2)$.

      By inversion, the typing derivation is of the form
      $$
      \cpCUT*{\cpx}{\cpx'}{\cpQ}{\cpR}{\cpGG}{\cpGD}\cpA
      \DP
      $$
      The process $\cpP$ is of the form $\cpNew(\cpx\cpx')(\cpQ\cpPar\cpR)$.

      By \Rule{C-T-Cut}, $\fn(\cpQ)$ and $\fn(\cpR)$ as well as $\connection(\cpQ)$ and $\connection(\cpR)$ are disjoint.

      By induction, $\connection(\cpQ)$ and $\connection(\cpR)$ are trees.

      The vertices of $\connection(\cpP)$ are exactly the union of those of $\connection(\cpQ)$ and $\connection(\cpR)$.
      Furthermore, the unordered pair $\{\cpx,\cpx'\}$ is the only element of $\dn(\cpCC)$ that is not present in $\dn(\cpCC_1)$ or $\dn(\cpCC_1)$.
      By @proposition:cp-linearity, there is exactly one $\cpT_i\in\vertices[\connection(\cpQ)]$ and one $\cpT_j\in\vertices[\connection(\cpR)]$ such that $\cpx\in\fn(\cpT_i)$ and $\cpx'\in\fn(\cpT_j)$.
      Therefore,
      $$
      \begin{array}{l@{\;=\;}l}
      \vertices[\connection(\cpP)]
      &
      \vertices[\connection(\cpQ)]
      \cup
      \vertices[\connection(\cpR)]
      \\
      \edgeLabelling[\connection(\cpP)]
      &
      \{
        \edge{\cpT_i}{\cpT_j}
        \mapsto
        (\cpx,\cpx')
      \}
      \cup
      \edgeLabelling[\connection(\cpQ)]
      \cup
      \edgeLabelling[\connection(\cpR)]
      \end{array}
      $$
      The result follows, as $\connection(\cpP)$ is formed by connecting trees $\connection(\cpQ)$ and $\connection(\cpR)$ with the single edge $\edge{\cpT_i}{\cpT_j}$, and connecting two trees with a single edge always yields another tree.

    - Case $\cpCC$ is of the form $\cpHole$.

      The result follows, as $\connection(\cpP)$ is the singleton graph, which is a tree.
