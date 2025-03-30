Proof.
  ~ By induction on the derivation of the equivalence $\cpP\cpEquiv\cpQ$.

    The case for reflexivity follows immediately.
    The cases for symmetry and transitivity follow immediately by induction.
    The case for congruence closure follows by induction and the injectivity of the type derivation rules.
    The cases for applications of \Rule{C-SC-LinkComm}, \Rule{C-SC-CutComm}, and \Rule{C-SC-CutAssoc} are as follows, presented as equivalences on type derivations:

    - Case \Rule{C-SC-LinkComm}:
      $$
      \AXC{}
      \UIC{$
        \cpLink\cpx\cpy
        \cpSeq
        \cpx:\cpA,
        \cpy:\co{\cpA}
        \vphantom{\co{\co\cpA}}
      $}
      \DP
      \cpEquiv
      \AXC{}
      \UIC{$
        \cpLink\cpy\cpx
        \cpSeq
        \cpy:\co\cpA,
        \cpx:\co{\co\cpA}
      $}
      \RightLabel{Lemma~\ref{lemma:cp-duality-involutive}}
      \UIC{$
        \cpLink\cpy\cpx
        \cpSeq
        \cpy:\co\cpA,
        \cpx:\cpA
      $}
      \DP
      $$

    - Case \Rule{C-SC-CutComm}:
      $$
      \begin{array}{c}
      \AXC{$\cpP\cpSeq\cpGG_1,\cpx:\cpA$}
      \AXC{$\cpQ\cpSeq\cpGG_2,\cpx':\co\cpA$}
      \BIC{$
        \cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)
        \cpSeq
        \cpGG_1,\cpGG_2
      $}
      \DP
      \\
      \rotatebox{270}{$\cpEquiv$}
      \\
      \AXC{$\cpQ\cpSeq\cpGG_2,\cpx':\co\cpA$}
      \AXC{$\cpP\cpSeq\cpGG_1,\cpx:\co{\co\cpA}$}
      \RightLabel{Lemma~\ref{lemma:cp-duality-involutive}}
      \UIC{$\cpP\cpSeq\cpGG_1,\cpx:\cpA$}
      \BIC{$
        \cpNew(\cpx'\cpx)(\cpQ\cpPar\cpP)
        \cpSeq
        \cpGG_1,\cpGG_2
      $}
      \DP
      \end{array}
      $$

    - Case \Rule{C-SC-CutAssoc}:
      $$
      \begin{array}{c}
      \AXC{$\cpP\cpSeq\cpGG_1,\cpx:\cpA,\cpy:\cpB$}
      \AXC{$\cpQ\cpSeq\cpGG_2,\cpy':\co\cpB$}
      \BIC{$
        \cpNew(\cpy\cpy')(\cpP\cpPar\cpQ)
        \cpSeq
        \cpGG_1,\cpGG_2,\cpx:\cpA
      $}
      \AXC{$\cpR\cpSeq\cpGG_3,\cpx':\co\cpA$}
      \BIC{$
        \cpNew(\cpx\cpx')(\cpNew(\cpy\cpy')(\cpP\cpPar\cpQ)\cpPar\cpR)
        \cpSeq
        \cpGG_1,\cpGG_2,\cpGG_3
      $}
      \DP
      \\
      \rotatebox{270}{$\cpEquiv$}
      \\
      \AXC{$\cpP\cpSeq\cpGG_1,\cpx:\cpA,\cpy:\cpB$}
      \AXC{$\cpR\cpSeq\cpGG_3,\cpx':\co\cpA$}
      \BIC{$
        \cpNew(\cpx\cpx')(\cpP\cpPar\cpR)
        \cpSeq
        \cpGG_1,\cpGG_3,\cpy:\cpB
      $}
      \AXC{$\cpQ\cpSeq\cpGG_2,\cpy':\co\cpB$}
      \BIC{$
        \cpNew(\cpy\cpy')(\cpNew(\cpx\cpx')(\cpP\cpPar\cpR)\cpPar\cpQ)
        \cpSeq
        \cpGG_1,\cpGG_2,\cpGG_3
      $}
      \DP
      \end{array}
      $$
      The above derivation for the left-hand side (symmetrically, right-hand side) is the only derivation, as $\cpx\notin\cpQ$ (symmetrically, $\cpy\notin\cpR$).
