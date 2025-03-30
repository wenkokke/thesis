# Classical Processes Revisited {#cp}

```{=latex}
\shset0%
\cpset1%
```

This chapter presents Classical Processes (CP), a session-typed process calculus introduced by @Wadler12:cpgv based on Classical Linear Logic [@Girard87:ll, CLL].

Wadler went to great lengths to ensure an *exact* correspondence between CP and CLL:

1.  If you erase all that's written in $\tmprimaryname$ from the typing rules of CP, you get *exactly* the inference rules of CLL, as given by @Girard87:ll.
2.  The operational semantics of CP resembles that of a process calculus [@cp-classical-processes], but if you examine the proof of progress [@Wadler12:cpgv, Proposition 2], which implements the concrete reduction strategy for CP, the manner in which the reduction rules are used resembles a proof of cut elimination for CLL in the style of Gentzen, as described for classical logic by @GirardTL89:proofs [{}§ 13.2].[^cut-cll]

  [^cut-cll]: It is easy to mistake Wadler's claim for a correspondence between CP's reduction and the proof of cut elimination for the sequent calculus for CLL, as given by @Girard87:ll.
  The citations "@Girard87:ll" and "@GirardTL89:proofs" are similar, and, given the context, it is reasonable to assume that Wadler is referencing a proof by @Girard87:ll---except that @Girard87:ll gives no such proof!
  He proves cut elimination for the proof nets of CLL, proves that the sequent calculus is sound and complete with respect to the proof nets, and (implicitly) obtains cut elimination for the sequent calculus as a corollary.

Wadler chose to make serious concessions to CP as a process calculus in order to achieve its exact correspondence with CLL:

1.  He combines name restriction and parallel composition into a single term constructor, corresponding to the logical *Cut* rule.

    As a consequence, the structural congruence for CP looks quite unlike that of any process calculus, and many of the concepts used in concurrency theory, such as labelled transition systems, bisimilarity, and observational equivalents, cannot easily be applied to CP.
    For example, @Atkey17:obs-cp defines an observational equivalence for CP but, in order to do so, must introduce a second, separate term language that once again separates name restriction and parallel composition.

2.  He introduces additional reduction rules, named *commuting conversions*, into CP's operational semantics.

    The commuting conversions are not canonical for process calculi, and they are difficult to justify if we want CP to model parallel or distributed computation, since they require that if some process is blocked, waiting for input on some channel, then any other process can also become blocked, waiting for input on that same channel, whether they have access to that channel or not, and *without any communication*.
    (I discuss the commuting conversions in detail in @cp-commuting-conversions.)

The version of CP presented in this section retains the first part of the correspondence, which requires that we keep name restriction and parallel composition combined in a single term construct.
There are several approaches to separating the two, which I present in @hcp, @hgv, and @priorities, but each weakens the strict correspondence between the typing rules and the inference rules of CLL. Therefore, I believe that adopting any of these for CP would compromise its status as a canonical reference point.

The version of CP presented in this section weakens the second part of the correspondence by dropping the commuting conversions from the operational semantics.
This results in a reduction strategy much closer to that of a process calculus and repairs several defects in @Wadler12:cpgv's CP.
I believe that adopting this change does not compromise the status of CP as canonical reference point, which I discuss in detail in @cp-commuting-conversions (see @proposition:cp-canonical-form-implies-weak-cut-free-form and @proposition:cp-commuting-conversions-last).
The reduction strategy presented in this section still resembles a proof of cut elimination, just not in Gentzen's style.

In this chapter, CP's processes are printed in $\tmprimaryname$, its types are printed in $\typrimaryname$, and both are rendered in a sans-serif font.
To save on accessible colour combinations, the terms and types of *any other system* are printed in $\tmsecondaryname$ and $\tysecondaryname$, respectively, both are rendered in an italicised font with serif, and any relations, such as typing and reduction, are marked by a subscript.

This chapter proceeds as follows:

- In @cp-classical-processes, I introduce CP.

- In @cp-metatheory, I introduce the metatheory for CP.

  Notably, I prove *preservation* [@proposition:cp-preservation] and *progress* [@proposition:cp-progress], that its processes are deadlock-free [@proposition:cp-deadlock-free], that its canonical forms are adequate [@corollary:cp-canonical-implies-blocking-free], and that its connection graphs are trees (@proposition:cp-connection-tree).

- In @cp-commuting-conversions, I discuss the relation between CP with and CP without commuting conversions.

- Finally, @cp-omitted-proofs contains all omitted proofs.

```include
classical-processes.md
metatheory/index.md
commuting-conversions/index.md
conclusion.md
omitted-proofs.md
```
