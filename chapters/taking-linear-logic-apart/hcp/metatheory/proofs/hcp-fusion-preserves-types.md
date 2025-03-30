Proof.
  ~ By induction on the structure of the derivation $\CtoH(\cpP)\hpSeq\CtoH(\cpGG)$.

    - Cases \Rule{H-T-New}, \Rule{H-T-Send}, and \Rule{H-T-Close}.

      The result follows from the CP rules \Rule{C-T-Cut}, \Rule{C-T-Send}, and \Rule{C-T-Close} and inversion on the structure of the CP process $\cpP$, which establishes that the derivations constructed in Case ($\Rightarrow$) are the only derivations.

    - Cases \Rule{H-T-Par} and \Rule{H-T-Halt}.

      Impossible, by inversion on the structure of the CP process $\cpP$.

    - Cases \Rule{H-T-Link}, \Rule{H-T-Recv}, \Rule{H-T-Wait}, \Rule{H-T-Select1}, \Rule{H-T-Select2}, \Rule{H-T-Offer}, and \Rule{H-T-AbsurdZap}.

      The result follows from the induction hypotheses (if any) and the CP rule of the same name, i.e., \Rule{C-T-Link}, \Rule{C-T-Recv}, \Rule{C-T-Wait}, \Rule{C-T-Select1}, \Rule{C-T-Select2}, \Rule{C-T-Offer}, and \Rule{C-T-AbsurdZap}, respectively.
