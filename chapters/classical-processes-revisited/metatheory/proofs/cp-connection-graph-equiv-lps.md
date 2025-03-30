Proof.
  ~ There are two cases:

    - Case $(\Rightarrow)$.

      By induction on the proof of the structural congruence $\cpP\cpEquivLPS\cpQ$.
      The cases for reflexivity, transitivity, symmetry, and \Rule{C-SC-Cong} follow by induction and those same properties of equality. The cases for \Rule{C-SC-CutComm} and \Rule{C-SC-CutAssoc} follow immediately.
    - Case $(\Leftarrow)$.

      Let $\process(T)$ be the set of processes in right-branching form obtained from the connection tree $T$ of a well-typed process by @proposition:cp-right-branching-form.
      (This is a set because @proposition:cp-right-branching-form defines a non-deterministic procedure.)

      Pick any $\cpR\in\process(\connection(\cpP))$. As $\connection(\cpP)=\connection(\cpQ)$, $\process(\connection(\cpP))=\process(\connection(\cpQ))$. Hence, $\cpR\in\process(\connection(\cpQ))$. By definition, $\cpP\cpEquivLPS\cpR$ and $\cpQ\cpEquivLPS\cpR$. Hence, $\cpP\cpEquivLPS\cpQ$.
