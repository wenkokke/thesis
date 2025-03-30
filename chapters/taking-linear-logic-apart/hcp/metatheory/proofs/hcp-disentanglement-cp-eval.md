Proof.
  ~ By @lemma:hcp-canonical-reduction, rewrite the derivation of the reduction $\hpP \hpEval \hpQ$ to
    $$
      \AXC{$\hpP \hpEquiv \hpNew(\hpx\hpx')(\hpP_1\hpPar\hpP_2)$}
      \AXC{}
      \RightLabel{$r$}
      \UIC{$\hpNew(\hpx\hpx')(\hpP_1\hpPar\hpP_2) \hpEval \hpR$}
      \UIC{$\hpEE[\hpNew(\hpx\hpx')(\hpP_1\hpPar\hpP_2)] \hpEval \hpEE[\hpR]$}
      \AXC{$\hpEE[\hpR] \hpEquiv \hpQ$}
      \TIC{$\hpP \hpEval \hpQ$}
      \DP
    $$
    where $r$ is \Rule{H-E-Link}, \Rule{H-E-Send}, \Rule{H-E-Close}, \Rule{H-E-Select1}, or \Rule{H-E-Select2}.

    By @proposition:hcp-disentanglement-cp-equiv, $\DisHtoM(\hpP)\mpEquiv\DisHtoM(\hpEE[\hpNew(\hpx\hpx')(\hpP_1\hpPar\hpP_2)])$ and $\DisHtoM(\hpEE[\hpR])\mpEquiv\DisHtoM(\hpQ)$.

    Pick an arbitrary $\cpP'\in\DisHtoM(\hpEE[\hpNew(\hpx\hpx')(\hpP_1\hpPar\hpP_2)])$.

    If $r$ is not \Rule{H-E-Link}, both $\hpP_1$ and $\hpP_2$ are ready, and, by @lemma:hcp-disentanglement-distributes-over-maximal-evaluation-contexts, preserved up to link-preserving deep structural congruence, by disentanglement.
    By @lemma:cp-separation and the fact that $\cpP'$ is in right-branching form, $\cpP'$ is either of the form $\cpEF_1[\cpNew(\cpx\cpx')(\cpP'_1\cpPar\cpEF_2[\cpP'_2])]$ or of the form $\cpEF_2[\cpNew(\cpx'\cpx)(\cpP'_2\cpPar\cpEF_1[\cpP'_1])]$, where $\cpP'_1\in\DisHtoM(\hpP_1)$ and $\cpP'_2\in\DisHtoM(\hpP_2)$.
    In the first case, the CP reduction is constructed as:
    $$
    \begin{array}{l@{\;}l@{\ }l}
    \cpEF_1[\cpNew(\cpx\cpx')(\cpP'_1\cpPar\cpEF_2[\cpP'_2])]
    & \mpEquivLPS
    & \langle\text{by \Cref{lemma:cp-evaluation-context-commute}}\rangle
    \\
    \cpEF_1[\cpEF_2[\cpNew(\cpx\cpx')(\cpP'_1\cpPar\cpP'_2)]]
    & \mpEval
    & \langle\text{by }r\rangle
    \\
    \cpEF_1[\cpEF_2[\cpR']]
    &
    & \hphantom{\langle\text{by \Cref{proposition:hcp-connection-graph-equiv-lps}}\rangle}
    \end{array}
    $$
    By case analysis on $r$, it follows that $\cpEF_1[\cpEF_2[\cpR']]\cpEquivLPS\DisHtoM(\hpEE[\hpR])$.

    In the second case, the CP reduction is constructed similarly.

    If $r$ *is* \Rule{H-E-Link}, the CP reduction is constructed similarly, since, if $\hpP_1\iotf\hpLink\hpx\hpy$, the thread in $\hpP_2$ that contains $\hpx'$ is preserved up to fusion and link-preserving deep structural congruence in $\cpP'$.
