Proof.
  ~ There are five cases:

    1.  By induction on the structure of $\hpP$.
        If $\hpP$ is of the form $\hpZ$, the result follows immediately.
        If $\hpP$ is of the form $\hpQ\hpPar\hpR$, the induction hypotheses give us $\hpQ=\hpZ$ and $\hpR=\hpZ$, which contradicts condition (2) of disentangled form.
        The remaining cases, where $\hpP$ is ready or $\hpP$ is of the form $\hpNew(\hpx\hpx')\hpP'$ are impossible, by inversion on the typing derivation.
    2.  By induction on the structure of $\hpP$.
        If $\hpP$ is of the form $\hpQ\hpPar\hpR$, the result follows immediately.
        If $\hpP$ is of the form $\hpNew(\hpx\hpx')\hpP'$, the induction hypothesis gives us that $\hpP'$ is of the form $\hpQ'\hpPar\hpR'$, which contradicts condition (1) of disentangled form.
        The remaining cases, where $\hpP$ is ready or $\hpP$ is of the form $\hpZ$ are impossible, by inversion on the typing derivation.
    3.  By case (2) and condition (1a) of disentangled form.
    4.  By case (2) and condition (1b) of disentangled form.
    5.  By case (1).
