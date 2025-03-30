# Hypersequent Classical Processes {#hcp}

```{=latex}
\shset0%
\hpset1%
\piset2%
\lpiset2%
```

This chapter presents Hypersequent Classical Processes (HCP), a session-typed process calculus based on CP as presented in @cp.
Nonetheless, the definitions, statements, and proofs in this chapter are self-contained, and do not reference those in @cp, except where the goal is to relate CP and HCP.

HCP was independently developed by myself and by Fabrizio Montesi & Marco Peressotti [see @MontesiP18:ct]. Upon finding out about this parallel development, we collaborated on HCP, and published two versions:

- *Taking Linear Logic Apart* at Linearity-TLLA'18 [@KokkeMP19:hcp]

  The paper presents HCP as presented in this chapter.
  Unfortunately, the published version contains errors and uses notation and naming conventions that do not match later publications, so I have chosen not to include it in this thesis.[^hcp-errata]

  The paper refers to the calculus as HCP^-^, rather than HCP, to distinguish it from the version below.

- *Better Late Than Never* at POPL'19 [@KokkeMP19:dhcp]

  The paper presents Delayed HCP, which extends HCP with non-blocking actions.
  DHCP is not presented in this thesis.

  The paper refers to the calculus as HCP, rather than DHCP, as we believed *at the time* that DHCP would be the preferred version.
  The authors have since changed their minds.
  I use HCP to refer to the version *without* delayed actions.
  @MontesiP:piLL use the name πLL instead of HCP[^piLL].

HCP's main innovation is its type system, which lets us safely separate name restriction and parallel composition. Consequently, HCP more closely resembles the π-calculus and is more amenable to standard behavioural theory.
Before we delve into the details, let us examine HCP at a glance, and investigate how it relates to Classical Processes, Classical Linear Logic [CLL, @Girard87:ll], and the π-calculus [@MilnerPW92:pi-2].

In this chapter, HCP's processes are printed in $\tmprimaryname$, and its types are printed in $\typrimaryname$, and both are rendered in a sans-serif font.
To save on accessible colour combinations, the terms and types of *any other system* are printed in $\tmsecondaryname$ and $\tysecondaryname$, respectively, both are rendered in an italicised font with serif, and any relations, such as typing and reduction, are marked by a subscript.

