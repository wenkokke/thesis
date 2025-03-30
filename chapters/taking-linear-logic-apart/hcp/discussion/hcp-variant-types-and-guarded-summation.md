# Variant Types And Guarded Summation {#hcp-variant-types-and-guarded-summation}

In this section, we generalise select and offer to variant types, as mentioned in @cp-select-and-offer, then decompose the $n$-ary offer into guarded summation, which lets us factor out actions into their own syntactic sort and which enormously simplifies the reduction and label-transition semantics, as well as the associated metatheory.
The decomposition guarantees that summations are guarded using a limited form of focusing, which is a technique from proof theory to control the structure of proofs without reducing the expressivity of the logic [see @Andreoli92:focusing].

## The Variant With Variants

To generalise select and offer to variant types, we remove the restriction that labels must always be drawn from $\{\hpInl,\hpInr\}$ [following @DardhaG18:pcp].
Let $\hpL$ range over finite sets of labels, and let $\hpl$ and $\hpk$ range over individual labels (not to be confused with $\hpLab$, which ranges over the entirely unrelated labels used in the label-transition system).
We write $\hpL,\hpl$ to mean $\hpL\cup\hptm\lbrace\hpl\hptm\rbrace$.
Labels occur both in processes and in types, and as such appear both in $\typrimaryname$ and $\tmprimaryname$. They are coloured accordingly, and when they appear by themselves, they are coloured according to whether or not they can be erased. Regardless of colour, labels with the same name refer to the same label.

We replace the binary select and offer actions and the corresponding types with $n$-ary labelled variants:
$$
  \begin{array}{lrl @{\hspace{2cm}} lrl}
    \hpP, \hpQ, \hpR
    & \Coloneq
    & \dots
    & \hpA, \hpB
    & \Coloneq
    & \dots
    \\
    & \mid
    & \mathst{\hpSelect\hpx<1.\hpP}
      \mid
      \mathst{\hpSelect\hpx<2.\hpP}
    &
    & \mid
    & \mathst{\hpA\hpPlus\hpB}
    \\
    & \mid
    & \mathst{\hpOffer\hpx(\hpInl:\hpP;\hpInr:\hpQ)}
    &
    & \mid
    & \mathst{\hpA\hpWith\hpB}
    \\
    & \mid
    & \hpSelect\hpx<\hpl.\hpP
    &
    & \mid
    & \textstyle\hpBigPlus{\hpl*:\hpA_{\hpl*}}_{\hpl*\in\hpL*}
    \\
    & \mid
    & \hpOffer\hpx(\hpl:\hpP_\hpl)_{\hpl\in\hpL}
    &
    & \mid
    & \textstyle\hpBigWith{\hpl*:\hpA_{\hpl*}}_{\hpl*\in\hpL*}
  \end{array}
$$
The variant offers $\hpOffer\hpx(\hpl:\hpP_\hpl)_{\hpl\in\hpL}$ offers a set of alternatives labelled by the labels from some finite set $\hpL$, and the variant selection $\hpSelect\hpx<\hpl.\hpP$ selects the alternative labelled by $\hpl$.
The variant selection and offer types, $\hpBigPlus{\hpl*:\hpA_{\hpl*}}_{\hpl*\in\hpL*}$ and $\hpBigWith{\hpl*:\hpA_{\hpl*}}_{\hpl*\in\hpL*}$, respectively, associate each label $\hpl*\in\hpL*$ with the type of the alternative.

The syntax $\hptm\{\hpl:\hpP_\hpl\hptm\}_{\hpl\in\hpL}$ and $\hpty\{\hpl*:\hpA_{\hpl*}\hpty\}_{\hpl*\in\hpL*}$ denote sets of labelled alternatives.
Formally, these are functions from labels to processes and session types, respectively.
Note that the occurrences of $\hpl$ and $\hpl*$ between the curly braces are not free, but bound by the expressions in the subscripts.

