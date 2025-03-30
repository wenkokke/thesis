Proof.
  ~ By induction on the derivation of $\cpP\cpSeq\cpGG$.

    - Case \Rule{C-T-Link}.

      The process $\cpP$ is of the form $\cpLink\cpx\cpy$.

      $\dependency(\cpLink\cpx\cpy)$ is essentially acyclic as it has no arcs.
    - Case \Rule{C-T-Cut}.

      The process $\cpP$ is of the form $\cpNew(\cpx\cpx')(\cpP_1\cpPar\cpP_2)$.
      By induction $\dependency(\cpP_1)$ and $\dependency(\cpP_2)$ are essentially acyclic.

      By \Rule{C-T-Cut}, $\fn(\cpP_1)\cap\fn(\cpP_2)=\emptyset$. Under the Barendregt convention, all bound names in $\cpP_1$ and $\cpP_2$ are distinct. Hence, $\dependency(\cpP_1)$ and $\dependency(\cpP_2)$ are disjoint.

      $\dependency(\cpP)$ is essentially acyclic by @lemma:mixed-graph-connection.

    - Case \Rule{C-T-Send}, \Rule{C-T-Recv}, \Rule{C-T-Close}, \Rule{C-T-Wait}, \Rule{C-T-Select1}, \Rule{C-T-Select2}, \Rule{C-T-Offer}, or \Rule{C-T-AbsurdZap}.

      The process $\cpP$ is ready, i.e., $\readyOn\cpP\cpx$ for some endpoint $\cpx$.

      $\dependency(\cpP)$ is essentially acyclic as it has no edges and only arcs out of $\cpx$.
