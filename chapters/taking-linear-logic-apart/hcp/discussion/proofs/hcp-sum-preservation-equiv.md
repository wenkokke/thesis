Proof.
  ~ By induction on the derivation of the equivalence $\hpP\hpEquiv\hpQ$.

    The cases for reflexivity, symmetry, transitivity, and applications of \Rule{H-SC-LinkComm}, \Rule{H-SC-ParNil}, \Rule{H-SC-ParComm}, \Rule{H-SC-ParAssoc}, \Rule{H-SC-NewComm}, and \Rule{H-SC-ScopeExt} are as in @lemma:hcp-preservation-equiv.
    The case for congruence closure follows, similarly to @lemma:hcp-preservation-equiv, by induction and the injectivity of the type derivation rules.

    - Case \Rule{H-SC-SumAbsurd}.
      $$
      \!\!%
      \begin{array}{c}
        \AXC{$
          \hpP
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*}
          $}
        \AXC{$
          \hpNN=\fn(\hpGG)
          $}
        \UIC{$
          \hpAbsurdZap\hpx\hpNN
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{}
          $}
        \BIC{$
          \hpP\hpPar\hpAbsurdZap\hpx\hpNN
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*}
          $}
        \DP
        \\
        \rotatebox{270}{$\hpEquiv$}
        \\[2ex]
        \AXC{$
          \hpP
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*}
          $}
        \DP
      \end{array}
      $$
    - Case \Rule{H-SC-SumComm}.
      $$
      \!\!%
      \begin{array}{c}
        \AXC{$
          \hpP
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*}
          $}
        \AXC{$
          \hpQ
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*'}
          $}
        \BIC{$
          \hpP\hpSum\hpQ
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*\cup\hpL*'}
          $}
        \DP
        \\
        \rotatebox{270}{$\hpEquiv$}
        \\[2ex]
        \AXC{$
          \hpQ
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*'}
          $}
        \AXC{$
          \hpP
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*}
          $}
        \BIC{$
          \hpQ\hpSum\hpP
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*\cup\hpL*'}
          $}
        \DP
      \end{array}
      $$
    - Case \Rule{H-SC-SumAssoc}.
      $$
      \def\defaultHypSeparation{\hskip 1ex}%
      \!\!%
      \begin{array}{c}
        \AXC{$
          \hpP_1
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*_1}
          $}
        \AXC{$
          \hpP_2
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*_2}
          $}
        \AXC{$
          \hpP_3
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*_3}
          $}
        \BIC{$
            \hpP_2
            \hpSum
            \hpP_3
            \hpSeq
            \hpGG
            \hpFocA
            \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*_2\cup\hpL*_3}
          $}
        \insertBetweenHyps{\hskip -1ex}%
        \BIC{$
            \hpP_1
            \hpSum
            \hptm(
            \hpP_2
            \hpSum
            \hpP_3
            \hptm)
            \hpSeq
            \hpGG
            \hpFocA
            \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*_1\cup\hpL*_2\cup\hpL*_3}
          $}
        \DP
        \\
        \rotatebox{270}{$\hpEquiv$}
        \\[2ex]
        \AXC{$
          \hpP_1
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*_1}
          $}
        \AXC{$
          \hpP_2
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*_2}
          $}
        \BIC{$
            \hpP_1
            \hpSum
            \hpP_2
            \hpSeq
            \hpGG
            \hpFocA
            \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*_1\cup\hpL*_2}
          $}
        \AXC{$
          \hpP_3
          \hpSeq
          \hpGG
          \hpFocA
          \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*_3}
          $}
        \insertBetweenHyps{\hskip -1ex}%
        \BIC{$
            \hpP_1
            \hpSum
            \hptm(
            \hpP_2
            \hpSum
            \hpP_3
            \hptm)
            \hpSeq
            \hpGG
            \hpFocA
            \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*_1\cup\hpL*_2\cup\hpL*_3}
          $}
        \DP
      \end{array}
      $$
