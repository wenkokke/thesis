Proof.
  ~ @summary
    By case analysis on $\hpP$.

    (For the full proof, see @hcp-omitted-proofs.)
  ~ @omitted
    By case analysis on $\hpP$.

    - Case $\hpP$ is of the form $\hpLink\hpx\hpy$.

      $\!\!%
      \begin{array}{l@{\;=\;}l}
      \vertices[\dependency(\hpP)]
      &
      \{\hpx,\hpy\}
      \\
      \edges[\dependency(\hpP)]
      &
      \{\edge\hpx\hpy\}
      \\
      \arcs[\dependency(\hpP)]
      &
      \emptyset
      \end{array}$

      Hence, $\dependency(\hpP)$ is essentially acyclic, as there are no arcs, and connected, as the two vertices are connected by an edge.

    - Case $\hpP$ is of the form $\hpSend\hpx\hpy.\hpP'$, $\hpRecv\hpx\hpy.\hpP'$, $\hpClose\hpx.\hpP'$, $\hpWait\hpx.\hpP'$, $\hpSelect\hpx<1.\hpP'$, $\hpSelect\hpx<2.\hpP'$, or $\hpOffer\hpx(\hpInl:\hpP_1;\hpInr:\hpP_2)$.

      $\!\!%
      \begin{array}{l@{\;=\;}l}
      \vertices[\dependency(\hpP)]
      &
      \fn(\hpP)
      \\
      \edges[\dependency(\hpP)]
      &
      \emptyset
      \\
      \arcs[\dependency(\hpP)]
      &
      \{\arc\hpx\hpy\vert\hpy\in\fn(\hpP)\land\hpx\neq\hpy\}
      \end{array}$

      Hence, $\dependency(\hpP)$ is essentially acyclic, as all arcs are out of $\hpx$, and connected, as every other vertex is connected to $\hpx$.
