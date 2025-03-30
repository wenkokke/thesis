## Contributions {#contributions}

The contributions of this thesis are centred around @Wadler12:cpgv's propositions-as-sessions correspondence, and are divided into four parts.
\Cref{part:classical-processes-revisited} is concerned with @Wadler12:cpgv's propositions-as-sessions correspondence. It discusses CP and its metatheory.
\Cref{part:taking-linear-logic-apart} is concerned with the hypersequential variants. It discusses Hypersequent CP (HCP), Hypersequent GV (HGV), their metatheory and operational correspondence, as well as their relation to CP and GV.
\Cref{part:prioritise-the-best-variation} is concerned with the priority-based variants. It discusses Priority CP (PCP), Priority GV (PGV), their metatheory and operational correspondence, as well as their relation to CP and GV.
\Cref{part:deadlock-free-session-types-in-linear-haskell} is concerned with implementations of Good Variation and Priority GV in Linear Haskell.

The following visualisation gives an overview of the landscape of the formal systems discussed in this thesis, and the level of my contributions.

```include
visualisation.md
```

In the remainder of this section, I give a detailed account of the contributions made in this thesis.

#### \Cref{part:classical-processes-revisited}: Classical Processes Revisited

\Cref{part:classical-processes-revisited} consists of @cp, which revisits Classical Processes. The principal focus is to present, in detail, a variant of CP without commuting conversions, which break confluence in @Wadler12:cpgv's CP, and show that this variant has adequate canonical forms.

@cp contains the following contributions by me:

- I drop the commuting conversions from the reduction semantics, which cause @Wadler12:cpgv's CP to be non-confluent, and prove that *progress* [@proposition:cp-progress] continues to hold, albeit with a different canonical form [@definition:cp-canonical-form].

  The reduction semantics without commuting conversions first appeared in @Kokke17:msccpnd.

- I formalise the relation between CP with and without the commuting conversions. I prove that (1) any process in canonical form can reduce to a process in @Wadler12:cpgv's canonical form using only commuting conversions [@proposition:cp-canonical-form-implies-weak-cut-free-form]; and (2) any reduction with commuting conversions is equivalent to a reduction without commuting conversions followed by a reduction using only commuting conversions [@proposition:cp-commuting-conversions-last].

  To the best of my knowledge, this is the first publication in which these properties are explicitly stated and proven for CP, though they are hinted at by @LindleyM16:recgv.

- I formalise the notion of *dependency graph* [@definition:cp-dependency-graph] and *deadlock* [@definition:cp-deadlock] for CP, prove that CP processes are deadlock-free [@proposition:cp-deadlock-free], and prove that my canonical forms are adequate, by showing that processes in canonical form are blocked on free endpoints [@corollary:cp-canonical-implies-blocking-free].

  To the best of my knowledge, this is the first publication which explicitly defines dependency and deadlock for CP, though it is related to @LindleyM15:gv's definitions of dependency and deadlock for GV, and to PCP's priority constraints [@DardhaG18:pcp].
  The proof of deadlock freedom is adapted from a similar proof of deadlock freedom for GV by @LindleyM15:gv.
  My characterisation of "blocked on free endpoints" is stronger than @LindleyM15:gv's characterisation, which corresponds to my @proposition:cp-canonical-form.

- I formalise the notion of *connection graph* for CP [@definition:cp-connection-graph], prove that CP's connection graphs are trees [@proposition:cp-connection-tree], prove that every CP process can be rewritten into *right-branching form* [@proposition:cp-right-branching-form], and prove that connection graphs are canonical representatives of processes up to a restricted structural congruence [@proposition:cp-connection-graph-equiv-lps].

  I have informally referred to the connection graph as the *process structure* or *communication structure* [@KokkeD21:pgv;@KokkeD21:priority-sesh].
  The definition and corresponding theorems are adapted from work by Simon Fowler for Hypersequent GV [@FowlerKDLM23:hgv-ext, Definition 3.9], who formulate the *abstract process structure* of the free names in a process in terms of its typing environment and a set of co-names.

Good Variation is introduced in @hgv, together with the proof that HGV is a conservative extension of GV, and the variant of GV with cuts is described in @cooking-gv-with-cut and @lock-types-cuts-and-hypersequents.

I believe that my changes to CP (in @cp), are more important than my changes to GV (in @cooking-gv-with-cut).
Unlike GV, CP has an exact correspondence with CLL.
Furthermore, my changes affect its reduction semantics in a fundamental way, and these changes are used in HCP and PCP.
My changes to GV, on the other hand, are immediately superseded by the introduction of hypersequents in HGV in @hgv.

