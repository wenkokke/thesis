# Relation to Classical Processes {#pcp-relation-to-cp}

```{=latex}
\shset0%
\ppset1%
\gvset1%
```

One notable omission in the literature is any proof that Priority CP is an extension of CP or that Priority CLL (PLL) is an extension of CLL.
To discuss this matter formally, we must define what we mean by "extension".
What does it mean for one system to extend another?
We consider two options:

- If PLL extends the *proofs* of CLL,
  any valid CLL proof is a valid PLL proof,
  and any well-typed CP process is a well-typed PCP process.
- If PLL extends the *theorems* of CLL,
  any proposition provable in CLL is provable in PLL,
  and any type inhabited in CP is inhabited in PCP.

An extension of the *proofs* is a much stronger notion than an extension of the *theorems*, and, from the perspective of a process calculus, it is much more useful. Unfortunately, the stronger notion does not hold, as we discuss shortly.
At the time of writing, I do not know if the weaker notion---an extension of theorems---holds.

The question is complicated by the priority annotations.
What does it mean for a CLL proposition to be provable in PLL?
Does it suffice if the proposition is provable with *some* priority assignment?
Or should it be provable with *every* priority assignment?
Priorities leak a fair amount of the structure of the underlying proof.
For instance, any proposition where the priorities decrease as we descend into the proposition is unprovable, other than by absurdity or the axiom, e.g., there is no proof of (a) even though there is a proof of (b):
$$
\text{(a)}\;
\ppSeq/\ppOne^{\pppr{1}}\ppTens^{\pppr{3}}\ppOne^{\pppr{2}}
\qquad
\text{(b)}\;
\ppSeq \ppOne^{\pppr{2}}\ppTens^{\pppr{1}}\ppOne^{\pppr{3}}
$$
Hence, it would seem overly strict to require that a CLL proposition must be provable in PLL with *every* priority assignment.

## PCP Conflates Tensor and Par {#pcp-conflates-tensor-and-par}

As @DardhaG18:pcp discuss, PLL admits \Rule{CLL-Mix} and \Rule{CLL-Mix0}, under the names \Rule{P-T-Par} and \Rule{P-T-Halt}.
Consequently, it conflates one/bottom and partially conflates tensor/par
$$
  \ppOne^{\ppp}
  \ppBiImpl^{\ppo}
  \ppBot^{\ppq}
  \quad\text{and}\quad
  \ppA\ppTens^{\ppp}\ppB
  \ppImpl^{\ppo}
  \ppA\ppParr^{\ppq}\ppB
$$
For instance, the conversion of tensor to par holds by the following derivations, which hold as long as $\ppo < \ppp,\ppq$ and either $\ppp < \ppq$ or $\ppq < \ppp$.
$$
\AXC{}\UIC{$\ppSeq\co{\ppA},\ppA$}
\AXC{}
\UIC{$\ppSeq\co{\ppB},\ppB$}
\BIC{$\ppSeq\co{\ppA},\co{\ppB},\ppA,\ppB$}
\RL{$\ppq < \pr(\ppA,\ppB)$}
\UIC{$\ppSeq\co{\ppA},\co{\ppB},\ppA\ppParr^{\ppq}\ppB$}
\RL{$\ppp < \ppq$}
\UIC{$\ppSeq\co{\ppA}\ppParr^{\ppp}\co{\ppB},\ppA\ppParr^{\ppq}\ppB$}
\RL{$\ppo < \ppp,\ppq$}
\UIC{$
  \ppSeq
  \co{\ppA}\ppParr^{\ppp}\co{\ppB}
  \ppParr^{\ppo}
  \ppA\ppParr^{\ppq}\ppB
  $}
\UIC{$
  \ppSeq
  \ppA\ppTens^{\ppp}\ppB
  \ppImpl^{\ppo}
  \ppA\ppParr^{\ppq}\ppB
  $}
\DP
\qquad
\AXC{}\UIC{$\ppSeq\co{\ppA},\ppA$}
\AXC{}
\UIC{$\ppSeq\co{\ppB},\ppB$}
\BIC{$\ppSeq\co{\ppA},\co{\ppB},\ppA,\ppB$}
\LL{$\ppp < \pr(\ppA,\ppB)$}
\UIC{$\ppSeq\co{\ppA}\ppParr^{\ppp}\co{\ppB},\ppA,\ppB$}
\LL{$\ppq < \ppp$}
\UIC{$\ppSeq\co{\ppA}\ppParr^{\ppp}\co{\ppB},\ppA\ppParr^{\ppq}\ppB$}
\LL{$\ppo < \ppp,\ppq$}
\UIC{$
  \ppSeq
  \co{\ppA}\ppParr^{\ppp}\co{\ppB}
  \ppParr^{\ppo}
  \ppA\ppParr^{\ppq}\ppB
  $}
