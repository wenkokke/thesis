Proof.
  ~ By induction on the derivation of the reduction.
    The cases for \Rule{H-E-Link}, \Rule{H-E-Send}, \Rule{H-E-Close}, \Rule{H-E-Select1}, \Rule{H-E-Select2}, \Rule{H-E-Equiv}, and \Rule{H-E-Cong}, are as in @proposition:hcp-preservation.

    - Case \Rule{H-E-Zap}.

      The reduction rule guarantees that $\hpP$ is ready on $\hpx'$.
      Therefore, $\hpP$ must be typed under a single hyper-environment.
      Hence, the typing derivation is of the form:
      $$
      \AXC{$
        \hpNN=\fn(\hpGG)
        $}
      \RL{\Rule{H-T-Zap}}
      \UIC{$
        \hpZapper{\hpNN,\hpx}
        \hpSeq
        \hpGG,\hpx:\hpA
        $}
      \AXC{$
        \hpP
        \hpSeq
        \hpGD,\hpx':\co\hpA
        $}
      \RL{\Rule{H-T-Par}}
      \BIC{$
        \hpZapper{\hpNN,\hpx}
        \hpPar
        \hpP
        \hpSeq
        \hpGG,\hpx:\hpA
        \hpHTens
        \hpGD,\hpx':\co\hpA
        $}
      \RL{\Rule{H-T-New}}
      \UIC{$
        \hpNew(\hpx\hpx')(
        \hpZapper{\hpNN,\hpx}
        \hpPar
        \hpP
        )
        \hpSeq
        \hpGG,\hpGD
        $}
      \DP
      $$
      The result is well-typed by the following typing derivation:
      $$
      \AXC{$
        \hpNN\hptm{,}\hpNM=\fn(\hpGG,\hpGD)
        $}
      \RL{\Rule{H-T-Zap}}
      \UIC{$
        \hpZapper{\hpNN,\hpNM}
        \hpSeq
        \hpGG,\hpGD
        $}
      \DP
      $$
      The side condition $\hpNN\hptm{,}\hpNM=\fn(\hpGG,\hpGD)$ is satisfied.
      This follows from the side conditions of typing and reduction, and @proposition:hcp-linearity:
      $$
        \hpNN=\fn(\hpGG)
        \quad\text{and}\quad
        \hpNM\defeq\fn(\hpP)\setminus\{\hpx'\}=\fn(\hpGD)
      $$
      The other condition is that there must be *some* endpoint $\hpy:\hpTop$ in $\hpGG,\hpGD$.
      By typing, there must be some endpoint $\hpy:\hpTop$ in $\hpGG,\hpx:\hpA$.
      There are two cases:

      1.  If $\hpx\neq\hpy$, then there exists some endpoint $\hpy:\hpTop\in\hpGG$.
      2.  If $\hpx=\hpy$, then $\hpy:\hpTop\notin\hpGG$. By duality, the endpoint $\hpx'$ must have type $\hpOne$. As there are no introduction forms for $\hpOne$, the endpoint of type $\hpOne$ must have been introduced by \Rule{H-T-Zap}. Hence, there must be some endpoint $\hpz:\hpTop\in\hpGD$.

      The proof for subcase (2) relies on the consistency of HCLL, which we have not explicitly proven, but which follows from disentanglement and the consistency of CLL.
