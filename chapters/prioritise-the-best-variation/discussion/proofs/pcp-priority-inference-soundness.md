Proof.
  ~ Let $H$ be the quotient graph of $\ptG$ by its edges $\edges[\ptG]$, i.e., $\ptG/\edges[\ptG]$.
    Consequently, $H$ has no edges and is a directed graph.
    Since $\ptG$ is essentially acyclic, $H$ is acyclic.
    By topological sort, there exists a linear ordering $S_n$ of the vertices of $H$ such that, if $\arc{u}{v}\in\arcs[H]$, then $u$ comes before $v$ in $S_n$.
    Let the priority substitution $\pts:\vertices[\ptG]\to\mathbb{N}$ be the function that maps each priority metavariable to its position in the linear ordering $S_n$, i.e., $\pts=\{\pto \mapsto i \vert \pto\in S_i\}$.

    The typing derivation for $\pts(\ptP)\ppSeq\pts(\ptGG)$ is constructed by induction on the typing derivation for $\ptP\ptSeq\ptGG\ptGives\ptG$.

    - In the cases for \Rule{P-PI-Send}, \Rule{P-PI-Recv}, \Rule{P-PI-Close}, \Rule{P-PI-Wait}, \Rule{P-PI-Select1}, \Rule{P-PI-Select2}, \Rule{P-PI-Offer}, and \Rule{P-PI-AbsurdZap}, the result follows from the induction hypothesis and the rules \Rule{P-T-Send}, \Rule{P-T-Recv}, \Rule{P-T-Close}, \Rule{P-T-Wait}, \Rule{P-T-Select1}, \Rule{P-T-Select2}, \Rule{P-T-Offer}, and \Rule{P-T-AbsurdZap}, respectively.
      The constraint $\ppo<\pr(\ppGG)$ is satisfied by the definition of $\pts$ and the rooting of the priority graph $\pto\rooting\ptG$.
    - In the case for \Rule{P-PI-Link}, the result follows from the rule \Rule{P-PI-Link}.
      In the case for \Rule{P-PI-Res}, the result follows from the induction hypothesis and the rule \Rule{P-PI-Res}.
      In both cases, duality is satisfied by the definition of $\pts$ and the priority link $\ptBiPartite{\ptA}{\ptA'}$.
    - In the case for \Rule{P-PI-Par}, the result follows from the induction hypotheses and the rule \Rule{P-T-Par}.
    - In the case for \Rule{P-PI-Halt}, the result follows from the rule \Rule{P-T-Halt}.
