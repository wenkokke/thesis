# Lock Types, Cuts, and Hypersequents {#lock-types-cuts-and-hypersequents}

```{=latex}
\gvsetstyle2%
```

This section discusses the differences between GV with lock types, cuts, and hypersequents, and argues that, while lock types and hypersequents both permit the syntax for configurations to separate name restriction from parallel composition, lock types are, in effect, more complicated cuts, whereas hypersequents capture parallelism.

We compare the configuration typing rules for GV (Figure \hyperlink{paper:separating-sessions-smoothly.13}{I.5}), GV~Cut~ [@cooking-gv-with-cut], and HGV (Figure \hyperlink{paper:separating-sessions-smoothly.6}{I.3}).
In this section, the terms and types of both GV and GV~Cut~ are printed in $\tmsecondaryname$ and $\tysecondaryname$, respectively, both are rendered in a sans-serif font, and any relations, such as typing and reduction, are marked by subscript "$\gvabbrev$" and "$\gvcutabbrev$", respectively.

Let us begin with an observation. Both GV and HGV use the exact same syntax for configurations, but the translation from HGV to GV (in § \hyperlink{paper:separating-sessions-smoothly.13}{I.4}, under \hyperlink{paper:separating-sessions-smoothly.15}{"Translating HGV to GV"}) shows a gap between the two systems.
Every GV configuration is typeable in HGV, but there are HGV configurations that are not typeable in GV.

What is the relation between GV's configurations and GV~Cut~'s configurations?
As we will see, GV's parallel composition is, in essence, a cut, and therefore the two are identical.

