Proof.
  ~ By induction on the derivation of $\hpP\hpSeq\hpHG$ and inversion on $\hpP$.

    If $\hpP$ is ready, the result follows by induction. Most cases can be handled uniformly, but send, offer and the absurd offer are handled separately.

    - Case $\hpP$ is of the form $\hpSend\hpx\hpy.\hpP'$.

      By induction, $\hpP'\hpEquivLPS\hpQ'$ for some disentangled process $\hpQ'$.
      By @lemma:hcp-disentangled (2), $\hpQ'$ is of the form $\hpQ'_1\hpPar\hpQ'_2$. By condition (2) of disentangled form, $\hpQ'_1\neq\hpZ$ and $\hpQ'_2\neq\hpZ$. There are two cases:

      - Subcase $\hpy\in\fn(\hpQ'_1)$ and $\hpx\in\fn(\hpQ'_2)$.

        Let $\hpQ$ be $\hpSend\hpx\hpy.\hpQ'_1\hpPar\hpQ'_2$.
        The result follows.
      - Subcase $\hpx\in\fn(\hpQ'_1)$ and $\hpy\in\fn(\hpQ'_2)$.

        Let $\hpQ$ be $\hpSend\hpx\hpy.\hpQ'_2\hpPar\hpQ'_1$.
        The result follows by \Rule{H-SC-ParComm}.

    - Case $\hpP$ is of the form $\hpRecv\hpx\hpy.\hpP'$, $\hpClose\hpx.\hpP'$, $\hpWait\hpx.\hpP'$, $\hpSelect\hpx<1.\hpP'$, or $\hpSelect\hpx<2.\hpP'$.

      By induction, $\hpP'\hpEquivLPS\hpQ'$ for some disentangled process $\hpQ'$.
      Let $\hpQ$ be $\hpRecv\hpx\hpy.\hpQ'$, $\hpClose\hpx.\hpQ'$, $\hpWait\hpx.\hpQ'$, $\hpSelect\hpx<1.\hpQ'$, or $\hpSelect\hpx<2.\hpQ'$, respectively.
      The result follows.

    - Case $\hpP$ is of the form $\hpOffer\hpx(\hpInl:\hpP'_1;\hpInr:\hpP'_2)$.

      By induction on $\hpP'_1$, $\hpP'_1\hpEquivLPS\hpQ'_1$ for some disentangled process $\hpQ'_1$.
      By induction on $\hpP'_2$, $\hpP'_2\hpEquivLPS\hpQ'_2$ for some disentangled process $\hpQ'_2$.
      Let $\hpQ$ be $\hpOffer\hpx(\hpInl:\hpQ'_1;\hpInr:\hpQ'_2)$.
      The result follows.

    - Case $\hpP$ is of the form $\hpLink\hpx\hpy$ or $\hpAbsurdZap\hpx\hpNN$.

      The result follows immediately.

    Otherwise, the result follows by converting $\hpP$ to right-branching forest form, taking the maximum configuration context of the resulting process, and converting each ready subprocess by induction.

    - Case $\hpP$ is of the form $\hpNew(\hpx\hpx')\hpP'$, $\hpP_1\hpPar\hpP_2$, or $\hpZ$.

      By @proposition:hcp-right-branching-forest-form, there exists some $\hpQ'$ such that $\hpP\hpEquivLPS\hpQ'$ and $\hpQ'$ is in right-branching forest form. By case analysis on $\hpQ'$:

        - If $\hpQ'$ is of the form $\hpZ$, the result follows immediately.
        - Otherwise, let $\hpCC^n$ be the maximum configuration context of $\hpQ'$ such that $\hpQ'=\hpCC^n[\hpQ'_1,\hptm\dots,\hpQ'_n]$ (for some $n \geq 1$) and (for $1 \leq i \leq n$) each $\hpQ'_i$ is ready.
          By induction, there exist processes $\hpQ_1, \ldots, \hpQ_n$ such that (for $1 \leq i \leq n$) each $\hpQ'_i\hpEquivLPS\hpQ_i$ and $\hpQ_i$ is disentangled.
          Let $\hpQ$ be $\hpCC^n[\hpQ_1,\hptm\dots,\hpQ_n]$.
          By transitivity and congruence, $\hpP\hpEquivLPS\hpQ$.
          By induction on the structure of $\hpCC^n$ and inversion on the fact that $\hpQ'$ is in right-branching forest form, $\hpQ$ is disentangled.
          The result follows.
