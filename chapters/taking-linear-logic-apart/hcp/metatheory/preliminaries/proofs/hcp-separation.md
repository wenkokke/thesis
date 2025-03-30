Proof.
  ~ By induction on the structure of $\hpCC$, followed by inversion on $\hpP$ and the corresponding typing derivation.

    There are two cases:

    - Case $\hpCC^n$ is of the form $\hpNew(\hpy\hpy')\hpCC^n$ (reusing $\hpCC$).

      By inversion, $\hpP=\hpNew(\hpy\hpy')(\hpCD^n_1[\hpP_i,\hptm\dots,\hpP_n])$.

      There are three subcases:

      - Subcase $\hpx=\hpy$ and $\hpx'=\hpy'$.

        By @lemma:hcp-separation-par, there exist $\hpEE$, $\hpEF_i$, and $\hpEF_j$ such that:

        a. $\hpP=\hpEE[\hpEF_i[\hpP_i]\hpPar\hpEF_j[\hpP_j]]$, or
        b. $\hpP=\hpEE[\hpEF_j[\hpP_j]\hpPar\hpEF_i[\hpP_i]]$.

        Let $\hpEE_1=\hpHole$ and $\hpEE_2=\hpEE$.

        In case (a), the result follows as case (1).

        In case (b), the result follows as case (3).

      - Subcase $\hpx=\hpy'$ and $\hpx'=\hpy$.

        By @lemma:hcp-separation-par, there exist $\hpEE$, $\hpEF_i$, and $\hpEF_j$ such that:

        a. $\hpP=\hpEE[\hpEF_i[\hpP_i]\hpPar\hpEF_j[\hpP_j]]$, or
        b. $\hpP=\hpEE[\hpEF_j[\hpP_j]\hpPar\hpEF_i[\hpP_i]]$.

        Let $\hpEE_1=\hpHole$ and $\hpEE_2=\hpEE$.

        In case (a), the result follows as case (2).

        In case (b), the result follows as case (4).

      - Subcase $\{\hpx,\hpx'\}\in\dn(\hpCC)$.

        By induction on $\hpCC$, there exist $\hpEE_1$, $\hpEE_2$, $\hpEF_i$, and $\hpEF_j$ such that (1) or (2).
        The result follows by prepending $\hpNew(\hpy\hpy')\hpHole$ to $\hpEE_1$.

    - Case $\hpCC^n$ is of the form $\hpCD^n_1\hpPar\hpCD^k_2$ (reusing $n$).

      By inversion, $\hpP=\hpCD^n_1[\hpP_i,\hptm\dots,\hpP_n]\hpPar\hpCD^k_2[\hpP_{n+1},\hptm\dots,\hpP_k]$.
      By inversion on the fact that $\{\hpx,\hpx'\}\in\dn(\hpCC)$, $\hpP_i$ and $\hpP_j$ must be on the same side of the parallel composition.
      There are two subcases:

      - Subcase $1 \leq i,j \leq n$.

        By induction on $\hpCD^n_1$, there exist $\hpEE_1$, $\hpEE_2$, $\hpEF_i$, and $\hpEF_j$ such that (1) or (2).
        The result follows by prepending $\hpHole\hpPar\hpCD^k_2[\hpP_{n+1},\hptm\dots,\hpP_k]$ to $\hpEE_1$.

      - Subcase $n < i,j \leq k$.

        By induction on $\hpCD^k_2$, there exist $\hpEE_1$, $\hpEE_2$, $\hpEF_i$, and $\hpEF_j$ such that (1) or (2).
        The result follows by prepending $\hpCD^n_1[\hpP_i,\hptm\dots,\hpP_n]\hpPar\hpHole$ to $\hpEE_1$.
