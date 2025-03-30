Proof.
  ~ Let $\cpP$ be of the form $\cpCC^n[\cpT_1\cptm,\cptm\dots\cptm,\cpT_n]$ (for some $n \geq 1$).

    There are two cases:

    - Case $(\Rightarrow)$.

      By contradiction.
      Assume
        $\cpx\in\blocking(\cpP)$ and
        $\nexists\cpa\in\fn(\cpP).\cpx \dual[\cpP] \cpa$.

      There are two cases:

      - If $\cpx\in\fn(\cpP)$, then $\cpx \dual[\cpP] \cpx$.
      - If $\cpx\in\bn(\cpCC)$, then there exists some $\{\cpx,\cpx'\}\in\dn(\cpCC)$.

        There are two cases:

        - If $\cpx'\in\blocking(\cpP)$, then there exist threads $\cpT_i$ and $\cpT_j$ that are ready to act on dual endpoints $\{\cpx,\cpx'\}\in\dn(\cpCC)$.
          By @lemma:cp-reduce-dual, $\cpP$ is not β-free.
        - If $\cpx'\notin\blocking(\cpP)$, then there exists some $\cpy$ such that $\cpx' \depends[\cpP] \cpy$.
          By definition, $\edge{\cpx}{\cpx'}\in\edges[\dependency(\cpP)]$.
          Therefore, $\cpx \depends[\cpP] \cpy$ and $\cpx\notin\blocking(\cpP)$.

    - Case $(\Leftarrow)$.

      By contradiction.
      Assume $\cpP\cpEvalB$.

      By inversion, there exist some $\cpT_i$ and $\cpT_j$ (for $1 \leq i,j \leq n$) that are ready to act on dual endpoints $\cpx$ and $\cpx'$.

      By definition, $\cpx$ and $\cpx'$ only have outgoing arcs in $\dependency(\cpP)$, and the only edge connected to either is $\edge{\cpx}{\cpx'}$.
      Therefore, $\{\cpx,\cpx'\}\subseteq\blocking(\cpP)$ and $\nexists\cpa\in\fn(\cpP).\cpx \dual[\cpP] \cpa \lor \cpx' \dual[\cpP] \cpa$.
