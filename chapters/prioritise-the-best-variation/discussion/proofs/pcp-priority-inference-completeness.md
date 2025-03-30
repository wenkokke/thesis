Proof.
  ~ By induction on the derivation of $\ppP\ppSeq\ppGG$.
    In each case, we construct the priority substitution $\pts$ by matching the priority metavariables in the erased types to the priorities on the original type, and prove that $\pts$ is a graph homomorphism from the produced priority graph $\ptG$ to the graph corresponding to the order on the natural numbers. Consequently, $\pts$ witnesses the fact that $\ptG$ is linearisable, and therefore is essentially acyclic.
