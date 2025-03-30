# Cooking GV With Cut {#cooking-gv-with-cut}

```{=latex}
\gvset2%
```

In @LindleyM15:gv's GV, name restriction and parallel composition are separate configuration constructs. However, as discussed, this breaks type preservation for the structural congruence, which significantly complicates the metatheory.

This section presents an alternative formulation of GV, which we refer to as "GV with Cut" or GV~Cut~, which more closely corresponds to CP.
While this version is not preferable to Hypersequent GV, presented in this chapter, it represents my view of how GV should have been formulated prior to the introduction of hypersequents, and is helpful when examining @LindleyM15:gv's lock typing.

In this section, the terms and types of GV~Cut~ are printed in $\tmsecondaryname$ and $\tysecondaryname$, respectively, and both are rendered in a sans-serif font, and any relations, such as typing and reduction, are marked by a subscript "$\gvcutabbrev$".

To construct GV~Cut~, we replace name restriction and parallel composition with a cut. For configuration typing, we replace the rules \Rule{GV-TG-New}, \Rule{GV-TG-Connect1}, and \Rule{GV-TG-Connect2} with the rule \Rule{GV-TG-Cut}.
$$
\begin{array}{lrl}
\gvC,\gvD
& \Coloneq
& \mathst{\gvCNew(\gvx\gvx')\gvC}
\\
& \mid
& \mathst{\gvC\gvCPar\gvD}
\\
& \mid
& \gvCNew(\gvx\gvx')(\gvC\gvCPar\gvD)
\end{array}
\qquad
\begin{RuleWithLabel}{GV}{TG-Cut}
\AXC{$\gvGG,\gvx:\gvS\gvcutSeq\gvC:\gvR$}
\AXC{$\gvGD,\gvx':\co\gvS\gvcutSeq\gvD:\gvR'$}
\BIC{$
    \gvGG,\gvGD
    \gvcutSeq
    \gvCNew(\gvx\gvx')(\gvC\gvCPar\gvD):\gvR\gvCJoin\gvR'$}
\DP
\end{RuleWithLabel}
$$
For the structural congruence, we replace the rules \Rule{HGV-SC-ParAssoc}, \Rule{HGV-SC-ParComm}, \Rule{HGV-SC-NewAssoc}, \Rule{HGV-SC-NewSwap}, and \Rule{HGV-SC-ScopeExt} with the rules \Rule{GV-SC-CutComm} and \Rule{GV-SC-CutAssoc}.
$$
\begin{array}{l@{\;}c@{\;}ll}
\gvCNew(\gvx\gvx')(\gvC_1\gvCPar\gvC_2)
& \gvcutEquiv
& \gvCNew(\gvx'\gvx)(\gvC_2\gvCPar\gvC_1)
& \RuleLabel{GV}{SC-CutComm}
\\
\gvCNew(\gvx\gvx')(
\gvCNew(\gvy\gvy')(\gvC_1\gvCPar\gvC_2)\gvCPar\gvC_3)
& \gvcutEquiv
& \gvCNew(\gvy\gvy')(
\gvCNew(\gvx\gvx')(\gvC_1\gvCPar\gvC_3)\gvCPar\gvC_2)
& \RuleLabel{GV}{SC-CutAssoc}
\\
&
& \text{where }\gvx\notin\gvC_2\text{ and }\gvy\notin\gvC_3
\end{array}
$$
In GV~Cut~, the structural congruence preserves types. Much like the rules themselves, the proof is nearly identical to the proof of preservation for CP's structural congruence, and is left as an exercise.

Lemma {#gv-preservation-equiv}.
  ~ If $\gvGG\gvcutSeq\gvC:\gvR$ and $\gvC\gvcutEquiv\gvD$,
    then $\gvGG\gvcutSeq\gvD:\gvR$.

Since GV~Cut~'s structural congruence preserves types, it can be harmlessly embedded into the reduction relation, as per \Rule{GV-EG-Equiv}.
$$
\begin{RuleWithLabel}{GV}{EG-Equiv}
\AXC{$\gvC\gvcutEquiv\gvC'$}
\AXC{$\gvC'\gvcutEval\gvD'$}
\AXC{$\gvD'\gvcutEquiv\gvD$}
\TIC{$\gvC\gvcutEval\gvD$}
\DP
\end{RuleWithLabel}
$$
This small change tightens GV~Cut~'s correspondence with CP and considerably simplifies its metatheory, as there is no longer any need to prove preservation up to equivalence [e.g., @Fowler19:thesis, Theorem 2, pp. 40–43].
