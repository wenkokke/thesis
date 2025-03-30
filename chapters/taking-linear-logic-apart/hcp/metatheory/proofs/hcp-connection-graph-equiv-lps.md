Proof.
  ~ There are two cases:

    - Case $(\Rightarrow)$.

      By induction on the proof of the structural congruence $\hpP\hpEquivLPS\hpQ$.
      The cases for reflexivity, transitivity, symmetry, and \Rule{C-SC-Cong} follow by induction and those same properties of equality. The remaining cases follow immediately.
    - Case $(\Leftarrow)$.

      Let $\process(T)$ be the set of processes in right-branching forest form obtained from the connection graph $G$ of a well-typed process by @proposition:hcp-right-branching-forest-form.
      (This is a set because @proposition:hcp-right-branching-forest-form defines a non-deterministic procedure.)

      Pick any $\hpR\in\process(\connection(\hpP))$. As $\connection(\hpP)=\connection(\hpQ)$, $\process(\connection(\hpP))=\process(\connection(\hpQ))$. Hence, $\hpR\in\process(\connection(\hpQ))$. By definition, $\hpP\hpEquivLPS\hpR$ and $\hpQ\hpEquivLPS\hpR$. Hence, $\hpP\hpEquivLPS\hpQ$.
