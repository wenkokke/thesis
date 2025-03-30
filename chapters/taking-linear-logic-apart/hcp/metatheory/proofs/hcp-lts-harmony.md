Proof.
  ~ There are two cases:

    - Case $(\Rightarrow)$.

      By @lemma:hcp-canonical-transition-tau, rewrite the derivation of the transition $\hpP \hpTTo \hpQ$ to
      $$
        % 1.
          \AXC{}
          \RL{$a$}% Act-*
          \UIC{$
            \hpP_1
            \hpTo{\hpAct\vphantom{\hpAct'}}
            \hpP'_1$}
          \RL{\Rule{H-Str-Cong}}% Str-Cong
          \UIC{$
            \hpEF_1[\hpP_1]
            \hpTo{\hpAct\vphantom{\hpAct'}}
            \hpEF_1[\hpP'_1]$}
        % 2.
          \AXC{}
          \RL{$\bar{a}$}% Act-*
          \UIC{$
            \hpP_2
            \hpTo{\hpAct'\vphantom{\hpAct'}}
            \hpP'_2$}
          \RL{\Rule{H-Str-Cong}}% Str-Cong
          \UIC{$
            \hpEF_2[\hpP_2]
            \hpTo{\hpAct'\vphantom{\hpAct'}}
            \hpEF_2[\hpP'_2]$}
        \RL{\Rule{H-Str-Par}}% Str-Par
        \BIC{$
          \hpEF_1[\hpP_1]\hpPar\hpEF_2[\hpP_2]
          \hpTo{\hpAct\hpLabPar\hpAct'}
          \hpEF_1[\hpP'_1]\hpPar\hpEF_2[\hpP'_2]$}
        \RL{\Rule{H-Str-Cong}}% Str-Cong
        \UIC{$
          \hpEE_3[\hpEF_1[\hpP_1]\hpPar\hpEF_2[\hpP_2]]
          \hpTo{\hpAct\hpLabPar\hpAct'}
          \hpEE_3[\hpEF_1[\hpP'_1]\hpPar\hpEF_2[\hpP'_2]]$}
        \RL{$t$}% Tau-*
        \UIC{$
          \hpNew(\hpx\hpx')\hpEE_3[\hpEF_1[\hpP_1]\hpPar\hpEF_2[\hpP_2]]
          \hpTTo
          \hpEE_2[\hpEE_3[\hpEF_1[\hpP'_1]\hpPar\hpEF_2[\hpP'_2]]]$}
        \RL{\Rule{H-Str-Cong}}% Str-Cong
        \UIC{$
          \hpEE_1[\hpNew(\hpx\hpx')\hpEE_3[\hpEF_1[\hpP_1]\hpPar\hpEF_2[\hpP_2]]]
          \hpTTo
          \hpEE_1[\hpEE_2[\hpEE_3[\hpEF_1[\hpP'_1]\hpPar\hpEF_2[\hpP'_2]]]]$}
        \DP
      $$
      where $t$ is one of \Rule{H-Tau-Link}, \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Close-Wait}, \Rule{H-Tau-Select-Offer1}, or \Rule{H-Tau-Select-Offer2}, and $a$ and $\bar{a}$ are one of \Rule{H-Act-Link1}, \Rule{H-Act-Link2}, \Rule{H-Act-send}, \Rule{H-Act-Recv}, \Rule{H-Act-Close}, \Rule{H-Act-Wait}, \Rule{H-Act-Select1}, \Rule{H-Act-Select2}, \Rule{H-Act-Offer1}, or \Rule{H-Act-Offer2}.
      By repeated application of \Cref{lemma:hcp-evaluation-context-commute-new,lemma:hcp-evaluation-context-commute-par}:
      $$
      \hpEE_1[\hpNew(\hpx\hpx')\hpEE_3[\hpEF_1[\hpP_1]\hpPar\hpEF_2[\hpP_2]]]
      \hpEquiv
      \hpEE_1[\hpEE_3[\hpEF_1[\hpEF_2[\hpNew(\hpx\hpx')(\hpP_1\hpPar\hpP_2)]]]]
      $$
      By case analysis on $t$ and inversion on $a$ and $\bar{a}$, the structure of the messages $\hpAct$ and $\hpAct'$, and the processes $\hpP_1$, $\hpP'_1$, $\hpP_2$, and $\hpP'_2$, and $\hpEE_2$:
      $$
        \hpEE_1[\hpEE_3[\hpEF_1[\hpEF_2[\hpNew(\hpx\hpx')(\hpP_1\hpPar\hpP_2)]]]]
        \hpEval
        \hpEE_1[\hpEE_3[\hpEF_1[\hpEF_2[\hpEE_2[\hpP'_1\hpPar\hpP'_2]]]]]
      $$
      By repeated application of \Cref{lemma:hcp-evaluation-context-commute-new,lemma:hcp-evaluation-context-commute-par}:
      $$
        \hpEE_1[\hpEE_3[\hpEF_1[\hpEF_2[\hpEE_2[\hpP'_1\hpPar\hpP'_2]]]]]
        \hpEquiv
        \hpEE_1[\hpEE_2[\hpEE_3[\hpEF_1[\hpP'_1]\hpPar\hpEF_2[\hpP'_2]]]]
      $$
      The result follows by composing these results with \Rule{H-E-Equiv}.


    - Case $(\Leftarrow)$.

      By @lemma:hcp-canonical-reduction, rewrite the derivation of the reduction $\hpP \hpEval \hpQ$ to
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
      By case analysis on $r$ and inversion on the structure of $\hpP_1$, $\hpP_2$, and $\hpR$, $\hpNew(\hpx\hpx')(\hpP_1\hpPar\hpP_2)\hpTTo\hpR$.
      By \Rule{H-Str-Cong}, $\hpEE[\hpNew(\hpx\hpx')(\hpP_1\hpPar\hpP_2)]\hpTTo\hpEE[\hpR]$.
      By @lemma:hcp-lts-equiv and $\hpP \hpEquiv \hpNew(\hpx\hpx')(\hpP_1\hpPar\hpP_2)$, $\hpP\hpTTo\hpEquiv\hpEE[\hpR]$.
      By transitivity, $\hpP\hpTTo\hpEquiv\hpQ$.
