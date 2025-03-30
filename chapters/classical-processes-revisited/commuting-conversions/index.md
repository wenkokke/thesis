# Commuting Conversions Considered Bad {#cp-commuting-conversions}

Wadler's CP has additional reduction rules, known as *commuting conversions* [@Wadler14:cpgv-ext, § 3.6].
The reason for adding these rules is that they allow the reduction strategy for Wadler's CP to correspond step-by-step to a standard proof of cut elimination in Gentzen's style [see @GirardTL89:proofs, § 13.2].

The commuting conversions are summarised in @figure:cp-commuting-conversions.
For clarity, I separate the rules into two different reduction relations [following @LindleyM15:gv]. I write $\cpEval$ for cut reductions and $\cpEvalCC$ for commuting conversions.[^swapped-notation]
@Wadler14:cpgv-ext's reduction relation is defined as as their union, written $\wcpEval$:
$$
  {\wcpEval}
  \defeq
  {\cpEval}\cup{\cpEvalCC}
$$

[^swapped-notation]: My names for the reduction relations differ from those of @LindleyM15:gv. I use the right arrow ($\cpEval$) for CP's the reduction relation without commuting conversions, which I consider the canonical reduction relation and is consistent with later chapters, and the right arrow labelled with a 'W' for *Wadler* ($\wcpEval$) for Wadler's reduction. @LindleyM15:gv use the right arrow ($\cpEval$) for Wadler's reduction, which they consider the canonical reduction relation, and use the right arrow labelled with a 'C' for *principal cut* ($\cpEvalC$) for the reduction relation without commuting conversions.

![Commuting Conversions for Classical Processes](figures/commuting-conversions.tex?as=webp){#figure:cp-commuting-conversions}

A consequence of the commuting conversions is that Wadler's CP has an appealingly simple canonical form: 'canonical form' simply means 'not a cut'.
I call this *weak cut-free form*, by analogy to weak-head normal form.

Definition (Weak Cut-Free Form).
  ~ A process is in *weak cut-free form* if is not a cut, i.e.,
    it is not of the form $\cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)$ for any $\cpx$, $\cpx'$, $\cpP$, and $\cpQ$.

    Equivalently, a process is in *weak cut-free form* if it is ready.

The commuting conversions are required to reduce processes to weak cut-free form. For instance, the process
$$
\cpNew(\cpx\cpx')(\cpWait\cpa.\cpClose{\cpx'}.0\cpPar\cpWait\cpx.\cpP)
$$
is not in weak cut-free form, but cannot reduce with any cut reduction.

@LindleyM15:gv [Page 574] claim that it suffices to reduce using only cut reductions, and use commuting conversions only to reduce from canonical form to weak cut-free form. I formalize and prove their claim as a pair of theorems.

First, I relate @LindleyM15:gv's claim to my definition of canonical form by showing that any process in canonical form reduces to a process in weak cut-free form using only commuting conversions.

