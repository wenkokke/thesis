# Multiset CP {#hcp-multiset-cp}

```{=latex}
\hpset0%
```

In this section, I define Multiset CP.
At several points in this chapter, I have mentioned that an HCP process corresponds to a multiset of CP processes.
However, I have found that it is tedious to relate HCP directly to multisets of CP processes, and much clearer to relate it to another session-typed processes calculus which captures that notion.
Multiset CP is that calculus.
Its processes are multisets of unconnected CP processes, presented using process notation.
Its processes are typed under hyper-environments, which are multisets of CP typing environments.
Its typing derivation, structural congruence, and reduction relations are all some sort of pointwise lifting of the corresponding CP relations.
(I will not abbreviate Multiset CP, and continue to write it in full, to avoid confusion with Multiparty CP [MCP, @CarboneLMSW16:mcp].)

To avoid syntax highlighting whiplash between sections, the terms and types of *both* Multiset CP and CP are printed in $\tmsecondaryname$ and $\tysecondaryname$, respectively, both are rendered in an italicised font with serif, and any relations, such as typing and reduction, are marked by subscript "$\mpabbrev$" or "$\cpabbrev$", respectively.

The processes of Multiset CP are the parallel composition of CP processes, as defined by the following grammar:
$$
  \mpP,\mpQ,\mpR \Coloneq \cpP \mid \mpZ \mid \mpP\mpPar\mpQ
$$
The metavariables $\mpP$, $\mpQ$, and $\mpR$ refer to Multiset CP processes, and the metavariables $\cpP$, $\cpQ$, and $\cpR$ refer to CP processes, as defined in @cp-classical-processes.
This matches the convention to use the calligraphic font for multisets.

Multiset CP's parallel composition and terminated process may only occur at the top-level. The syntax for CP processes is not permitted to recurse back into the syntax for Multiset CP processes. The parallel composition and terminated process that are syntactically part of CP's cut, send, and close constructs are distinct from Multiset CP's parallel composition and terminated process.

Multiset CP has no top-level name restriction. Hence, there is no possibility to connect the individual CP processes, and no possibility for them to communicate amongst each other.

The processes of Multiset CP are equivalent up to structural congruence.
Concretely, the individual CP processes---i.e., the elements of the multiset---are equivalent up to CP's structural congruence, as defined in @cp-classical-processes, and Multiset CP processes---i.e., the multisets themselves---are equivalent up to reordering.
$$
\begin{array}{l@{\;\mpEquiv\;}ll}
  \mpP\mpPar\mpZ
  & \mpP
  & \RuleLabel{M}{SC-ParNil}
  \\
  \mpP\mpPar\mpQ
  & \mpQ\mpPar\mpP
  & \RuleLabel{M}{SC-ParComm}
  \\
  \mpP\mpPar\mptm(\mpQ\mpPar\mpR\mptm)
  & \mptm(\mpP\mpPar\mpQ\mptm)\mpPar\mpR
  & \RuleLabel{M}{SC-ParAssoc}
