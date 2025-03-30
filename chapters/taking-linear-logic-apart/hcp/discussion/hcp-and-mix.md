# Hypersequents, \Rule{CLL-Mix}, and \Rule{CLL-Mix0} {#hcp-and-mix}

The rules for hyper-environments resemble those for \Rule{CLL-Mix} and \Rule{CLL-Mix0}.
$$
  \AXC{$\hpSeq\hpHG$}
  \AXC{$\hpSeq\hpHH$}
  \RightLabel{\Rule{HCLL-H-Tens}}
  \BIC{$\hpSeq\hpHG\hpHTens\hpHH$}
  \DP
  \qquad
  \AXC{$\vphantom{\hpGG}$}
  \RightLabel{\Rule{HCLL-H-One}}
  \UIC{$\hpSeq\hpHOne$}
  \DP
  \qquad
  \AXC{$\hpSeq\hpGG$}
  \AXC{$\hpSeq\hpGD$}
  \RightLabel{\RuleLabel{CLL}{Mix}}
  \BIC{$\hpSeq\hpGG\hpSParr\hpGD$}
  \DP
  \qquad
  \AXC{$\vphantom{\hpGG}$}
  \RightLabel{\RuleLabel{CLL}[Mix\textsubscript{0}]{Mix0}}
  \UIC{$\hpSeq\hpSBot$}
  \DP
$$
However, HCLL is a conservative extension of CLL, but \Rule{CLL-Mix} and \Rule{CLL-Mix0} alter the logic:
\Rule{CLL-Mix} is logically equivalent to $\hpA\hpTens\hpB\hpImpl\hpA\hpParr\hpB$, and \Rule{CLL-Mix0} is logically equivalent to $\hpOne\hpImpl\hpBot$.
The correspondence between branching and tensor is illuminating:
\Rule{CLL-Mix} converts *branching* (corresponding to $\hpTens$) into a *comma* (corresponding to $\hpParr$), and \Rule{CLL-Mix0} converts *having no premises* (corresponding to $\hpOne$) into the empty environment (corresponding to $\hpBot$).
On the contrary, \Rule{HCLL-H-Tens} and \Rule{HCLL-H-One} convert structure of the proof tree to structural connectives with the same logical interpretation.