If you require a detailed discussion of GV without hypersequents, I recommend @Fowler19:thesis's Ph.D. thesis, *Typed Concurrent Functional Programming with Channels, Actors, and Sessions* [@Fowler19:thesis, Chapter 3].

#### \Cref{part:taking-linear-logic-apart}: Taking Linear Logic Apart

\Cref{part:taking-linear-logic-apart} consists of @hcp and @hgv.
@hcp introduces Hypersequent CP, which is a session-typed process calculus based on CP with a tighter correspondence to the π-calculus.
@hgv introduces Hypersequent GV, which is the corresponding session-typed concurrent λ-calculus.

@hcp contains the following contributions by me:

- I introduce Hypersequent CP with its typing rules and reduction semantics, and prove *preservation* [@proposition:hcp-preservation] and *progress* [@proposition:hcp-progress].

  The main innovation---HCP's type system---was developed independently by myself and by Fabrizio Montesi & Marco Peressotti[^hcp-errors].
The reduction semantics were primarily developed by me, and the label-transition semantics were primarily developed by Fabrizio Montesi & Marco Peressotti.

  The similarities between my early work on Hypersequent CP and Hypersequent Calculus [@Avron91:hypersequents] were noted by Simon Castellan at an ABCD meeting.[^hcp-name]

- I adapt the notions of *dependency graph* [@definition:hcp-dependency-graph] and *deadlock* [@definition:hcp-deadlock] for HCP, prove that HCP processes are deadlock-free [@corollary:hcp-deadlock-free], and prove that my canonical forms are adequate [@corollary:hcp-canonical-implies-blocking-free].

- I adapt the notion of *connection graph* for HCP [@definition:hcp-connection-graph], and prove that HCP's connection graphs are forests [@proposition:hcp-connection-forest], and that every HCP process can be rewritten into *right-branching forest form* [@proposition:hcp-right-branching-forest-form].

- I formalise disentanglement from Hypersequent CP processes to multisets of CP processes, and prove that disentanglement preserves typing, structural congruence, and reduction.

  Disentanglement was first described by @KokkeMP19:hcp as a rewrite relation that preserves provability, but the presentation in this thesis is novel. To the best of my knowledge, this is the first publication which shows that disentanglement preserves structural congruence and reduction.

- I introduce a label-transition semantics for HCP and prove *harmony* between the reduction and label-transition semantics [@proposition:hcp-lts-harmony].

  The label-transition semantics is a minor variation of the label-transition semantics by @MontesiP18:ct.
  To the best of my knowledge, this is the first publication that proves harmony for a reduction and label-transition semantics for HCP.

- I introduce a variant of HCP which uses an alternative *exceptional* semantics for the additive units, with both reduction and label-transition semantics, and extend the proofs of preservation, progress, and harmony.

- I introduce a variant of HCP which uses an alternative *synchronous* semantics for link, based on identity expansion, which, I claim, continues to work in the presence of polymorphism, and discuss the consequent changes in canonical forms, progress, and adequacy.

- I introduce a variant of HCP which uses a combination of variant types and focusing to further tighten the correspondence to the π-calculus by permitting prefixing and (guarded) summation as syntactic constructs, extend the proof of preservation, and sketch a proof of operational correspondence between HCP and the variant.

@hgv consists primarily of the paper *Separating Sessions Smoothly* by @FowlerKDLM23:hgv-ext, written in collaboration with Simon Fowler, Ornela Dardha, Sam Lindley, and J. Garrett Morris.

- We introduce Hypersequent GV with its typing rules and reduction semantics, and prove *preservation* (Theorem \hyperlink{paper:separating-sessions-smoothly.8}{I.3.3}), the *tree-structure* of connections in configurations (Theorem \hyperlink{paper:separating-sessions-smoothly.11}{I.3.14}), *global progress* (Theorem \hyperlink{paper:separating-sessions-smoothly.13}{I.3.20}), the *diamond property* (Theorem \hyperlink{paper:separating-sessions-smoothly.13}{I.3.21}), and *termination* (Theorem \hyperlink{paper:separating-sessions-smoothly.13}{I.3.22}).

- We define a translation from GV to HGV (Theorem \hyperlink{paper:separating-sessions-smoothly.14}{I.4.3})

- We define a translation from HGV to GV (Corollary \hyperlink{paper:separating-sessions-smoothly.16}{I.4.7}).

- We prove an operational correspondence between HGV and HCP. We define fine-grain call-by-value HGV (\fgHGV), define translations from HGV to \fgHGV and from \fgHGV to HCP, and prove that the latter translation preserves types (Lemma \hyperlink{paper:separating-sessions-smoothly.20}{I.5.9}) and is a sound and complete operational correspondence (Theorem \hyperlink{paper:separating-sessions-smoothly.20}{I.5.11}).

  To the best of my knowledge, this is the first publication of a sound and complete correspondence between any variant of CP and GV.