\end{array}
$$
$$
  \begin{RuleWithLabel}{M}{SC-Embed}
    \AXC{$\cpP\cpEquiv\cpQ$}
    \UIC{$\cpP\mpEquiv\cpQ$}
    \DP
  \end{RuleWithLabel}
  \qquad
  \begin{RuleWithLabel}{M}{SC-ParCong}
    \AXC{$\mpP\mpEquiv\mpP'$}
    \AXC{$\mpQ\mpEquiv\mpQ'$}
    \BIC{$\mpP\mpPar\mpQ\mpEquiv\mpP'\mpPar\mpQ'$}
    \DP
  \end{RuleWithLabel}
$$
In essence, the rules \Rule{M-SC-ParNil}, \Rule{M-SC-ParComm}, and \Rule{M-SC-ParAssoc} ensure the process syntax defines a multiset, and the rules \Rule{M-SC-Embed} and \Rule{M-SC-ParCong} define the universal pointwise lifting of CP's structural congruence to multisets of equal length.
I likewise lift the restricted versions of structural congruence---$\mpEquivS$, $\mpEquivLP$, $\mpEquivLPS$, and $\mpEquivD$---to Multiset CP (see @cp-shallow-structural-congruence for details).

Reduction for Multiset CP processes is the existential pointwise lifting of CP's reduction, i.e., if $\mpP\mpEval\mpQ$, then one of the processes $\cpP\in\mpP$ reduces to one of the processes $\cpQ\in\mpQ$, and all the other processes are preserved up to structural congruence.
$$
  \begin{RuleWithLabel}{M}{E-Embed}
    \AXC{$\cpP\cpEval\cpQ$}
    \UIC{$\cpP\mpEval\cpQ$}
    \DP
  \end{RuleWithLabel}
  \qquad
  \begin{RuleWithLabel}{M}{E-Equiv}
    \AXC{$\mpP \mpEquiv \mpP'$}
    \AXC{$\mpP' \mpEval \mpQ'$}
    \AXC{$\mpQ' \mpEquiv \mpQ$}
    \TIC{$\mpP \mpEval \mpQ$}
    \DP
  \end{RuleWithLabel}
$$
$$
  \begin{RuleWithLabel}{M}{E-ParCong1}[E-ParCong\textsubscript{1}]
    \AXC{$\mpP\mpEval\mpP'$}
    \UIC{$\mpP\mpPar\mpQ\mpEval\mpP'\mpPar\mpQ$}
    \DP
  \end{RuleWithLabel}
  \qquad
  \begin{RuleWithLabel}{M}{E-ParCong2}[E-ParCong\textsubscript{2}]
    \AXC{$\mpQ\mpEval\mpQ'$}
    \UIC{$\mpP\mpPar\mpQ\mpEval\mpP\mpPar\mpQ'$}
    \DP
  \end{RuleWithLabel}
$$
Finally, the typing judgement for Multiset CP uses hyper-environments.
The definition of hyper-environments follows the definition for HCP.
Recall that hyper-environments are multisets of CP typing environments with the additional restriction that endpoint names must be unique across all typing environments.
$$
  \mpHG,\mpHH \Coloneq \mpHOne \mid \mpHG \mpHTens \cpGG
$$
The typing judgement itself is defined, similar to the structural congruence, as the universal pointwise lifting of CP's typing judgement to multisets of equal size.
$$
  \begin{RuleWithLabel}{M}{T-Embed}
    \AXC{$\cpP\cpSeq\cpGG$}
    \UIC{$\cpP\mpSeq\cpGG$}
    \DP
  \end{RuleWithLabel}
  \qquad
  \begin{RuleWithLabel}{M}{T-Par}
    \AXC{$\vphantom{\mpP}$}
    \UIC{$\mpZ\mpSeq\mpHOne$}
    \DP
  \end{RuleWithLabel}
  \qquad
  \begin{RuleWithLabel}{M}{T-Halt}
    \AXC{$\mpP\mpSeq\mpHG$}
    \AXC{$\mpQ\mpSeq\mpHH$}
    \BIC{$\mpP\mpPar\mpQ\mpSeq\mpHG\mpHTens\mpHH$}
    \DP
  \end{RuleWithLabel}
$$
The metatheory for Multiset CP can be constructed from the metatheory for CP, borrowing the occasional bit from Hypersequent CP.
(I only discuss preservation and progress, but these should suffice to reassure the reader of that claim.)

Preservation follows from CP's preservation proofs (@lemma:cp-preservation-equiv and @proposition:cp-preservation), and the additional cases for the new rules follow those from HCP's preservation proofs (@lemma:hcp-preservation-equiv and @proposition:hcp-preservation).

Lemma {#mcp-preservation-equiv}.
  ~ If $\mpP\mpEquiv\mpQ$,
    then $\mpP\mpSeq\mpHG$ if and only if $\mpQ\mpSeq\mpHG$.

Proposition (Preservation) {#mcp-preservation}.
  ~ If $\mpP\mpSeq\mpHG$ and $\mpP\mpEval\mpQ$,
    then $\mpQ\mpSeq\mpHG$.

Canonical form and progress are lifted directly from CP.
A Multiset CP process is in canonical form when each CP process is in canonical form, and progress follows by pointwise application of CP's progress [@proposition:cp-progress].

Definition (Canonical Form) {#mcp-canonical-form}.
  ~ A process $\mpP$ is in *canonical form* when each CP process $\cpP\in\mpP$ is in CP's canonical form [@definition:cp-canonical-form].

Proposition (Progress) {#mcp-progress}.
  ~ If $\mpP\mpSeq\mpHG$,
    then either $\mpP$ is in canonical form, or
    there exists some $\mpQ$ such that $\mpP\mpEval\mpQ$.

I sketched the correspondence between Multiset CP and CP in the introduction to this section. \Cref{proposition:mcp-typing-cp,proposition:mcp-equiv-cp,proposition:mcp-eval-cp} formalise it. The proof of each proposition follows by induction.
I believe the verbosity of these statements illustrates the advantage of working with Multiset CP over working directly with multisets of CP processes.

Multiset CP's typing relation is the universal pointwise lifting of CP's typing relation, i.e., a Multiset CP process is well-typed if each individual CP process is well-typed under one of the typing environments.

Proposition {#mcp-typing-cp}.
  ~ If $\mpP\mpSeq\mpHG$, then there is an isomorphism $f:\mpP\to\mpHG$ between the elements of the multisets $\mpP$ and $\mpHG$ such that $\cpP \cpSeq f(\cpP)$ for every $\cpP\in\mpP$ and $f^{-1}(\cpGG) \cpSeq \cpGG$ for every $\cpGG\in\mpHG$.

Multiset CP's structural congruence is the universal pointwise lifting of the CP's structural congruence, i.e., one Multiset CP process is equivalent to another if each individual CP process in the one is equivalent to one in the other.

Proposition {#mcp-equiv-cp}.
  ~ If $\mpP\mpEquiv\mpQ$, then there is an isomorphism $f:\mpP\to\mpQ$ between the elements of the multisets $\mpP$ and $\mpQ$ such that $\cpP \cpEquiv f(\cpP)$ for every $\cpP\in\mpP$ and $f^{-1}(\cpQ) \cpEquiv \cpQ$ for every $\cpQ\in\mpQ$.

Multiset CP's reduction is the existential pointwise lifting of CP's reduction, i.e., one Multiset CP process reduces to another if one of its component CP processes reduces to one in the other, and all other component CP processes are preserved.

Proposition {#mcp-eval-cp}.
  ~ If $\mpP\mpEval\mpQ$, then there is exactly one pair of processes $(\cpP,\cpQ)\in\mpP\times\mpQ$ such that $\cpP\cpEval\cpQ$, and an isomorphism $f:\mpP'\to\mpQ'$ between the remaining elements of the multisets, $\mpP'=\mpP-\lbag\cpP\rbag$ and $\mpQ'=\mpQ-\lbag\cpQ\rbag$,
  such that $\cpP' \cpEquiv f(\cpP')$ for every $\cpP'\in\mpP'$ and $f^{-1}(\cpQ') \cpEquiv \cpQ'$ for every $\cpQ'\in\mpQ'$.

```{=latex}
\hpset1%
```
