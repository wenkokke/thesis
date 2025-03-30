Proof.
  ~ By induction on the structure of the derivation $\cpP\cpEval\cpQ$.

    - Cases \Rule{C-E-Link}, \Rule{C-E-Send}, \Rule{C-E-Close}, \Rule{C-E-Select1}, and \Rule{C-E-Select2}.

      Immediately, by \Rule{H-E-Link}, \Rule{H-E-Send}, \Rule{H-E-Close}, \Rule{H-E-Select1}, and \Rule{H-E-Select2}, respectively.

    - Case \Rule{C-E-Equiv}.

      By \Rule{H-E-Equiv}, the induction hypothesis, and @proposition:hcp-fission-preserves-equiv.

    - Case \Rule{C-E-Cong}.

      By \Rule{H-E-Cong}, the induction hypothesis, and @proposition:hcp-fission-distributes-over-process-context.