For concrete processes and types, we write the set of alternatives in full, e.g., as $\hpOffer\hpx(\hpl_1:\hpP_1;\hptm{\dots}\hpl_n:\hpP_n)$. In these cases, we omit the subscript, since the set of labels can be inferred.

The choice to treat alternatives as sets means that they can be reordered.
For instance, $\hpOffer\hpx(\hpInl:\hpP;\hpInr:\hpQ)$ and $\hpOffer\hpx(\hpInr:\hpQ;\hpInl:\hpP)$ are definitionally equal.
Alternatively, we could treat the sets of labels as ordered, and treat alternatives as ordered sequences.[^pcp-indexed-variant]

The typing rules and reduction semantics for variant selection and offer are standard generalisations of the binary versions.
$$
  \begin{RuleWithLabel}{H}{T-SelectN}[T-Select]
    \AXC{$\hpP \hpSeq \hpGG, \hpx : \hpA_{\hpl*}$}
    \AXC{$\hpl* \in \hpL*$}
    \BIC{$
      \hpSelect{\hpx}<{\hpl}.\hpP
      \hpSeq
      \hpGG, \hpx : \hpBigPlus{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*}
      $}%
    \DP
  \end{RuleWithLabel}
  \qquad
  \begin{RuleWithLabel}{H}{T-OfferN}[T-Offer]
    \AXC{$
      (
      \hpP_{\hpl}
      \hpSeq
      \hpGG, \hpx : \hpA_{\hpl*}
      )_{\hpl*\in\hpL*}
      $}
    \UIC{$
      \hpOffer{\hpx}(\hpl:\hpP_{\hpl})_{\hpl\in\hpL}
      \hpSeq
      \hpGG, \hpx : \hpBigWith{\hpl* : \hpA_{\hpl*}}_{\hpl*\in\hpL*}
      $}%
    \DP
  \end{RuleWithLabel}