- We define a translation from HCP to HGV.

I co-developed Hypersequent GV and was primarily responsible for the translations and operational correspondence between HGV and HCP.

The remainder of the chapter contains the following contributions by me:

- I introduce a variant of GV that uses cuts rather than lock typing. Consequently, its structural congruence preserves types, which significantly simplifies its metatheory, and I argue that under lock types, the parallel composition construct is equivalent to a cut.

#### \Cref{part:prioritise-the-best-variation}: Prioritise The Best Variation

\Cref{part:prioritise-the-best-variation} consists of @priorities, which revisits Priority CP, a variant of CP with priorities whose typing rules permit benign cyclic process configurations, and introduces Priority GV, which is the corresponding session-typed concurrent λ-calculus.

@priorities consists primarily of the paper *Prioritise The Best Variation* by @KokkeD21:pgv, written in collaboration with Ornela Dardha.

- We drop the commuting conversions from the reduction semantics of Priority CP, which cause @DardhaG18:pcp's CP to be non-confluent, and prove that *progress* (Theorem \hyperlink{paper:prioritise-the-best-variation.29}{II.4.4}) continues to hold, albeit with a different canonical form.

  These changes are similar to the changes made to CP in \Cref{part:classical-processes-revisited}.

- We introduce Priority GV with its typing rules and reduction semantics, and prove *preservation* (referred to as *subject reduction*, Theorem \hyperlink{paper:prioritise-the-best-variation.20}{II.3.5}) and *global progress* (Theorem \hyperlink{paper:prioritise-the-best-variation.24}{II.3.14}).

- We define a translation from PCP to PGV, and prove that the translation preserves types (Theorem \hyperlink{paper:prioritise-the-best-variation.32}{II.4.6}) and is a sound and complete operational correspondence (Theorems \hyperlink{paper:prioritise-the-best-variation.35}{II.4.7} and \hyperlink{paper:prioritise-the-best-variation.38}{II.4.10}).

I co-developed Priority GV and was primarily responsible for the initial draft of its theory and metatheory. I adapted the changes to the reduction semantics of Priority CP from my previous work on CP.

The remainder of the chapter contains the following contributions by me:

- I prove that PCP is not an extension of CP (@counterexample:pcp-does-not-extend-cp).

- I define priority inference for PCP, and prove that priority inference is sound and complete with respect to typing for PCP (@proposition:pcp-priority-inference-soundness and @proposition:pcp-priority-inference-completeness).

#### \Cref{part:deadlock-free-session-types-in-linear-haskell}: Deadlock-Free Session Types in Linear Haskell

\Cref{part:deadlock-free-session-types-in-linear-haskell} consists of @implementations, which describes a library in Linear Haskell which implements session-typed channels based on GV and Priority GV.

@implementations consists primarily of the paper *Deadlock-Free Session Types in Linear Haskell* by @KokkeD21:priority-sesh, written in collaboration with Ornela Dardha.

- We implement session-typed channels in Linear Haskell and argue that a restricted interface to those channels corresponds to GV's channels and therefore enjoys GV's safety guarantees.

- We define a refined variant of Priority GV's type system, which gives exact rather than approximate priority bounds.

- We define the monadic reflection of Priority GV's priority-based type system into a graded linear monad, where the grading is pairs of lower and upper priority bounds.

- We implement priority-based session-typed channels in Linear Haskell and argue that those channels correspond to PGV's channels and therefore enjoys PGV's safety guarantees.

- We compare our Haskell library to existing Haskell libraries for session-typed channels, extending the comparison by @OrchardY17:st.

I implemented the Haskell library, developed the refined version of Priority GV's type system and its monadic reflection, wrote the initial draft of the paper, and co-authored the comparison with existing Haskell libraries for session-typed channels.

[^hcp-errors]: Our initial developments had minor errors. My initial development permitted hyper-environments to occur in all logical rules, which breaks progress. Progress can be repaired for the multiplicative rules, by using delayed actions [as in @KokkeMP19:dhcp], but not for the additive rules. These errors made it into the first publication [@KokkeMP19:hcp]. Fabrizio Montesi & Marco Peressotti's initial development [@MontesiP18:ct] typed the terminated process using the empty environment, as opposed to the empty hyper-environment, which admits \Rule{CLL-Mix0}.
[^hcp-name]: My talk at the ABCD meeting on Monday, December 18, 2017, was titled *Taking Apart Classical Processes*. Oddly, it appears to refer to the calculus as Hypersequent CP, which implies that I used the word "hypersequent" *before* I was aware of @Avron91:hypersequents's work on Hypersequent Calculus.