Let us begin by discussing GV's lock types in slightly more detail.
GV splits cut into name restriction and parallel composition:
$$
\begin{array}{l@{\;}r@{\;}ll}
    \gvC, \gvD
  & \Coloneq
  & \dots
  \\
  & \mid
  & \mathst{\gvCNew(\gvx\gvx')(\gvC\gvCPar\gvD)}
  & \text{cut}
  \\
  & \mid
  & \gvCNew(\gvx\gvx')\gvC
  & \text{name restriction}
  \\
  & \mid
  & \gvC\gvCPar\gvD
  & \text{parallel composition}
\end{array}
$$
As naively decomposing cuts would break GV's tree connection structure and, more importantly, deadlock freedom, GV ensures these properties by lock typing.
It extends runtime typing environments with locked channel type assignments.[^lm-lock-typing]
$$
  \gvGG
  \Coloneq
  \dots
  \mid
  \gvGG,\gvLock{\gvx}{\gvx'}:\gvtyLock{\gvS}
$$
The special type assignment "$\gvLock{\gvx}{\gvx'}:\gvtyLock{\gvS}$" represents a channel with endpoints $\gvx$ and $\gvx'$ which has been created, but has not yet been split across a parallel composition. Hence, it is *locked*.

When a locked channel is split across a parallel composition, it becomes unlocked, and the endpoints become available for use.
Each parallel composition must split exactly one locked channel.
This is guaranteed by the typing rules for name restriction and parallel composition, reproduced below from Figure \hyperlink{paper:separating-sessions-smoothly.13}{I.5} (eliding the superfluous \Rule{GV-TG-Connect2}).
$$
\begin{RuleWithLabel}*{GV}{TG-New}
  \AXC{$
      \gvGG,\gvLock{\gvx}{\gvx'}:\gvtyLock{\gvS}
      \gvSeq
      \gvC:\gvR
    $}
  \UIC{$
      \gvGG
      \gvSeq
      \gvCNew(\gvx\gvx')\gvC:\gvR
    $}
  \DP
\end{RuleWithLabel}
\qquad
\begin{RuleWithLabel}*{GV}{TG-Connect1}
  \AXC{$
      \gvGG,\gvx:\gvS
      \gvSeq
      \gvC:\gvR
    $}
  \AXC{$
      \gvGD,\gvx':\co{\gvS}
      \gvSeq
      \gvD:\gvR'
    $}
  \BIC{$
      \gvGG,\gvGD,\gvLock{\gvx}{\gvx'}:\gvtyLock{\gvS}
      \gvSeq
      \gvC\gvCPar\gvD:\gvR\gvCJoin\gvR'
    $}
  \DP
\end{RuleWithLabel}
$$
The rule \Rule{GV-TG-New} creates a locked channel.
The rule \Rule{GV-TG-Connect1} splits a locked channel across a parallel composition.
As the typing environments for term typing cannot contain locked channels, every locked channel must be split across some parallel composition.

There is a tension between the structural congruence and the typing rules.
The typing rules require that each parallel composition splits exactly one locked channel, but the structural congruence---specifically, \Rule{GV-SC-ParAssoc}---does not respect this invariant.
Hence, GV's structural congruence does not preserve types.
For instance, the following configuration is well-typed:
$$
\AXC{$
    \gvGG_1,\gvx:\gvS
    \gvSeq
    \gvC_1:\gvR_1
  $}
\AXC{$
    \gvGG_2,\gvy:\gvS'
    \gvSeq
    \gvC_2:\gvR_2
  $}
\AXC{$
    \gvGG_3,\gvx':\co{\gvS},\gvy':\co{\gvS'}
    \gvSeq
    \gvC_3:\gvR_3
  $}
\BIC{$
    \gvGG_2,\gvGG_3,\gvx':\co{\gvS},\gvLock{\gvy}{\gvy'}:\gvS'
    \gvSeq
    \gvC_2\gvCPar\gvC_3:
    \gvR_2\gvCJoin\gvR_3
  $}
\BIC{$
    \gvGG_1,\gvGG_2,\gvGG_3,\gvLock{\gvx}{\gvx'}:\gvS,\gvLock{\gvy}{\gvy'}:\gvS'
    \gvSeq
    \gvC_1\gvCPar\gvtm(\gvC_2\gvCPar\gvC_3\gvtm):
    \gvR_1\gvCJoin\gvR_2\gvCJoin\gvR_3
  $}
\UIC{$
  \gvGG_1,\gvGG_2,\gvGG_3,\gvLock{\gvx}{\gvx'}:\gvS
  \gvSeq
  \gvCNew(\gvy\gvy')(\gvC_1\gvCPar\gvtm(\gvC_2\gvCPar\gvC_3\gvtm)):
    \gvR_1\gvCJoin\gvR_2\gvCJoin\gvR_3
  $}
\UIC{$
  \gvGG_1,\gvGG_2,\gvGG_3
  \gvSeq
  \gvCNew(\gvx\gvx')\gvCNew(\gvy\gvy')(\gvC_1\gvCPar\gvtm(\gvC_2\gvCPar\gvC_3\gvtm)):
    \gvR_1\gvCJoin\gvR_2\gvCJoin\gvR_3
  $}
\DP
$$
However, by \Rule{GV-SC-ParAssoc}
$$
  \gvCNew(\gvx\gvx')\gvCNew(\gvy\gvy')(
    \gvC_1\gvCPar\gvtm(\gvC_2\gvCPar\gvC_3\gvtm))
  \gvEquiv
  \gvCNew(\gvx\gvx')\gvCNew(\gvy\gvy')(
    \gvtm(\gvC_1\gvCPar\gvC_2\gvtm)\gvCPar\gvC_3)
$$
The configuration on the right-hand side is not typeable, as the left-most parallel composition splits *no* locked channels, and the right-most parallel composition splits *two* locked channels.

Consequently, GV, as well as a significant portion of work based on @LindleyM15:gv's GV, proves some variation of the following proposition, which states that if we break typing before some reduction, we can restore it afterwards.

Proposition {#gv-equiv-repair}.
  ~ If $\gvGG\gvSeq\gvC:\gvR$ and $\gvC\gvEquiv\gvC'$ and $\gvC'\gvEval\gvD'$, then there exists some $\gvD$ such that $\gvD'\gvEquiv\gvD$ and $\gvGG\gvSeq\gvD:\gvR$.

Proof.
  ~ See @Fowler19:thesis [pp. 41-43, Theorem 2].
    @Fowler19:thesis's proof is for a variant of GV *without* link or link threads, but the only rule of structural congruence that breaks typing is \Rule{GV-SC-ParAssoc}.
    Hence, the proof of Theorem 2 trivially extends to the system *with* link and link threads.
    @Fowler19:thesis's proof is stronger, as it restores typing before and after the reduction.

GV's parallel composition is *covertly* a cut, albeit one that leaves the channel *implicit*.[^lm-par-split]
Like cut, parallel composition must split exactly one channel, and, while cut restricts a channel by removing its endpoints from the typing environment, parallel composition restricts a channel by locking its endpoints.
This is just as effective, since there is no way to use the endpoints of a locked channel.
The locking mechanism keeps the endpoints around for the sole purpose of being removed by name restriction, which only adds unnecessary complexity.

To formalise this fact, we define a translation on configuration typing derivations from GV to GV~Cut~, written $\llbracket\cdot\rrbracket_{\gvcutabbrev}$, which removes all lock types from typing environments, removes all name restrictions, and replaces parallel compositions with cuts.
All uses of the rule \Rule{GV-TG-New} are removed:
$$
\left\llbracket
\AXC{$\delta$}\noLine
\UIC{$
  \gvGG,\gvLock{\gvx}{\gvx'}:\gvtyLock{\gvS}
  \gvSeq
  \gvC:\gvR
$}
\RL{\Rule{GV-TG-New}}
\UIC{$
  \gvGG
  \gvSeq
  \gvCNew(\gvx\gvx')\gvC:\gvR
$}
\DP
\right\rrbracket_{\gvcutabbrev}
\quad\defeq\quad
\AXC{$\llbracket\delta\rrbracket_{\gvcutabbrev}$}\noLine
\UIC{$
  \gvGG
  \gvcutSeq
  \gvC:\gvR
$}
\DP
$$
Each use of the rule \Rule{GV-TG-Connect1} is replaced with a use of the rule \Rule{GV-TG-Cut}:
$$
\begin{array}{c}
\left\llbracket
\AXC{$\delta_1$}\noLine
\UIC{$
  \gvGG,\gvx:\gvS
  \gvSeq
  \gvC:\gvR
$}
\AXC{$\delta_2$}\noLine
\UIC{$
  \gvGD,\gvx':\co{\gvS}
  \gvSeq
  \gvD:\gvR'
$}
\RL{\Rule{GV-TG-Connect1}}
\BIC{$
  \gvGG,\gvGD,\gvLock{\gvx}{\gvx'}:\gvtyLock{\gvS}
  \gvSeq
  \gvC\gvCPar\gvD:\gvR\gvCJoin\gvR'
$}
\DP
\right\rrbracket_{\gvcutabbrev}
\\[2.5em]
\rotatebox[origin=c]{270}{$\defeq$}%
\\[0.5em]
\AXC{$\llbracket\delta_1\rrbracket_{\gvcutabbrev}$}\noLine
\UIC{$
  \gvGG,\gvx:\gvS
  \gvcutSeq
  \gvC:\gvR
$}
\AXC{$\llbracket\delta_2\rrbracket_{\gvcutabbrev}$}\noLine
\UIC{$
  \gvGD,\gvx':\co{\gvS}
  \gvcutSeq
  \gvD:\gvR'
$}
\RL{\Rule{GV-TG-Cut}}
\BIC{$
  \gvGG,\gvGD
  \gvcutSeq
  \gvCNew(\gvx\gvx')(\gvC\gvCPar\gvD):\gvR\gvCJoin\gvR'
$}
\DP
\end{array}
$$
The translation acts as the identity on threads, terms, and types.
We believe that the translation preserves reduction, but proving this matter would be tedious and not worthwhile.
The intuition is that, under the translation $\llbracket\cdot\rrbracket_{\gvcutabbrev}$, any use of \Rule{GV-SC-LinkComm} is preserved, any use of \Rule{GV-SC-ParComm} becomes \Rule{GV-SC-CutComm}, and all uses of \Rule{GV-SC-NewAssoc}, \Rule{GV-SC-NewSwap}, or \Rule{GV-SC-ScopeExt} become reflexivity.
The tedious part is the proof that all type breaking uses of \Rule{GV-SC-ParAssoc} are repaired in such a way that the source and target can be proven equivalent using \Rule{GV-SC-CutAssoc}. The structure of this proof depends heavily on the computational content of the proof that repairs ill-typed configurations.

[^lm-lock-typing]: Technically, the presentation of GV in @separating-sessions-smoothly adds $\gvtyLock{\gvS}$ as a runtime session type, rather than as part of a special type assignment. Nonetheless, the two presentations are equivalent. Lock types cannot occur in user programs, and so cannot occur as part of any other type. Hence, they already occur only as the top-most connective in a type assignment.
[^lm-par-split]: Tellingly, @LindleyM15:gv [{}§ 3.3] write "$\parallel_{x}$" when they need the channel name.