\UIC{$
  \ppSeq
  \ppA\ppTens^{\ppp}\ppB
  \ppImpl^{\ppo}
  \ppA\ppParr^{\ppq}\ppB
  $}
\DP
$$
These conflations are the natural consequence of admitting \RuleName{Mix} and \RuleName{Mix0}, even in the absence of priorities.
PLL also admits \RuleName{MultiCut}, which can be derived from \Rule{P-T-Res} and \Rule{P-T-Par}, which fully conflates tensor/par
$$
  \ppA\ppParr^{\ppp}\ppB
  \ppImpl^{\ppo}
  \ppA\ppTens^{\ppq}\ppB
$$
The conversion of par to tensor holds by the following derivations, which hold as long as $\ppo < \ppp,\ppq$ and either $\ppp < \ppq$ or $\ppq < \ppp$.
$$
\AXC{}\UIC{$\ppSeq\co{\ppA},\ppA$}
\AXC{}
\UIC{$\ppSeq\co{\ppB},\ppB$}
\BIC{$\ppSeq\co{\ppA},\co{\ppB},\ppA,\ppB$}
\RL{$\ppq < \pr(\ppA,\ppB)$}
\UIC{$\ppSeq\co{\ppA},\co{\ppB},\ppA\ppTens^{\ppq}\ppB$}
\RL{$\ppp < \ppq$}
\UIC{$\ppSeq\co{\ppA}\ppTens^{\ppp}\co{\ppB},\ppA\ppTens^{\ppq}\ppB$}
\RL{$\ppo < \ppp,\ppq$}
\UIC{$
  \ppSeq
  \co{\ppA}\ppTens^{\ppp}\co{\ppB}
  \ppParr^{\ppo}
  \ppA\ppTens^{\ppq}\ppB
  $}
\UIC{$
  \ppSeq
  \ppA\ppParr^{\ppp}\ppB
  \ppImpl^{\ppo}
  \ppA\ppTens^{\ppq}\ppB
  $}
\DP
\qquad
\AXC{}\UIC{$\ppSeq\co{\ppA},\ppA$}
\AXC{}
\UIC{$\ppSeq\co{\ppB},\ppB$}
\BIC{$\ppSeq\co{\ppA},\co{\ppB},\ppA,\ppB$}
\LL{$\ppp < \pr(\ppA,\ppB)$}
\UIC{$\ppSeq\co{\ppA}\ppTens^{\ppp}\co{\ppB},\ppA,\ppB$}
\LL{$\ppq < \ppp$}
\UIC{$\ppSeq\co{\ppA}\ppTens^{\ppp}\co{\ppB},\ppA\ppTens^{\ppq}\ppB$}
\LL{$\ppo < \ppp,\ppq$}
\UIC{$
  \ppSeq
  \co{\ppA}\ppTens^{\ppp}\co{\ppB}
  \ppParr^{\ppo}
  \ppA\ppTens^{\ppq}\ppB
  $}
\UIC{$
  \ppSeq
  \ppA\ppParr^{\ppp}\ppB
  \ppImpl^{\ppo}
  \ppA\ppTens^{\ppq}\ppB
  $}
\DP
$$
In CLL, tensor and par capture independence and interdependence:

- If $\cpexp2{\cpSeq\cpGG,\cpA\cpTens\cpB}$,
  the resources used by $\cpexp2{\cpA}$ and $\cpexp2{\cpB}$ are independent.
- If $\cpexp2{\cpSeq\cpGD,\cpA\cpParr\cpB}$,
  the resources used by $\cpexp2{\cpA}$ and $\cpexp2{\cpB}$ are interdependent.
  How they depend on one another is unknown, but they are guaranteed to be free from cyclic dependencies.

