Proof.
  ~ By induction on the structure of the derivation of $\cpP\cpSeq\cpGG$.

    - Case \Rule{C-T-Cut}.

      We have
      $$
        \cpCUT*\cpx{\cpx'}\cpP\cpQ\cpGG\cpGD\cpA\DP
      $$
      By induction,
      $\CtoH(\cpP)\hpSeq\CtoH(\cpGG),\hpx:\CtoH(\cpA)$
      and
      $\CtoH(\cpQ)\hpSeq\CtoH(\cpGD),\hpx':\CtoH(\co\cpA)$.

      The result follows as
      $$
        \hpPAR*
          {\CtoH(\cpP)}
          {\CtoH(\cpQ)}
          {\CtoH(\cpGG),\hpx:\CtoH(\cpA)}
          {\CtoH(\cpGD),\hpx':\CtoH(\co\cpA)}
        \UIC{$
            \hpNew(\hpx\hpx')(
            \CtoH(\cpP)
            \hpPar
            \CtoH(\cpQ)
            )
            \hpSeq
            \CtoH(\cpGG),\CtoH(\cpGD)
          $}
        \DP
      $$

    - Case \Rule{C-T-Send}.

      We have
      $$
        \cpSEND*\cpx\cpy\cpP\cpQ\cpGG\cpGD\cpA\cpB\DP
      $$
      By induction,
      $\CtoH(\cpP)\hpSeq\cpGG,\cpy:\cpA$
      and
      $\CtoH(\cpQ)\hpSeq\cpGD,\cpx:\cpB$.

      The result follows as
      $$
        \hpPAR*
          {\CtoH(\cpP)}
          {\CtoH(\cpQ)}
          {\CtoH(\cpGG),\hpy:\CtoH(\cpA)}
          {\CtoH(\cpGD),\hpx:\CtoH(\cpB)}
        \UIC{$
            \hpSend\hpx\hpy.(
            \CtoH(\cpP)
            \hpPar
            \CtoH(\cpQ)
            )
            \hpSeq
            \CtoH(\cpGG),\CtoH(\cpGD),\hpx:\CtoH(\cpA)\hpTens\CtoH(\cpB)
          $}
        \DP
      $$

    - Case \Rule{C-T-Close}.
      We have
      $$
      \cpCLOSE*\cpx\DP
      $$
      The result follows as
      $$
        \AXC{}
        \UIC{$
            \hpZ
            \hpSeq
            \hpHOne
          $}
        \UIC{$
            \hpClose\hpx.0
            \hpSeq
            \hpx:\hpOne
          $}
        \DP
      $$

    - Cases \Rule{C-T-Link}, \Rule{C-T-Recv}, \Rule{C-T-Wait}, \Rule{C-T-Select1}, \Rule{C-T-Select2}, \Rule{C-T-Offer}, \Rule{C-T-AbsurdZap}.

      The result follows immediately from the HCP rules \Rule{H-T-Link}, \Rule{H-T-Recv}, \Rule{H-T-Wait}, \Rule{H-T-Select1}, \Rule{H-T-Select2}, \Rule{H-T-Offer}, \Rule{H-T-AbsurdZap} and the induction hypotheses (if any).
