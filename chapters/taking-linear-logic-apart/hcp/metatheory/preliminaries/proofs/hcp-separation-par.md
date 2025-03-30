Proof.
  ~ By induction on the structure of $\hpCC$, followed by inversion on $\hpP$ and the corresponding typing derivation.

    There are two cases:

    - Case $\hpCC^n$ is of the form $\hpNew(\hpy\hpy')\hpCC$ (reusing $\hpCC$).

      By the induction on $\hpCC$, there exist $\hpEE$, $\hpEF_i$, and $\hpEF_j$ such that (1) or (2).
      The result follows by prepending $\hpNew(\hpy\hpy')\hpHole$ to $\hpEE$.

    - Case $\hpCC^n$ is of the form $\hpCD^n_1\hpPar\hpCD^m_2$ (reusing $n$).

      By inversion, $\hpP=\hpCD^n_1[\hpP_1,\hptm\dots,\hpP_n]\hpPar\hpCD^m_2[\hpP_{n+1},\hptm\dots,\hpP_{n+m}]$.
      There are four subcases, depending on whether $\hpP_i$ and $\hpP_j$ are on the same or different sides of the parallel composition.

      - Subcase $1 \leq i,j \leq n$.

        By induction on $\hpCD^n_1$, there exist $\hpEE$, $\hpEF_i$, and $\hpEF_j$ such that (1) or (2).
        The result follows by prepending $\hpHole\hpPar\hpCD^m_2[\hpP_{n+1},\hptm\dots,\hpP_{n+m}]$ to $\hpEE$.

      - Subcase $n < i,j \leq m$.

        By induction on $\hpCD^m_2$, there exist $\hpEE$, $\hpEF_i$, and $\hpEF_j$ such that (1) or (2).
        The result follows by prepending $\hpCD^n_1[\hpP_1,\hptm\dots,\hpP_n]\hpPar\hpHole$ to $\hpEE$.

      - Subcase $1 \leq i \leq n < j \leq m$.

        Let $\hpEE=\hpHole$,
        $\hpEF_i=\hpCD_1[\hpP_1,\hpHole_i,\hpP_n]$, and
        $\hpEF_j=\hpCD_2[\hpP_{n+1},\hpHole_j,\hpP_{n+m}]$.

        The result follows as (1).

      - Subcase $1 \leq j \leq n < i \leq m$.

        Let $\hpEE=\hpHole$,
        $\hpEF_i=\hpCD_1[\hpP_{n+1},\hpHole_i,\hpP_{n+m}]$, and
        $\hpEF_j=\hpCD_2[\hpP_1,\hpHole_j,\hpP_n]$.

        The result follows as (2).

<!--
      - $\hpP_i$ and $\hpP_j$ are on the same side of the parallel composition.

        The result follows from the induction hypothesis for $\hpP$, by prepending

      - Subcase $\hpx,\hpx'\in\hpQ$.

        The result follows from the induction hypothesis for $\hpQ$, by prepending $\hpP\hpPar\hpHole$ to $\hpEE$. -->