These are naturally compositional. In $\cpexp2{\cpSeq\cpGD,\cpA\cpParr\cpB}$, we do not know how the resources in $\cpexp2{\cpA}$ and $\cpexp2{\cpB}$ are used, so the only option that is guaranteed to avoid cyclic dependencies is to ensure that in $\cpexp2{\cpSeq\cpGG,\cpA\cpTens\cpB}$ the resources used by $\cpexp2{\cpA}$ and $\cpexp2{\cpB}$ are independent.

PLL's "tensor" and "par" are not truly a tensor and par, and do not capture independence and interdependence.
Morally, they are the same self-dual connective, which may capture either independence or interdependence, but must specify *exactly* if and how its resources interdepend.
The motivation to separate this self-dual connective into two dual connectives, "$\ppTens^\ppo$" and "$\ppParr^\ppo$", comes from the process calculus interpretation, rather than the logic itself, as the separate connectives are used to guarantee session fidelity under the interpretation where "$\ppTens^\ppo$" is send and "$\ppParr^\ppo$" is receive.

## PCP Does Not Extend CP {#pcp-does-not-extend-cp}

The priorities in PCP expose information about the order in which a process uses its resources.
Consequently, the additives in PCP are less expressive than the additives in CP, and, while we have not discussed the exponentials in this thesis, the exponentials in PCP are also less expressive than in CP.

Let us consider the typing rules for the offer in CP and PCP:
$$
\begin{array}{c}
\cpexp2{\cpOFFER*\cpx\cpP\cpQ\cpGG\cpA\cpB\DP}
\\[2em]
\AXC{$\ppP\ppSeq\ppGG,\ppx:\ppA$}
\AXC{$\ppQ\ppSeq\ppGG,\ppx:\ppB$}
\AXC{$\ppo<\pr(\ppGG)$}
\RL{\Rule{P-T-Offer}}
\TIC{$
  \ppOffer\ppx(\ppInl:\ppP;\ppInr:\ppQ)
  \ppSeq
  \ppGG,\ppx:\ppA\ppWith^\ppo\ppB
$}
\DP
\end{array}
$$
The two typing rules ostensibly quite similar, with the only difference being the added priority constraint in PCP's typing rule.
However, recall that, while the processes $\ppP$ and $\ppQ$ may differ in their use of the sessions $\ppA$ and $\ppB$, the priority annotations on the typing environment $\ppGG$ mean that both processes must use all other resources in the exact same order.
CP's type system, on the other hand, imposes no such restriction.

