Proof.
  ~ Let $G$ be $\connection(\hpP)$.
    By @proposition:hcp-connection-forest, there is an isomorphism $f$ between the typing environments in $\hpHOne$ and the trees of $G$ that preserves $\fn$, i.e., $\fn(\hpGG)=\fn(f(\hpGG))$.
    As there are no typing environments in $\hpHOne$, $f$ is the empty function, and $G$ is the null graph.
    Let $\hpCC^n$ be maximal for $\hpP$ such that $\hpP=\hpCC^n[\hpP_1,\hptm\dots,\hpP_n]$ (for some $n \geq 0$).
    By definition, $\vertices[G]=\{\hpP_1,\dots\hpP_n\}$.
    As $G$ is the null graph, $\vertices[G]=\emptyset$.
    Hence, $n=0$, i.e., the maximum configuration context $\hpCC^0$ contains zero holes. By induction on $\hpCC^0$, the process $\hpP$ is equal to the parallel composition of terminated processes, and is equivalent to $\hpZ$ by repeated application of \Rule{H-SC-ParNil}.