$$
$$
\begin{array}{l@{\;}c@{\;}ll}
    \hpNew(\hpx\hpx')(
    \hpSelect{\hpx}<{\hpl}.\hpP
    \hpPar
    \hpOffer{\hpx'}(\hpl:\hpQ_{\hpl})_{\hpl\in\hpL}
    )
  & \hpEval
  & \hpNew(\hpx\hpx')(
    \hpP
    \hpPar
    \hpQ_{\hpl}
    )
  & \RuleLabel{H}[E-Select]{E-SelectN}
\end{array}
$$
In the premise of \Rule{H-T-OfferN}, the notation "$(\dots)_{\hpl*\in\hpL*}$" means that one typing derivation is required for each label and alternative.
Should we want to support type inference, then every variant selection on a free endpoint requires one type annotation for each label not selected, though this is no different from the binary left and right selection actions.

There is an awkwardness between variant types and the absurd offer.
The absurd offer should be the nullary variant, which would let us replace $\hpNil$ by $\hpBigPlus{}$, $\hpTop$ by $\hpBigWith{}$, and the absurd offer by $\hpOffer\hpx()$.
As discussed in @hcp-the-absurd-offer and @cp-the-absurd-offer, this works in HCP with the inert semantics and in CP with both the inert semantics and Wadler's commuting conversions, though, in both cases, it complicates the statement of linearity.
As discussed in @cp-the-absurd-offer and @hcp-zap-exceptionally-absurd-offer, zappers require that the names of the discarded endpoints are kept at runtime.
Morally, zappers are the nullary offer, and the expected propositions hold, e.g., $\hpBigWith{\hpl*_1:\hpA;\hpl*_2:\hpTop}$ is equivalent to $\hpA$.
However, zappers require more information than would follow from the nullary case of the  generalisation.
To combine variant types with zappers, we must rule out empty variants and retain the additive units.

The metatheory of HCP generalises easily to variant types, and all metatheoretical properties of HCP are preserved. In some cases the proofs simplify, as the variant syntax lets us treat selections uniformly.
However, we will not belabour this point, as the generalisation to variant types is not novel, and is principally intended as an introduction to the discussion of guarded summation.

## Focusing And Guarded Summation

The π-calculus usually defines the syntax of actions separately from the syntax of processes, and the two are combined by prefixing, i.e., $\hpAct.\hpP$.
This leads to a much simpler theory, as we can treat all actions uniformly.
As mentioned in @cp-select-and-offer and @hcp-lts-and-harmony, this cannot easily be done in CP and HCP, as the offer is a single monolithic construct that combines all labels and alternative processes.

In the π-calculus, alternatives are combined by *summation*, e.g., the process $\hpP\hpSum\hpQ$ acts either as $\hpP$ or as $\hpQ$.
To ensure that the choice is not arbitrary, each alternative must be *guarded*, which means that it must be ready to act on some distinct endpoint, and the first alternative to receive a message is selected.
For instance, when evaluating the process
$$
  \hpClose\hpx.0\hpPar\hptm(\hpWait\hpx.\hpP\hpSum\hpWait\hpy.\hpQ\hptm)
$$
the communication on $\hpx$ selects $\hpP$ and discards $\hpQ$.
Such a process calculus, where the selection is made by the choice of endpoint, is difficult to type in formalisms like CP, where endpoints are linear and channels must be bound by a name restriction.
(Summation naturally corresponds to a structural *with*, but the introduction of additive hypersequents complicates name restriction, which must account for the fact that each alternative may use some channel at a different type.)

In this section, we introduce an intermediate system, where alternatives are combined by summation, and each alternative must be guarded by an offer action on the same endpoint, but with a different label.
Actions are defined as usual, e.g., as in @hcp-lts-and-harmony, with the exception that selection and offer permit arbitrary labels.
(We postpone the discussion of link.)
$$
  \hpAct
  \Coloneq \hpSend\hpx\hpy
  \mid     \hpRecv\hpx\hpy
  \mid     \hpClose\hpx
  \mid     \hpWait\hpx
  \mid     \hpSelect\hpx<\hpl
  \mid     \hpOffer\hpx>\hpl
$$
Processes are defined by name restriction, parallel composition, the terminated process, *prefixing*, and *summation*.
$$
\hpP, \hpQ, \hpR
  \Coloneq \hpNew(\hpx\hpx')\hpP
  \mid     \hpP\hpPar\hpQ
  \mid     \hpZ
  \mid     \hpP\hpSum\hpQ
  \mid     \hpAct.\hpP
$$
The process $\hpOffer\hpx>\hpl.\hpP$ introduces a unary offer, and offers can be combined by summation.
The typing rules for the offer and summation use a limited form of *focusing* [see @Andreoli92:focusing].
Focusing is a technique from proof theory that can be used to heavily restrict the form of proofs without affecting expressivity, and is often used for more efficient proof search.
In our case, focusing is only used to enforce guardedness.
We add a new typing judgement, $\hpP\hpSeq\hpGG\hpFocA\hpx:\hpA$, which remembers what endpoint the process is ready to make an offer on---or, if we focus all actions, ready to act on.[^andreoli-notation]
$$
\begin{array}{c}
  \begin{RuleWithLabel}{H}{T-FocOffer1}[T-Offer\textsubscript{1}]
    \AXC{$\hpP \hpSeq \hpGG, \hpx : \hpA$}
    \UIC{$
      \hpOffer\hpx>\hpl.\hpP
      \hpSeq
      \hpGG
      \hpFocA
      \hpx : \hpBigWith{\hpl*:\hpA}
      $}%
    \DP
  \end{RuleWithLabel}
  \qquad
  \begin{RuleWithLabel}{H}{T-FocAbsurdZap}[T-Absurd]
    \AXC{$
      \hpNN=\fn(\hpGG)
      $}
    \UIC{$
      \hpAbsurdZap\hpx\hpNN
      \hpSeq
      \hpGG
      \hpFocA
      \hpx : \hpBigWith{}
      $}%
    \DP
  \end{RuleWithLabel}
  \qquad
  \begin{RuleWithLabel}{H}{T-Focus}
    \AXC{$\hpP \hpSeq \hpGG \hpFocA \hpx : \hpA$}%
    \UIC{$\hpP \hpSeq \hpGG, \hpx : \hpA$}%
    \DP
  \end{RuleWithLabel}
  \\[2em]
  \begin{RuleWithLabel}{H}{T-FocSum}[T-Sum]
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
  \end{RuleWithLabel}
\end{array}
$$
The rule \Rule{H-T-FocOffer1} types the unary offer. It is the unary case of the rule for the variant offer, \Rule{H-T-OfferN}, except that it remembers what endpoint the offer is made on.
The rule \Rule{H-T-Focus} allows us to forget this information at any point, though, once forgotten, we cannot recover it.
The rule \Rule{H-T-FocSum} types guarded summation, which requires that each alternative is ready to make an offer on the same endpoint.

We extend the structural congruence with the following rules, such that summations are associative and commutative, and the absurd offer is the unit for summation:
$$
\begin{array}{l@{\;}c@{\;}lll}
  \hpP\hpSum\hpAbsurdZap\hpx\hpNN
& \hpEquiv
& \hpP
&
& \RuleLabel{H}{SC-SumAbsurd}
\\
  \hpP\hpSum\hpQ
& \hpEquiv
& \hpQ\hpSum\hpP
&
& \RuleLabel{H}{SC-SumComm}
\\
  \hpP\hpSum\hptm(\hpQ\hpSum\hpR\hptm)
& \hpEquiv
& \hptm(\hpP\hpSum\hpQ\hptm)\hpSum\hpR
&
& \RuleLabel{H}{SC-SumAssoc}
\end{array}
$$
The reduction rule for selection chooses the alternative with the matching label, and discards the other alternatives.
$$
\begin{array}{l@{\;}c@{\;}lll}
  \hpNew(\hpx\hpx')(
    \hpSelect{\hpx}<\hpl.\hpP
    \hpPar
    \hptm(
      \hpOffer{\hpx'}>\hpl.\hpQ
      \hpSum
      \hpR
    \hptm)
  )
& \hpEval
& \hpNew(\hpx\hpx')(
    \hpP
    \hpPar
    \hpQ
  )
& \RuleLabel{H}[E-Select]{E-FocSelect}
\end{array}
$$
The metatheory of HCP generalises easily to the variant with guarded summation.
The proofs of preservation for the structural congruence and reduction must be updated by adding cases for the new rules.
The proofs for progress, deadlock freedom, and the adequacy of canonical forms are easily updated.
Alternatively, these properties follow from the operational correspondence between HCP with binary choice and HCP with guarded summation.
We present the updated proofs of preservation and a sketch for the operational correspondence.

The rules \Rule{H-SC-SumAbsurd}, \Rule{H-SC-SumComm}, \Rule{H-SC-SumAssoc}, and \Rule{H-E-FocSelect} preserve types.

Lemma {#hcp-sum-preservation-equiv}.
  ~ If $\hpP\hpEquiv\hpQ$,
    then $\hpP\hpSeq\hpHG$ if and only if $\hpQ\hpSeq\hpHG$.

```include
proofs/hcp-sum-preservation-equiv.md
```

Proposition (Preservation) {#hcp-sum-preservation}.
  ~ If $\hpP\hpSeq\hpHG$ and $\hpP\hpEval\hpQ$,
    then $\hpQ\hpSeq\hpHG$.

```include
proofs/hcp-sum-preservation.md
```

The operational correspondence follows disentanglement, by translating each summation to a sequence of binary choices.
The translation on processes proceeds as follows:

1.  Take the maximum summation context, which is defined by analogy to the maximum configuration context.
2.  Eliminate any superfluous absurd offers, which ensures that any use of \Rule{H-SC-SumAbsurd} holds reflexively under the translation.
3.  Normalise the structure of the summation to right-branching form.
4.  Fix an arbitrary order on all labels and reorder the unary offers accordingly, which ensures that any use of \Rule{H-SC-SumComm} and \Rule{H-SC-SumAssoc} holds reflexively under the translation.
5.  Translate the summation as a series of binary offers.

The translation on session types proceeds similarly, and the order on labels ensures that the translation of the session types matches the translation of the processes.

The translation on processes preserves types---up to the translation on types---and preserves structural congruence and reduction.
However, the correspondence between the reduction semantics is not one-to-one. A process that reduces in one step with \Rule{H-E-FocSelect} requires a number of steps with \Rule{H-E-Select1} and \Rule{H-E-Select2} that is worst-case linear in the number of alternatives.
The worst-case linear increase is a consequence of the right-branching form, and we can improve to a logarithmic increase by translating summations as balanced binary trees.

### What About Zappers?

The exceptional semantics for the absurd offer, as discussed in @hcp-zap-exceptionally-absurd-offer, are compatible with guarded summation.
The rule \Rule{H-E-Zap-Kill} works as written, and it is important *not* to permit any other actions in the summation.

### What About Link?

There are no issues with link in HCP with guarded summation, but there is a choice on how to implement link. We can either add link as a process or add it as an action:

- *As a process.*
  From the perspective of the logic, link should be a process constructor, since link, like name restriction and parallel composition, corresponds to a structural rule of the logic, whereas the actions correspond to logical rules.
  This prevents us from treating link together with the other actions.
  In HCP, where link is asynchronous and the other actions are synchronous, we are already required to treat link separately.
  Hence, for HCP, adding link as a process constructor is a good fit.
- *As an action.*
  On the other hand, when using a synchronous semantics for link, such as those presented in @hcp-sync-link, we can treat it together with the other actions.
  Hence, for HCP with a synchronous link and for HCP with asynchronous actions, adding link as an action might be a good fit as well, even if it forces us to write "$\hpLink\hpx\hpy\hptm.\hpZ$".

### Processes, Summations, And An Absurd Unit

@SangiorgiW03:pi define processes and summations as separate syntactic sorts
$$
\piexp2{%
\begin{array}{lrl}
\piP,\piQ & \Coloneq & \piS \mid \piP\piPar\piQ \mid \piNew(\pix)\piP
\\
\piS,\piR & \Coloneq & \piZ \mid \piAct.\piP \mid \piS\piSum\piR
\end{array}}
$$
which guarantees that summations are guarded *syntactically*.
There is no great need for such separation in HCP, as guardedness is guaranteed by the type system.
However, examining @SangiorgiW03:pi's definition reveals two interesting things.

Firstly, the rule \Rule{H-T-Focus} corresponds to the syntactic embedding of summations into processes.
If we focus the existing typing rules for actions, the typing judgements divide neatly into separate typing judgements for processes and summations
$$
\begin{array}{ll}
  \hpP\hpSeq\hpHG
  &
  \text{process typing}
  \\
  \hpS\hpSeq\hpGG\hpFocA\hpx:\hpA
  &
  \text{summation typing}
\end{array}
$$
with the rules for prefixing and the rule \Rule{H-T-Focus} moving back and forth between summation typing and process typing.

Secondly, @SangiorgiW03:pi define $\piZ$ as a *summation*.
Since summations are processes, it does double duty as both the empty summation and the empty process, i.e., as both the unit for summation and parallel composition.
In HCP with guarded summation, the absurd offer $\hpAbsurdZap\hpx\hpNN$ is the unit for summation, whereas the terminated process $\hpZ$ is the unit for parallel composition.

[^pcp-indexed-variant]: @DardhaG18:pcp use a different construction, where both the label and the alternative are indexed by some index $\hpi$ drawn from some set $\hpI$, e.g.,$\hptm\{\hpl_{\hpi}:\hpP_{\hpi}\hptm\}_{\hpi\in\hpI}$. They do not specify whether these denote a pair of functions from indices to labels and alternatives, or whether these denote ordered sequences of pairs.

[^andreoli-notation]: The upward arrow in "$\hpP\hpSeq\hpGG\hpFocA\hpx:\hpA$" comes from @Andreoli92:focusing's sequent focused on an asynchronous proposition, which has a dual focused on a synchronous proposition that uses a downward arrow.