Counterexample (Extension) {#pcp-does-not-extend-cp}.
~ It is not true that every well-typed CP process is a well-typed PCP process.

  For example, the process
  $$
  \cpexp2{\cpOffer\cpa(\cpInl:\cpWait\cpx.\cpWait\cpy.\cpClose\cpa;\cpInr:\cpWait\cpy.\cpWait\cpx.\cpClose\cpa)}
  $$
  is typeable in CP but not PCP.

  In CP, its typing derivation is as follows:
  $$
  \cpexp2{%
  \AXC{}
  \UIC{$\cpClose\cpa\cpSeq\cpa:\cpOne$}
  \UIC{$\cpWait\cpy.\cpClose\cpa\cpSeq\cpy:\cpBot,\cpa:\cpOne$}
  \UIC{$\cpWait\cpx.\cpWait\cpy.\cpClose\cpa\cpSeq\cpx:\cpBot,\cpy:\cpBot,\cpa:\cpOne$}
  \AXC{}
  \UIC{$\cpClose\cpa\cpSeq\cpa:\cpOne$}
  \UIC{$\cpWait\cpx.\cpClose\cpa\cpSeq\cpx:\cpBot,\cpa:\cpOne$}
  \UIC{$\cpWait\cpy.\cpWait\cpx.\cpClose\cpa\cpSeq\cpx:\cpBot,\cpy:\cpBot,\cpa:\cpOne$}
  \BIC{$\cpOffer\cpa(\cpInl:\cpWait\cpx.\cpWait\cpy.\cpClose\cpa;\cpInr:\cpWait\cpy.\cpWait\cpx.\cpClose\cpa)\cpSeq\cpx:\cpBot,\cpy:\cpBot,\cpa:\cpOne\cpWith\cpOne$}
  \DP
  }
  $$
  In PCP, the process is not typeable, because the typing derivation requires that $\ppp<\ppq$ and $\ppq<\ppp$, where $\ppp$ and $\ppq$ are the priorities associated with the actions on $\ppx$ and $\ppy$.
  $$
  \def\defaultHypSeparation{\hskip.025in}
  \AXC{}
  \UIC{$
    \ppClose\ppa
    \ppSeq
    \ppa:\ppOne^{\ppo_1}
  $}
  \AXC{$\ppq<\ppo_1$}
  \BIC{$
    \ppWait\ppy.\ppClose\ppa
    \ppSeq
    \ppy:\ppBot^{\ppq},
    \ppa:\ppOne^{\ppo_1}
  $}
  \AXC{$\ppp<\ppq$}
  \BIC{$
    \ppWait\ppx.\ppWait\ppy.\ppClose\ppa
    \ppSeq
    \ppx:\ppBot^{\ppp},
    \ppy:\ppBot^{\ppq},
    \ppa:\ppOne^{\ppo_2}
  $}
  \AXC{}
  \UIC{$
    \ppClose\ppa
    \ppSeq
    \ppa:\ppOne^{\ppo_2}
  $}
  \AXC{$\ppp<\ppo_2$}
  \BIC{$
    \ppWait\ppx.\ppClose\ppa
    \ppSeq
    \ppx:\ppBot^{\ppp},
    \ppa:\ppOne^{\ppo_1}
  $}
  \AXC{$\ppq<\ppp$}
  \BIC{$
    \ppWait\ppy.\ppWait\ppx.\ppClose\ppa
    \ppSeq
    \ppx:\ppBot^{\ppp},
    \ppy:\ppBot^{\ppq},
    \ppa:\ppOne^{\ppo_2}
  $}
  \BIC{$
    \ppOffer\ppa(
      \ppInl:\ppWait\ppx.\ppWait\ppy.\ppClose\ppa;
      \ppInr:\ppWait\ppy.\ppWait\ppx.\ppClose\ppa
    )
    \ppSeq
    \ppx:\ppBot^{\ppp},
    \ppy:\ppBot^{\ppq},
    \ppa:\ppOne^{\ppo_1}\ppWith^{\ppo}\ppOne^{\ppo_2}
  $}
  \DP
  $$
  Therefore, not every well-typed CP process is a well-typed PCP process.

For the additives, we can partially work around this restriction by combining the entire typing environment into a single type, offering a session of type (omitting the priority annotations on the $\ppParr$'s, to reduce eyestrain)
$$
\ppty(
  \ppBot^{\ppp_1}
  \ppParr
  \ppBot^{\ppp_1}
  \ppParr
  \ppOne^{\ppo_1}
\ppty)
\ppWith^{\ppo}
\ppty(
  \ppBot^{\ppp_2}
  \ppParr
  \ppBot^{\ppq_2}
  \ppParr
  \ppOne^{\ppo_2}
\ppty)
$$
However, this requires a global process transformation and changes the type of the session.

A similar example exists for PCP's exponentials.
We can construct two sessions of type $\ppBot^\ppp\ppParr^\ppo\ppBot^\ppq$ that use the sessions corresponding to $\ppp$ and $\ppq$ in opposite orders, and apply dereliction and contracting the resulting sessions.
The process
$$
\cpexp2{%
\cptm{?}\cpSend{\cpx}{\cpx_1\cptm{,}\cpx_2}.
\cpNew(\cpz\cpz')(
  \cptm{?}\cpSend{\cpx_1}{\cpx}.
  \cpRecv{\cpx}{\cpy}.
  \cpWait{\cpx}.\cpWait{\cpy}.\cpClose\cpz
  \cpPar
  \cptm{?}\cpSend{\cpx_2}{\cpx}.
  \cpRecv{\cpx}{\cpy}.
  \cpWait{\cpy}.\cpWait{\cpx}.\cpWait{\cpz'}.\cpClose\cpa
)}
$$
is well-typed in CP with exponentials, using the typing rules and alternative notation from @Wadler14:cpgv-ext [§ 3.4], reproduced below:
$$
\begin{RuleWithLabel}{C}{T-Derelict}
\cpexp2{%
\AXC{$
  \cpP
  \cpSeq\cpGG,\cpy:\cpA$}
\UIC{$
  \cptm{?}\cpSend\cpx\cpy.\cpP
  \cpSeq\cpGG,\cpx:\cpty{?}\cpA$}
\DP
}
\end{RuleWithLabel}
\qquad
\begin{RuleWithLabel}{C}{T-Contract}
\cpexp2{%
\AXC{$
  \cpP
  \cpSeq\cpGG,\cpx_1:\cpty{?}\cpA,\cpx_2:\cpty{?}\cpA$}
\UIC{$
  \cptm{?}\cpSend\cpx{\cpx_1\cptm{,}\cpx_2}.\cpP
  \cpSeq\cpGG,\cpx:\cpty{?}\cpA$}
\DP
}
\end{RuleWithLabel}
$$
However, it is not typeable in PCP, using the typing rules from @DardhaG18:pcp [Figure 2], as typing derivation requires that $\ppp<\ppq$ and $\ppq<\ppp$, reproduced below:
$$
\begin{RuleWithLabel}{P}{T-Derelict}
\def\defaultHypSeparation{\hskip.025in}
\AXC{$
  \vphantom{?^o}%strut
  \ppP
  \ppSeq\ppGG,\ppy:\ppA$}
\AXC{$\ppo<\pr(\ppGG)$}
\BIC{$
  \pptm{?}\ppSend\ppx\ppy.\ppP
  \ppSeq\ppGG,\ppx:\ppty{?}^{\ppo}\ppA$}
\DP
\end{RuleWithLabel}
\quad
\begin{RuleWithLabel}{P}{T-Contract}
\def\defaultHypSeparation{\hskip.025in}
\AXC{$
  \ppP
  \ppSeq\ppGG,\ppx_1:\ppty{?}^{\ppo_1}\ppA,\ppx_2:\ppty{?}^{\ppo_2}\ppA$}
\AXC{$\ppo\leq\ppo_1$}
\AXC{$\ppo\leq\ppo_2$}
\AXC{$\ppo<\pr(\ppGG)$}
\QIC{$
  \pptm{?}\ppSend\ppx{\ppx_1\pptm{,}\ppx_2}.\ppP
  \ppSeq\ppGG,\ppx:\ppty{?}^{\ppo}\ppA$}
\DP
\end{RuleWithLabel}
$$
This restriction might be worked around to some extent by using the additives to encode the different usages of the typing environment and the duplicated session. However, this requires a global process transformation, and changes the type of the session.

## PGV Does Not Extend GV {#pgv-does-not-extend-gv}

The counterexample to extension given for CP and PCP in the previous section is easily adapted to provide a counterexample to extension for GV and PGV.

Counterexample (Extension) {#pgv-does-not-extend-gv}.
  ~ It is not true that every well-typed GV term is a well-typed PGV term.
    ```{=latex}
    \gvset2%
    ```
    For example, the term
    $$
    \!\!
    \begin{array}{l}
      \gvCase\gvx(\gvInl\gvx:\gvx\gvAndThen\gvM;\gvInr\gvx:\gvx\gvAndThen\gvN)
      \\
      \quad
      \text{where}
      \\
      \quad\quad
      \!\!
      \begin{array}{l@{\;\defeq\;}l}
      \gvM &
        \gvWait\gvApp\gvy\gvAndThen
        \gvWait\gvApp\gvz
      \\
      \gvN &
        \gvWait\gvApp\gvz\gvAndThen
        \gvWait\gvApp\gvy
      \end{array}
    \end{array}
    $$
    is typeable in GV but not in PGV.
    ```{=latex}
    \gvset2%
    ```
    In GV, using the typing rules in \hyperlink{paper:separating-sessions-smoothly.5}{Figure I.2}, its typing derivation is as follows.
    (In the following derivation, the premises for \Rule{HGV-TM-App} are stacked and the first premise of \Rule{HGV-TM-LetUnit} is omitted.)
    $$
    \AXC{$\vdots$}
    \noLine
    \UIC{$
      \gvy:\gvtyEnd?,
      \gvz:\gvtyEnd?
      \gvSeq
      \gvM:\gvtyUnit
    $}
    \UIC{$
      \gvx:\gvtyUnit,
      \gvy:\gvtyEnd?,
      \gvz:\gvtyEnd?
      \gvSeq
      \gvx\gvAndThen\gvM:\gvtyUnit
    $}
    \AXC{$\vdots$}
    \noLine
    \UIC{$
      \gvy:\gvtyEnd?,
      \gvz:\gvtyEnd?
      \gvSeq
      \gvN:\gvtyUnit
    $}
    \UIC{$
      \gvx:\gvtyUnit,
      \gvy:\gvtyEnd?,
      \gvz:\gvtyEnd?
      \gvSeq
      \gvx\gvAndThen\gvN:\gvtyUnit
    $}
    \BIC{$
      \gvx:\gvtyUnit\gvtySum\gvtyUnit,
      \gvy:\gvtyEnd?,
      \gvz:\gvtyEnd?
      \gvSeq
      \gvCase\gvx(\gvInl\gvx:\gvx\gvAndThen\gvM;\gvInr\gvx:\gvx\gvAndThen\gvN)
      :\gvtyUnit
    $}
    \DP
    $$
    where the typing derivations for $\gvM$ and $\gvN$ are
    $$
    \AXC{}
    \UIC{$
      \gvSeq
      \gvWait:\gvtyEnd?\gvtyFun\gvtyUnit
    $}
    \noLine
    \UIC{$
      \gvy:\gvtyEnd?
      \gvSeq
      \gvy:\gvtyEnd?
    $}
    \UIC{$
      \gvy:\gvtyEnd?
      \gvSeq
      \gvWait\gvApp\gvy:\gvtyUnit
    $}
    \AXC{}
    \UIC{$
      \gvSeq
      \gvWait:\gvtyEnd?\gvtyFun\gvtyUnit
    $}
    \noLine
    \UIC{$
      \gvz:\gvtyEnd?
      \gvSeq
      \gvz:\gvtyEnd?
    $}
    \UIC{$
      \gvz:\gvtyEnd?
      \gvSeq
      \gvWait\gvApp\gvz:\gvtyUnit
    $}
    \BIC{$
      \gvy:\gvtyEnd?,
      \gvz:\gvtyEnd?
      \gvSeq
      \gvM:\gvtyUnit
    $}
    \DP
    $$
    and
    $$
    \AXC{}
    \UIC{$
      \gvSeq
      \gvWait:\gvtyEnd?\gvtyFun\gvtyUnit
    $}
    \noLine
    \UIC{$
      \gvz:\gvtyEnd?
      \gvSeq
      \gvz:\gvtyEnd?
    $}
    \UIC{$
      \gvz:\gvtyEnd?
      \gvSeq
      \gvWait\gvApp\gvz:\gvtyUnit
    $}
    \AXC{}
    \UIC{$
      \gvSeq
      \gvWait:\gvtyEnd?\gvtyFun\gvtyUnit
    $}
    \noLine
    \UIC{$
      \gvy:\gvtyEnd?
      \gvSeq
      \gvy:\gvtyEnd?
    $}
    \UIC{$
      \gvy:\gvtyEnd?
      \gvSeq
      \gvWait\gvApp\gvy:\gvtyUnit
    $}
    \BIC{$
      \gvy:\gvtyEnd?,
      \gvz:\gvtyEnd?
      \gvSeq
      \gvN:\gvtyUnit
    $}
    \DP
    $$
    respectively.
    ```{=latex}
    \gvset1%
    ```
    In PGV, using the typing rules in \hyperlink{paper:prioritise-the-best-variation.9}{Figure II.2}, its typing derivation is as follows.
    (In the following derivation, the premises for \Rule{PGV-T-App} are stacked and the first premise of \Rule{PGV-T-LetUnit} is omitted.)
    $$
    \AXC{$\vdots$}
    \noLine
    \UIC{$
      \gvy:\gvtyEnd?[\gvp],
      \gvz:\gvtyEnd?[\gvq]
      \gvSeq[\gvp\gvMax\gvq]
      \gvM:\gvtyUnit
    $}
    \UIC{$
      \gvx:\gvtyUnit,
      \gvy:\gvtyEnd?[\gvp],
      \gvz:\gvtyEnd?[\gvq]
      \gvSeq[\gvp\gvMax\gvq]
      \gvx\gvAndThen\gvM:\gvtyUnit
    $}
    \AXC{$\vdots$}
    \noLine
    \UIC{$
      \gvy:\gvtyEnd?[\gvp],
      \gvz:\gvtyEnd?[\gvq]
      \gvSeq[\gvp\gvMax\gvq]
      \gvN:\gvtyUnit
    $}
    \UIC{$
      \gvx:\gvtyUnit,
      \gvy:\gvtyEnd?[\gvp],
      \gvz:\gvtyEnd?[\gvq]
      \gvSeq[\gvp\gvMax\gvq]
      \gvx\gvAndThen\gvN:\gvtyUnit
    $}
    \BIC{$
      \gvx:\gvtyUnit\gvtySum\gvtyUnit,
      \gvy:\gvtyEnd?[\gvp],
      \gvz:\gvtyEnd?[\gvq]
      \gvSeq[\gvp\gvMax\gvq]
      \gvCase\gvx(\gvInl\gvx:\gvx\gvAndThen\gvM;\gvInr\gvx:\gvx\gvAndThen\gvN)
      :\gvtyUnit
    $}
    \DP
    $$
    where the typing derivations for $\gvM$ and $\gvN$ are
    $$
    \AXC{}
    \UIC{$
      \gvSeq[\gvBot]
      \gvWait:\gvtyEnd?[\gvp]\gvtyFun[\gvTop,\gvp]\gvtyUnit
    $}
    \noLine
    \UIC{$
      \gvy:\gvtyEnd?[\gvp]
      \gvSeq[\gvBot]
      \gvy:\gvtyEnd?[\gvp]
    $}
    \UIC{$
      \gvy:\gvtyEnd?[\gvp]
      \gvSeq[\gvp]
      \gvWait\gvApp\gvy:\gvtyUnit
    $}
    \AXC{}
    \UIC{$
      \gvSeq[\gvBot]
      \gvWait:\gvtyEnd?[\gvq]\gvtyFun[\gvTop,\gvq]\gvtyUnit
    $}
    \noLine
    \UIC{$
      \gvz:\gvtyEnd?[\gvq]
      \gvSeq[\gvBot]
      \gvz:\gvtyEnd?[\gvq]
    $}
    \UIC{$
      \gvz:\gvtyEnd?[\gvq]
      \gvSeq[\gvq]
      \gvWait\gvApp\gvz:\gvtyUnit
    $}
    \AXC{$\gvp<\gvq$}
    \TIC{$
      \gvy:\gvtyEnd?[\gvp],
      \gvz:\gvtyEnd?[\gvq]
      \gvSeq[\gvp\gvMax\gvq]
      \gvM:\gvtyUnit
    $}
    \DP
    $$
    and
    $$
    \AXC{}
    \UIC{$
      \gvSeq[\gvBot]
      \gvWait:\gvtyEnd?[\gvq]\gvtyFun[\gvTop,\gvq]\gvtyUnit
    $}
    \noLine
    \UIC{$
      \gvz:\gvtyEnd?[\gvq]
      \gvSeq[\gvBot]
      \gvz:\gvtyEnd?[\gvq]
    $}
    \UIC{$
      \gvz:\gvtyEnd?[\gvq]
      \gvSeq[\gvq]
      \gvWait\gvApp\gvz:\gvtyUnit
    $}
    \AXC{}
    \UIC{$
      \gvSeq[\gvBot]
      \gvWait:\gvtyEnd?[\gvp]\gvtyFun[\gvTop,\gvp]\gvtyUnit
    $}
    \noLine
    \UIC{$
      \gvy:\gvtyEnd?[\gvp]
      \gvSeq[\gvBot]
      \gvy:\gvtyEnd?[\gvp]
    $}
    \UIC{$
      \gvy:\gvtyEnd?[\gvp]
      \gvSeq[\gvp]
      \gvWait\gvApp\gvy:\gvtyUnit
    $}
    \AXC{$\gvq<\gvp$}
    \TIC{$
      \gvy:\gvtyEnd?[\gvp],
      \gvz:\gvtyEnd?[\gvq]
      \gvSeq[\gvp\gvMax\gvq]
      \gvN:\gvtyUnit
    $}
    \DP
    $$
    respectively, which require that $\gvp<\gvq$ and $\gvq<\gvp$, respectively, where $\gvp$ and $\gvq$ are the priorities associated with the actions on $\gvy$ and $\gvz$, respectively.

    Therefore, not every well-typed GV term is a well-typed PGV term.

There is no corresponding counterexample for the exponentials, since the presentation of PGV in \Cref{paper:prioritise-the-best-variation} omits the exponentials. However, any variant of PGV that introduces replication, following the work by @LindleyM15:gv and @DardhaG18:pcp, without any further changes, would certainly admit such an example.

## My Priorities Leave Me No Choice

What is the issue with priorities that causes PCP and PGV to be non-extensions of CP and GV, respectively?

The priorities impose a linear order in which a collection of resources is to be used.
For instance, under the typing environment $\ppx:\ppA^{\pppr{1}},\ppy:\ppB^{\pppr{2}}$, the resource $\ppx$ must be used first and the resource $\ppy$ must be used second.
When the same typing environment is shared by different branches in a program, as is the case for the additives and the exponentials, each branch is required to use those resources in the same order, which fundamentally limits the expressiveness of branching.
The structure offered by the ordering on priorities---which are the natural numbers extended with a lower and upper bound---is insufficient to capture different uses across branches.

To address this issue, we would have to extend the structure of priorities to be able to capture branching, e.g., by adding branching structure to the priorities, or by marking constraints by the choices under which they must hold.
Any solution would likely be closely related to the introduction of proof-boxes in the proof nets for linear logic [@Girard87:ll, p. 43].

On the other side, since the issue is that it is not generally possible to impose a linear order on processes with branching, this is a good indication that priorities *do* extend the multiplicative fragment of linear logic, as well as the fragment with fixed points [e.g., @LindleyM16:recgv], since neither introduces branching.

## Identity Expansion Fails For Priority CP

The type system for PCP does not satisfy identity expansion.

Counterexample (Identity Expansion) {#pcp-identity-expansion}.
  ~ It is not true that, if there exists a proof of $\ppSeq\ppGG$ that uses \Rule{P-T-Link}, then there exists a proof of $\ppSeq\ppGG$ that does not use \Rule{P-T-Link}.

    For example, given the following proof
    $$
    \AXC{}
    \RL{\Rule{P-T-Link}}
    \UIC{$
      \ppSeq
      \ppOne^{\pppr{1}}\ppTens^{\pppr{3}}\ppOne^{\pppr{2}},
      \ppBot^{\pppr{1}}\ppParr^{\pppr{3}}\ppBot^{\pppr{2}}
    $}
    \DP
    $$
    there exists no proof with the same conclusion that does not use \Rule{P-T-Link}.

The reason is that PCP's type system omits certain constraints that are, generally speaking, syntactically impossible to violate.
For instance, the typing rule \Rule{P-T-Recv} introduces the type $\ppA\ppParr^{\ppo}\ppB$, but does not require that $\ppo$ is smaller than the priorities on $\ppA$ and $\ppB$.
This constraint is not required, since a process that uses an endpoint of type $\ppA^{\pppr{1}}\ppParr^{\pppr{3}}\ppB^{\pppr{2}}$ would have to act on the endpoint of type $\ppA^{\pppr{1}}$ before receiving it.
I refer to these constraints as the *priority tree* of a type, since they capture the tree structure of the type.
For instance, for the type $\ppA^\ppp\ppParr^\ppo\ppB^\ppq$, the priority tree contains the constraints $\ppo<\ppp$ and $\ppo<\ppq$ and all constraints imposed by the structure of $\ppA$ and $\ppB$.
The priority tree of a type, written $\prTree{\ppA}$, is a set of constraints, defined as follows:
$$
\begin{array}{l@{\;\defeq\;}l}
  \prTree{\ppA\ppTens^{\ppo}\ppB},
  \prTree{\ppA\ppParr^{\ppo}\ppB},
  \prTree{\ppA\ppPlus^{\ppo}\ppB},
  \prTree{\ppA\ppWith^{\ppo}\ppB}
  & \{\ppo<\pr(\ppA),\ppo<\pr(\ppB)\}\cup\prTree{\ppA}\cup\prTree{\ppB}
  \\
  \prTree{\ppOne^{\ppo}},
  \prTree{\ppBot^{\ppo}},
  \prTree{\ppNil^{\ppo}},
  \prTree{\ppTop^{\ppo}}
  & \emptyset
\end{array}
$$
PCP's type system omits the constraints in the priority tree for all types.
This includes the types introduced by links and absurd offers.
Unfortunately, the syntactic argument does not apply in these cases.
Consequently, PCP's type system allows links, such as the process in @counterexample:pcp-identity-expansion, whose priorities violate the constraints imposed by the priority trees.
Since no process, other than the link and the absurd offer, can introduce such types, these links are, in essence, dead, as they can only ever be connected to other links or absurd offers, and, as mentioned, they do not satisfy identity expansion.

To address this issue, I conjecture that it suffices to require that the constraints in priority tree for all types introduced by links and absurd offers must hold.
