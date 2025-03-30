Proof.
  ~ There are two cases:

    - Case $(\Rightarrow)$.

      By contradiction.
      Assume
        $\hpx\in\blocking(\hpP)$ and
        $\nexists\hpa\in\fn(\hpP).\hpx \dual[\hpP] \hpa$.

      There are two cases:

      - If $\hpx\in\fn(\hpP)$, then $\hpx \dual[\hpP] \hpx$.
      - The process $\hpP=\hpCC^n[\hpT_1,\hptm\dots,\hpT_n]$ (for some $n \geq 0$).

        If $\hpx\in\bn(\hpCC)$, then there exists some $\{\hpx,\hpx'\}\in\dn(\hpCC)$.

        There are two cases:

        - If $\hpx'\in\blocking(\hpP)$, there exist processes $\hpT_i$ and $\hpT_j$ that are ready to act on dual endpoints.
          By @lemma:hcp-reduce-dual, $\hpP$ is not β-free.
        - If $\hpx'\notin\blocking(\hpP)$, there exists some $\hpy$ such that $\hpx' \depends[\hpP] \hpy$.
          By definition, $\edge{\hpx}{\hpx'}\in\edges[\dependency(\hpP)]$.
          Hence, $\hpx \depends[\hpP] \hpy$ and $\hpx\notin\blocking(\hpP)$.

    - Case $(\Leftarrow)$.

      By contradiction.

      Assume $\hpP\hpEvalB$.
      By inversion, there exist some $\hpT_i$ and $\hpT_j$ (for $1 \leq i,j \leq n$) that are ready to act on dual endpoints $\hpx$ and $\hpx'$.

      By definition, $\hpx$ and $\hpx'$ only have outgoing arcs in $\dependency(\hpP)$, and the only edge connected to either is $\edge{\hpx}{\hpx'}$.
      Hence, $\{\hpx,\hpx'\}\subseteq\blocking(\hpP)$ and $\nexists\hpa\in\fn(\hpP).\hpx \dual[\hpP] \hpa \lor \hpx' \dual[\hpP] \hpa$.