Proposition {#cp-canonical-form-implies-weak-cut-free-form}.
  ~ For any process $\cpP$ in canonical form,
    there is a reduction using only commuting conversions $\cpP\cpEvalCC*\cpP'$
    such that $\cpP'$ is in weak cut-free form.

```include
proofs/cp-canonical-form-implies-weak-cut-free-form.md
```

Secondly, I show that it is *sufficient* to reduce using only cut reductions followed by only commuting conversions, by showing that any reduction in Wadler's CP can be rewritten to this form.

Proposition {#cp-commuting-conversions-last}.
  ~ For any reduction $\cpP\wcpEval*\cpR$,
    there is a reduction $\cpP\cpEval*\cpEvalCC*\cpR$.

```include
proofs/cp-commuting-conversions-last.md
```

Lemma {#cp-commuting-conversions-swap-star}.
  ~ If $\cpP\cpEvalCC*\cpEval\cpEvalCC*\cpR$,
    then $\cpP\cpEval\cpEvalCC*\cpR$.

```include
proofs/cp-commuting-conversions-swap-star.md
```

Lemma {#cp-commuting-conversions-swap}.
  ~ If $\cpP\cpEvalCC\cpEval\cpR$,
    then either $\cpP\cpEval\cpEvalCC\cpR$
    or $\cpP\cpEval\cpR$.

```include
proofs/cp-commuting-conversions-swap.md
```

What is the relation between weak cut-free form and canonical form?
Can we split some reduction $\cpP\wcpEval*\cpR$ into $\cpP\cpEval*\cpQ$ and $\cpQ\cpEvalCC*\cpR$ using @proposition:cp-commuting-conversions-last, then forget about the commuting conversions, and expect the process $\cpQ$ to be in canonical form? The short answer is "no".

Any process in weak cut-free form must be an action on a free endpoint, since there can be no bound endpoints at the top-level of a process.
The commuting conversions can move an action on a free endpoint past any number of cuts.
Therefore, a process can reduce to weak cut-free form using only the commuting conversions if it has any action on a free name under only cuts.
As I discussed in @cp-duality-dependency-and-deadlock, that is inadequate as a definition for canonical form, e.g., the process
$$
\cpNew(\cpx\cpx')(
  \cpWait\cpa.\cpP\cpPar
    \cpNew(\cpy\cpy')(
      \cpClose\cpy.0\cpPar\cpWait{\cpy'}.\cpQ))
$$
has an action on a free endpoint under a single cut but can still reduce.

@lemma:cp-commuting-conversions-swap reveals an issue with commuting conversions: *redundancy*.
Pairs of dual actions must be adjacent in the process configuration before any reduction rule applies.
This is a problem of syntax.
The structural congruence dictates that process configurations can be permuted.
However, in Wadler's CP, there are at least two ways to move dual actions into adjacent positions.
We can either use the structural congruence or the commuting conversions.
Worse, by combining both, we can pick any number of unrelated processes for the dual actions to commute over.

Example (Redundancy) {#cp-redundancy}.
: The following process has two distinct reductions that eliminate the dual actions $\cpClose\cpx$ and $\cpWait{\cpx'}$. One uses structural congruence, and the other uses commuting conversions.
  <!-- markdownlint-disable MD045 -->
  ![](examples/redundancy.tex)

The reduction strategy described by @Wadler14:cpgv-ext [Proposition 2] does not meaningfully use the structural congruence; its only use is to derive the symmetric versions of the reduction rules, such as, e.g., the symmetric version of \Rule{C-E-Link}:
$$
  \AXC{}
  \UIC{$
    \cpNew({\cpx'}\cpx)(\cpP\cpPar\cpLink\cpx\cpw)
    \cpEquiv
    \cpNew(\cpx\cpx')(\cpLink\cpx\cpw\cpPar\cpP)
  $}
  \AXC{}
  \UIC{$
    \cpNew(\cpx\cpx')(\cpLink\cpx\cpw\cpPar\cpP)
    \cpEval
    \cpP\cpSubst\cpw{\cpx'}
  $}
  \BIC{$
    \cpNew({\cpx'}\cpx)(\cpP\cpPar\cpLink\cpx\cpw)
    \cpEval
    \cpP\cpSubst\cpw{\cpx'}
  $}
  \DP
$$

There is another issue with commuting conversions.
To illustrate the issue, let us have a look at \Rule{C-CC-Wait}:
$$
\cpNew(\cpz\cpz')(\cpWait\cpx.\cpP\cpPar\cpQ)
\cpEvalCC
\cpWait\cpx.\cpNew(\cpz\cpz')(\cpP\cpPar\cpQ)
$$
On the left-hand side of the reduction rule, $\cpQ$ is a top-level process.  Therefore, any action on a free endpoint in $\cpQ$ can be observed, and any reduction $\cpQ\wcpEval\cpQ'$ can happen.
On the right-hand side of the reduction, both of these things are blocked by the action $\cpWait\cpx$.

Example (Blocked Observable) {#cp-commuting-conversions-reduce-observables}.
  ~ The reduction with \Rule{C-CC-Wait} on the action $\cpWait\cpa$ blocks the observation $\cpOb\cpb$
    $$
    \begin{array}{cll}
    \cpNew(\cpx\cpx')(\cpWait\cpa.\cpP\cpPar\cpWait\cpb.\cpQ)
    &
    \text{has observables}
    &
    \cpOb\cpa,\cpOb\cpb
    \\
    \rotatebox{270}{$\cpEvalCC$}
    \\[4ex]
    \cpWait\cpa.\cpNew(\cpx\cpx')(\cpP\cpPar\cpWait\cpb.\cpQ)
    &
    \text{has observables}
    &
    \cpOb\cpa
    \end{array}
    $$

Example (Blocked Reduction) {#cp-non-confluence}.
: The reduction with \Rule{C-CC-Wait} on the action $\cpWait\cpa$ blocks the reduction with \Rule{C-E-Close} on the actions $\cpClose\cpy$ and $\cpWait\cpy$
  <!-- markdownlint-disable MD045 -->
  ![](examples/non-confluence.tex)

@example:cp-non-confluence reveals that Wadler's CP is non-confluent! The processes at the bottom of the tree, $\cpWait\cpa.\cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)$ and $\cpWait\cpa.\cpNew(\cpx\cpx')(\cpP\cpPar\cpNew(\cpy\cpy')(\cpClose\cpy.0\cpPar\cpWait{\cpy'}.\cpQ))$, are distinct weak cut-free forms of $\cpNew(\cpx\cpx')(\cpWait\cpa.\cpP\cpPar\cpNew(\cpy\cpy')(\cpClose\cpy.0\cpPar\cpWait{\cpy'}.\cpQ))$.

Canonical form is a stronger property than weak cut-free form.
For some reductions $\cpP\wcpEval*\cpR$ where $\cpR$ is weak cut-free, when we apply @proposition:cp-commuting-conversions-last to decompose the reduction into $\cpP\cpEval*\cpQ$ and $\cpQ\cpEvalCC*\cpR$, we find the process $\cpQ$ is not in canonical form: further cut reductions were initially possible, but became blocked by the commuting conversions.
Formally, weak cut-free form corresponds to a variant of canonical form, called *weak canonical form*, which swaps the universal "all processes are ready" for an existential "some process is ready".

Definition (Weak Canonical Form) {#cp-weak-canonical-form}.
  ~ A process $\cpP$ is in *weak canonical form* if $\cpP\iotf\cpEE[\cpQ]$ such that $\cpQ$ is ready to act on a free endpoint that is not bound by $\cpEE$.

    Equivalently, a process $\cpP$ is in *weak canonical form* if there is a reduction $\cpP\cpEvalCC*\cpP'$ such that $\cpP'$ is in weak cut-free form.

As a consequence of the blocking behaviour of commuting conversions, the parallel composition of Wadler's CP is not truly parallel composition.
To illustrate this, let us each imagine an implementation of Wadler's CP in our favourite programming language, and let us recall \Rule{C-CC-Wait}:
$$
\cpNew(\cpz\cpz')(\cpWait\cpx.\cpP\cpPar\cpQ)
\cpEvalCC
\cpWait\cpx.\cpNew(\cpz\cpz')(\cpP\cpPar\cpQ)
$$
Imagine that we implement each ready action $\cpP_i$ in a process as some program `ti` running in its own thread.
The program `t1` implements $\cpWait\cpx.\cpP$: it is blocked, waiting to receive a ping on the channel `x`.
The programs `t2`,...,`tN` implement $\cpQ$: they are a collection of programs connected by channels, each program running in its own thread. There may be some communication between the programs `t2`,...,`tN`, but due to the typing rule for cut, only one of them is connected to `t1`.

The commuting conversion \Rule{C-CC-Wait} requires that, because `t1` is blocked on `x`, *all* of the programs `t2`,...,`tN` can become blocked on `x`.
An implementation would require *some* communication between `t1` and `t2`,...,`tN`, but this *cannot be* communication on shared channels, as `t1` only shares a channel with one of `t2`,...,`tN`.
Therefore, when we implement the cut from Wadler's CP, we cannot simply use two parallel threads with a shared channel. We *must* add some kind of global scheduler.
Consequently, implementations of Wadler's CP *must be* less parallel than we would expect from the syntax.

Formally, simulations of Wadler's CP in the π-calculus *must* decrease the degree of distribution, i.e., it is not possible to translate parallel composition to parallel composition.

Claim {#cp-commuting-conversion-pi-calculus}.
  ~ There exists no translation from the processes of Wadler's CP to processes of the π-calculus, written $\CtoPi$, such that:

    - The translation preserves the degree of distribution, i.e., is a homomorphism on parallel composition, which, due to CP's glued syntax, requires that the following equalities hold
      $$
      \begin{array}{lcl}
      \CtoPi({\cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)})
      & =
      & \piexp2{\piNew(\pix)(\CtoPi({\cpP})\piPar\CtoPi(\cpQ\cpSubst{\cpx}{\cpx'}))}
      \\
      \CtoPi({\cpSend\cpx\cpy.(\cpP\cpPar\cpQ)})
      & =
      & \piexp2{\piSend\pix\piy.(\CtoPi({\cpP})\piPar\CtoPi({\cpQ}))}
      \end{array}
      $$
      (Where the terms on the right-hand side denote π-calculus processes, i.e., $\piexp2{\piNew(\pix)}$ is channel name restriction and $\piexp2{\piSend\pix\piy}$ is bound output.)
    - The translation is a simulation, i.e., $\cpP\wcpEval\cpQ$ implies $\piexp2{\CtoPi({\cpP})\piEval*\CtoPi({\cpQ})}$.
      (Where $\piexp2{\piEval*}$ denotes the reflexive-transitive closure of the reduction relation for the π-calculus.)

In summary, the commuting conversions in @Wadler12:cpgv's CP are redundant, break confluence, and break the interpretation of parallel composition as parallel composition.

The version of CP presented in this chapter *is* confluent, but this is difficult to prove for the reduction semantics, as it requires showing that the structural congruence preserves the observable actions. Ultimately, a proof of congruence can be constructed by its operational correspondence with HCP [@hcp], which is the subject of the next chapter, and the proof of congruence for HCP by @MontesiP:piLL.