*How does HCP relate to CP?*
The primary difference between CP and HCP is that HCP has a standalone process construct for parallel composition, whereas CP bakes parallel composition into the constructs for name restriction and sending---i.e., $\hpNew(\hpx\hpx')\hpP$, $\hpSend\hpx\hpy.\hpP$, and $\hpP\hpPar\hpQ$ versus $\cpexp2{\cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)}$ and $\cpexp2{\cpSend\cpx\cpy.(\cpP\cpPar\cpQ)}$.
Likewise, HCP has a standalone process construct for the terminated process, which CP bakes into the construct for channel closing---i.e., $\hpClose\hpx.\hpP$ and $\hpZ$ versus $\cpexp2{\cpClose\cpx.\cpZ}$.

To match the decomposition of processes, HCP decomposes its typing rules, and adds new typing rules for parallel composition and the terminated process:
$$
  \hpPAR*\hpP\hpQ\hpHG\hpHH\DP
  \qquad
  \hpHALT*\DP
$$
To ensure that the properties of CP are preserved, only channel endpoints held by different processes are safe to connect.
To this end, HCP adds the structural connectives "$\hpHTens$" and "$\hpHOne$" which separate channel endpoints into groups corresponding to the processes that hold them.
(Note that "$\hpHOne$" is distinct from the empty typing environment "$\hpSBot$".)

Why are parallel composition and the terminated process typed by structural connectives rather than logical connectives?
A channel endpoint is typed by a session type, and a process is typed by a typing environment that maps each free endpoint to its session type.
An action acts on an endpoint, so the typing rules for actions are naturally the logical rules for some logical connective.
However, parallel composition acts on processes and the terminated process simply is a process, so their typing rules must be structural rules for some structural connectives.

To match the decomposition of processes, HCP also decompose the rules of its structural congruence, which become the standard rules for the π-calculus---such as associativity and commutativity for parallel composition, the unit laws for the terminated process, and scope extrusion.
The reduction rules of HCP are exactly the same as those of CP.

I defer detailed discussion of the relation between HCP and CP to @hcp-metatheory. There we will see that HCP is a calculus for analysing collections of CP-like processes, and that HCP connection graphs are forests, rather than trees.

*How does HCP relate to Classical Linear Logic?*
The crucial property of CP is its *exact* correspondence to linear logic.
If you erase all that's written in red from the typing rules of CP, you get the inference rules of CLL, as given by @Girard87:ll.
Certainly, as HCP changes those typing rules, it must weaken that correspondence.
I argue that it does the best possible job of preserving the property.

HCP is a conservative extension of CP.
The corresponding logic, HCLL, is a conservative extension of CLL.
Any CLL proof is an HCLL proof, and HCLL proves no new theorems about existing connectives. Formally,
$$
  \cpexp2{\cpSeq\cpGG}
  \iff
  \hpSeq\hpGG
$$
where $\cpexp2{\cpSeq\cpGG}$ and $\hpSeq\hpGG$ denote sequents in CLL and HCLL, respectively.

HCLL extends CLL with the ability to reason about multiple unrelated proofs using *hypersequents* [@Pottinger83:hypersequents;@Avron91:hypersequents]. (Hence, Hypersequent CP.)
A hypersequent logic has judgements over finite multisets of sequents, rather than single sequents. Avron writes hypersequents as:
$$
  \Gamma_1\vdash\Delta_1
  \mathrel{\vert}
  \dots
  \mathrel{\vert}
  \Gamma_n\vdash\Delta_n
$$
As CLL and HCLL use one-sided sequents, the turnstile is somewhat superfluous, merely serving to remind us of the polarity of the typing environment, i.e., that commas are structurally pars rather than tensors.
Frankly, the turnstile remains in CP only because *something* must separate the process and its typing environment and the colon is already taken.
Hence, we might as well use the familiar turnstile. It looks pleasing and it reminds us of the polarity to boot.
If we were to use @Avron91:hypersequents's notation for hypersequents, we would find ourselves writing the turnstile over and over. Worse, the turnstile would lose its primary function---to stand between a process and its typing environment.
Instead, I present HCLL as a logic over finite multisets of *environments*, where environments are multisets of formulas.
I refer to multisets of environments as *hyper-environments*.
The turnstile keeps its position to the left of the hyper-environment, and continues to serve its primary function of separating term from type, red from blue.
(Nonetheless, we continue to refer to HCLL as a hypersequent calculus.)

Hyper-environments, denoted by $\hpHG$ and $\hpHH$, are multisets of typing environments.
I write $\hpHOne$ for the empty hyper-environment, and $\hpHTens$ for hyper-environment concatenation.
The rules for \Rule{HCLL-H-Tens} and \Rule{HCLL-H-One} are as follows:
$$
  \AXC{$\hpSeq\hpHG$}
  \AXC{$\hpSeq\hpHH$}
  \RightLabel{\RuleLabel{HCLL}[$(\hpHTens)$]{H-Tens}}
  \BIC{$\hpSeq\hpHG\hpHTens\hpHH$}
  \DP
  \qquad
  \AXC{$\vphantom{}$}
  \RightLabel{\RuleLabel{HCLL}[$(\hpHOne)$]{H-One}}
  \UIC{$\hpSeq\hpHOne$}
  \DP
$$
What does a proof of a hyper-environment mean?
A proof of a multiset of typing environments should imply a multiset of disjoint proofs, with one separate proof for each typing environment.
In the larger proof, each of the separate proofs may be entangled---their inference rules mixed together---but each inference rule should belong to exactly one of the separate proofs, and we should be able to disentangle them into a sequence of CLL proofs:
$$
  \AXC{$p$}
  \noLine\UIC{$\vdots$}\noLine
  \UIC{$\hpSeq\hpGG_1\hpHTens\dots\hpHTens\hpGG_n$}
  \DP
  \implies
  \AXC{$p_1$}
  \noLine\UIC{$\vdots$}\noLine
  \UIC{$\hpSeq\hpGG_1$}
  \DP
  ,
  \dots
  ,
  \AXC{$p_n$}
  \noLine\UIC{$\vdots$}\noLine
  \UIC{$\hpSeq\hpGG_n$}
  \DP
$$
There is a deep connection between the logical connective "$\hpTens$", the structural connective "$\hpHTens$", and branching---having multiple premises---in multiplicative inference rules.
All three capture some notion of *disjointness*:

- For branching, the disjointness is immediately apparent.
  Sequent calculus proofs are trees, so the premises are disjoint.
- For the structural connective "$\hpHTens$", the disjointness follows from the disentanglement property stated above.
- For the logical connective "$\hpTens$", the disjointness follows from the splitting theorem [e.g., @Girard87:ll, p. 39, Theorem 2.9.7, for CLL proof nets], which states that a proof of some judgement with subformula $\hpA\hpTens\hpB$ can be decomposed into separate proofs of $\hpA$ and its environment, $\hpB$ and its environment, and a common prefix:
  $$
    \AXC{$p$}
    \noLine\UIC{$\vdots$}\noLine
    \UIC{$\hpSeq\hpGG,\hpC\hpty\lbrack\hpA\hpTens\hpB\hpty\rbrack$}
    \DP
    \implies
    \AXC{$p_1$}
    \noLine\UIC{$\vdots$}\noLine
    \UIC{$\hpSeq\hpGD_1,\hpA$}
    \AXC{$p_2$}
    \noLine\UIC{$\vdots$}\noLine
    \UIC{$\hpSeq\hpGD_2,\hpB$}
    \BIC{$\hpSeq\hpGD_1,\hpGD_2,\hpA\hpTens\hpB$}
    \noLine\UIC{$\vdots$}\noLine
    \UIC{$f$}
    \noLine\UIC{$\vdots$}\noLine
    \UIC{$\hpSeq\hpGG,\hpC\hpty\lbrack\hpA\hpTens\hpB\hpty\rbrack$}
    \DP
  $$

In summary, the connective "$\hpHTens$" is a *structural* "$\hpTens$", and the judgement $\hpSeq\hpGG\hpHTens\hpGD$ means that the proofs of $\hpGG$ and $\hpGD$ are disjoint and can be disentangled into separate proofs.
Likewise, the connective "$\hpHOne$" is a *structural* "$\hpOne$", and the judgement "$\hpSeq\hpHOne$" means that there is nothing to prove.

Since hyper-environments internalise branching for multiplicative rules into the structure of the logic, the multiplicative rules may become unary.
For instance, HCLL's \Rule{HCLL-Cut} rule has only one premise:
$$
  \AXC{$\hpSeq\hpHG\hpHTens\hpGG,\hpA\hpHTens\hpGD,\co\hpA$}
  \RightLabel{\RuleLabel{HCLL}{Cut}}
  \UIC{$\hpSeq\hpHG\hpHTens\hpGG,\hpGD$}
  \DP
$$
The premise requires that the positive and negative occurrences of the cut formula are separated by a "$\hpHTens$", which ensures that their respective proofs are disjoint.
In the conclusion, the environments are merged, since the proofs have become connected.
This bookkeeping maintains the invariant that cut is only allowed to connect disjoint proofs, and avoids admitting rules that fundamentally alter the logic, such as $\RuleName{MultiCut}$ [see, e.g., @AtkeyLM16:ccc].

Likewise, HCLL's rule for tensor has only one premise, but there are two possible versions of the rule, which differ in whether or not the rule applies in the presence of unrelated proofs.
$$
  \AXC{$\hpSeq\hpGG,\hpA\hpHTens\hpGD,\hpB$}
  \RightLabel{\RuleLabel{HCLL}[$(\llTens)$]{Tens}}
  \UIC{$\hpSeq\hpGG,\hpGD,\hpA\hpTens\hpB$}
  \DP
  \qquad
  \AXC{$\hpSeq\hpHG\hpHTens\hpGG,\hpA\hpHTens\hpGD,\hpB$}
  \RightLabel{\RuleLabel{HCLL}[$(\llTens_{D})$]{D-Tens}}
  \UIC{$\hpSeq\hpHG\hpHTens\hpGG,\hpGD,\hpA\hpTens\hpB$}
  \DP
$$
The two are logically equivalent: \Rule{HCLL-Tens} is derivable from \Rule{HCLL-D-Tens}, and \Rule{HCLL-D-Tens} is admissible using \Rule{HCLL-Tens} and disentanglement.
However, the two give rise to different process semantics:

- HCP, as presented in this chapter and in @KokkeMP19:hcp [with errata], uses \Rule{HCLL-Tens}, which gives rise to the standard semantics of the π-calculus and is compatible with CP.
- DHCP, as presented in @KokkeMP19:dhcp, uses \Rule{HCLL-D-Tens}, which gives rise to delayed action semantics, as disentanglement requires that the action associated with \Rule{HCLL-D-Tens} commutes with parallel composition.

*How does HCP relate to the π-calculus?*
There is a slight difference in the semantics of communication channels, name restriction, and parallel composition, between HCP and the π-calculus, as presented by, e.g., @MilnerPW92:pi-2 or @SangiorgiW03:pi.
Let us investigate this difference by asking a question:
What makes a communication channel?
There are at least two answers:

1.  A communication channel is a name.
    Two processes can communicate simply by having access to the same name.
    Name restriction *restricts* the scope of a name, but communication channels exist irrespective of name restriction.
2.  A communication channel is explicitly created.
    Two processes can only communicate if they have access to the same name bound in the scope of the name restriction that creates it.
    Unbound names are disconnected endpoints, not attached to any channel.

A bit tongue-in-cheek, I will refer to (1) as the *restrictive* view, and to (2) as the *creative* view.
The π-calculus [@MilnerPW92:pi-2] takes the restrictive[^pi-restrictive] view, whereas Hypersequent CP takes the creative view.
The two can be distinguished by their reduction rules---or, equivalently, their label-transition rules, which we will discuss later.
Under the restrictive view, communication happens on free names, e.g., as in rule (a), and can happen on bound names simply by congruence.
Under the creative view, communication can only happen on bound names, e.g., as in rule (b).
$$
\!\!
\begin{array}{r@{\;}c@{\;}l@{\qquad}r@{\;}c@{\;}l}
  &
  \text{(a)}
  &
  &
  &
  \text{(b)}
  &
  \\
  \piUSend\pia\pic.\piP
  \piPar
  \piRecv\pia\piy.\piQ
  &
  \piEval
  &
  \piP
  \piPar
  \piQ\piSubst\pic\piy
  &
  \piNew(\pix)(
    \piUSend\pix\pic.\piP
    \piPar
    \piRecv\pix\piy.\piQ
  )
  &
  \piEval
  &
  \piNew(\pix)(
    \piP
    \piPar
    \piQ\piSubst\pic\piy
  )
\end{array}
$$
The view we take has significant consequences for our type system:

1.  Under the restrictive view, connection happens coincidentally. When two processes are composed in parallel, any number of connections can happen simultaneously, by the simple coincidence of names.
2.  Under the creative view, connection happens intentionally. When two processes are composed in parallel, they are not connected, and they remain unconnected until they are intentionally connected by a ν-binder, one channel at a time.

The creative view, due to its simplicity, is significantly more amenable to a correspondence with logic. To illustrate this, let us compare the typing rules for parallel composition from linear π-calculus [Lπ, @KobayashiPT96:linearpi], which takes the restrictive view, to Hypersequent CP, which takes the creative view:
$$
  \AXC{$\lpiP\lpiSeq\lpiGG$}
  \AXC{$\lpiQ\lpiSeq\lpiGD$}
  \RightLabel{\RuleLabel{LPI}{T-Par}}
  \BIC{$\lpiP\lpiPar\lpiQ\lpiSeq\lpiGG\lpiMerge\lpiGD$}
  \DP
  \qquad
  \hpPAR*\hpP\hpQ\hpHG\hpHH\DP
$$
Superficially, the rules are similar, but complexity hides in the details:

1.  In Lπ, all session types are annotated with their capabilities---whether the corresponding channel is used to send, receive, neither, or both.
    The "$\lpiMerge$" is a partial function in the meta-language, which merges two typing environments by adding together the uses of a channel name in the two environments.
    In the well-typed cases, it computes the union of the usages, e.g., if $\lpix$ was used to send in $\lpiGG$ and used to receive in $\lpiGD$, then it is fully used in $\lpiGG\lpiMerge\lpiGD$.
    However, in the ill-typed cases, it is undefined, e.g., if $\lpix$ is used to send in both $\lpiGG$ and $\lpiGD$, then $\lpiGG\lpiMerge\lpiGD$ is undefined, and the typing rule for parallel composition does not apply.
2.  In HCP, the "$\hpHTens$" is a structural connective, much like the comma, and simply means "these resources are used in different processes".
    The requirement for wellformedness is simpler: $\hpHG\hpHTens\hpHH$ is well-formed when the names in $\hpHG$ and $\hpHH$ are all distinct.

By taking the creative view, we get a typing rule for parallel composition which is much more logical, in the technical sense. What do we lose? We lose connection by coincidence, which I believe is not much of a loss, and perhaps even a win. So Hypersequent CP takes the creative view.

This chapter proceeds as follows:

- In @hcp-hypersequent-classical-processes, I introduce Hypersequent CP.

- In @hcp-metatheory, I introduce the metatheory for Hypersequent CP.

  I prove *preservation* [@proposition:hcp-preservation] and *progress* [@proposition:hcp-progress], that its processes are deadlock-free [@corollary:hcp-deadlock-free], that its canonical forms are adequate [@corollary:hcp-canonical-implies-blocking-free], and that its communication graphs are forests [@proposition:hcp-connection-forest].

  Notably, I also define disentanglement [@definition:hcp-disentanglement-cp], which converts Hypersequent CP processes into multisets of CP processes, and prove it preserves typing [@proposition:hcp-preservation-disentanglement-cp], structural congruence [@proposition:hcp-disentanglement-cp-equiv], and reduction [@proposition:hcp-disentanglement-cp-eval], and define a label-transition system for HCP [@definition:hcp-lts], and prove harmony [@proposition:hcp-lts-harmony].

- In @hcp-discussion, I discuss the relation between HCP and other developments in proof theory, and introduce several variants of HCP.

  Notably, I introduce variants that interpret the absurd offer as session cancellation [@hcp-zap-exceptionally-absurd-offer], assign synchronous semantics to link [@hcp-sync-link], and separate actions into their own syntactic sort by deconstructing the offer into a guarded summation [@hcp-variant-types-and-guarded-summation].

- Finally, @hcp-omitted-proofs contains all omitted proofs.

This chapter shares its structure with @cp, and since the two systems share a fair amount of their structure, an equally fair amount of exposition is repeated, often verbatim, in \Cref{hcp-link,hcp-send-and-receive,hcp-close-and-wait,hcp-select-and-offer,hcp-the-absurd-offer} and \Cref{hcp-preliminaries,hcp-preservation,hcp-progress}.
If you have read @cp, it is worth reading @hcp-hypersequent-classical-processes up to and including @hcp-process-structure, the definition of configuration contexts in @hcp-preliminaries, and then reading from @hcp-connection-and-disentanglement onwards.

```include
hypersequent-classical-processes.md
metatheory/index.md
discussion/index.md
conclusion.md
omitted-proofs/index.md
```

[^piLL]: @MontesiP:piLL's πLL continues the work on HCP. Of course, πLL is not a mere renaming. For instance, it includes the exponentials and second-order quantifiers.

[^pi-restrictive]: Confusingly, the word "restriction" [as used by @MilnerPW92:pi-1, submitted in 1989] connotes the restrictive view, but the later introduction of the letter "ν" [pronounced as "new", coined by @Milner91:polypi] connotes the creative view.

[^hcp-errata]: In May of 2019, Marco Peressotti discovered an error in the published version of @KokkeMP19:hcp. We submitted an erratum to EPTCS in July of 2019 which was approved for publication in October of 2021. Unfortunately, at the time of writing, the erratum has not yet been published. The version of the paper on Marco Peressotti's personal website, linked from the bibliography, contains an erratum.
