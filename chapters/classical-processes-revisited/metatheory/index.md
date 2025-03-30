# Metatheory {#cp-metatheory}

In this section, I introduce the metatheory for Classical Processes.
This section proceeds as follows:

- In @cp-preliminaries, I give several preliminary definitions that are used throughout the discussion of the metatheory.

- In @cp-preservation, I prove preservation (@proposition:cp-preservation).
  In essence, the proof is a reproduction of @Wadler12:cpgv's proof of preservation, but without the commuting conversions and with small changes to account for the my changes to CP's syntax.

- In @cp-progress, I define canonical form [@definition:cp-canonical-form] and prove progress [@proposition:cp-progress].
  The proof cannot be reproduced from @Wadler12:cpgv, as the reduction rules I give in @cp-classical-processes are a proper subset of those given by @Wadler12:cpgv.
  I could adapt the proof by @LindleyM15:gv, but it relies on the property that CP processes can be rewritten to right-branching form (see @proposition:cp-right-branching-form), which does not hold for the variants of CP that I discuss in later chapters.
  The proof for progress I give in this section generalises @LindleyM15:gv's appeal to right-branching form using process contexts, which allows me to reuse the same proof structure in later chapters.
  This proof of progress first appeared in my M.Sc.\ thesis [@Kokke17:msccpnd].

- In @cp-duality-dependency-and-deadlock, I define dependency graphs for CP processes [@definition:cp-dependency-graph].
  I prove that CP is deadlock-free, as its dependency graphs are always acyclic [@proposition:cp-deadlock-free], and I prove that my definition of canonical form is adequate [@corollary:cp-canonical-implies-blocking-free] and stronger than @Wadler12:cpgv's definition.

- In @cp-connection-and-right-branching-form, I define connection graphs for CP processes [@definition:cp-connection-graph] and prove that CP's connection graphs are always trees [@proposition:cp-connection-tree].
  The validity of right-branching form for CP follows as a corollary.

- In @cp-observational-equivalence, I sketch the basis of a behavioural theory for CP.

```include
preliminaries/index.md
preservation.md
progress.md
duality-dependency-and-deadlock.md
connection-and-right-branching-form.md
observational-equivalence.md
// confluence.md
```
