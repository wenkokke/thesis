Proof.
  ~ The proof is an extension to the proof of @proposition:hcp-disentanglement, which proves the following two facts:

    1.  In the proof for @lemma:hcp-right-branching-tree-form, under the case $\vertices[T]>1$, we pick an arbitrary leaf of the connection tree $T$.
        Any choice is equivalent up to CP's structural congruence.

        Assume that $\hpP_i$ and $\hpP_j$ are both leaves of $T$.
        If we pick $\hpP_i$ and then $\hpP_j$, we get (a), but if we pick $\hpP_j$ and then $\hpP_i$, we get (b).
        $$
        \begin{array}{c@{\qquad}c}
          \text{(a)}
          &
          \text{(b)}
          \\
          \hpQ
          \hpPar
          \hpNew(\hpx\hpx')(
            \hpP_i
            \hpPar
            \hpNew(\hpy\hpy')(
              \hpP_j
              \hpPar
              \hpR'
          ))
          &
          \hpQ
          \hpPar
          \hpNew(\hpy\hpy')(
            \hpP_j
            \hpPar
            \hpNew(\hpx\hpx')(
              \hpP_i
              \hpPar
              \hpR'
          ))
        \end{array}
        $$
        As $\hpP_i$ and $\hpP_j$ are both leaves of $T$, $\hpx,\hpx'\notin\fn(\hpP_j)$ and $\hpy,\hpy'\notin\fn(\hpP_i)$, which means the two processes are equivalent by \Rule{C-SC-CutComm} and \Rule{C-SC-CutAssoc}.

        If we pick $\hpP_i$, then pick a number of processes that have become leaves by the removal of $\hpP_i$ and successive choices, *and then* pick $\hpP_j$, we get (a), where there is some (right-branching) evaluation context $\hpEE$ between $\hpP_i$ and $\hpP_j$, but if we pick $\hpP_j$, then pick $\hpP_i$, and then pick the processes in $\hpEE$, we get (b).
        $$
        \begin{array}{c@{\qquad}c}
          \text{(a)}
          &
          \text{(b)}
          \\
          \hpQ
          \hpPar
          \hpNew(\hpx\hpx')(
            \hpP_i
            \hpPar
            \hpEE[
              \hpNew(\hpy\hpy')(
                \hpP_j
                \hpPar
                \hpR'
          )])
          &
          \hpQ
          \hpPar
          \hpNew(\hpy\hpy')(
            \hpP_j
            \hpPar
            \hpNew(\hpx\hpx')(
                \hpP_i
                \hpPar
                \hpEE[\hpR']
          ))
        \end{array}
        $$
        As $\hpP_j$ is a leaf of $T$, $\fn(\hpP_j)\cap\bn(\hpEE)=\emptyset$, which means the two processes are equivalent by @lemma:hcp-evaluation-context-commute-new and @lemma:hcp-evaluation-context-commute-par.

    2.  In the proof for @proposition:hcp-right-branching-forest-form, under the case where $\hpHG$ is of the form $\hpHG\hpHTens\hpGG$, we pick an arbitrary tree of the connection forest $G$.
        Any choice is equivalent up to Multiset CP's structural congruence.

        The result follows immediate from the multiset structure of Multiset CP's processes, i.e., by \Rule{M-SC-ParComm} and \Rule{M-SC-ParAssoc}.
