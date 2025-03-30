# Abstract

```{=latex}
\begingroup
\hypersetup{hidelinks}
```

The foundations of functional programming are built on the λ-calculus, a powerful model of computation whose canonicity is affirmed by its correspondence with intuitionistic logic.
The foundations of concurrent computation are built on less firm ground.
There is a wide variety of process calculi, but none enjoy the same canonicity as the λ-calculus, nor an exact correspondence with logic.
Since its inception by @Girard87:ll, Classical Linear Logic has been believed to have some relation to concurrent computation, which has spawned a wealth of research in both logic and programming language theory.
```{=latex}
\vspace*{-0.02789\baselineskip}
```
This thesis continues the work towards a foundation for concurrent computation, starting from the propositions-as-sessions correspondence proposed by @Wadler12:cpgv.
Drawing on the work of @Abramsky94:proofs-as-processes, @BellinS94:pi-calculus, and @CairesP10:pidill, among others, Wadler proposed the process calculus CP, which has an exact correspondence with Classical Linear Logic.
Drawing on the work of @Honda93:session, @HondaVK98:session, and @GayV10:last, among others, Wadler proposed the session-typed functional language GV, which provides a practical foundation for session-typed concurrency in functional languages.
Finally, Wadler connects GV and CP by means of an operational correspondence, and, thereby, connects practice of session-typed concurrency to Classical Linear Logic.
```{=latex}
\vspace*{-0.02789\baselineskip}
```
This thesis provides an in-depth study of the propositions-as-sessions correspondence proposed by Wadler, highlighting its strengths and repairing a number of its shortcomings.
<!-- COMMUTING CONVERSIONS CONSIDERED BAD -->
Due to its adoption of commuting conversions, @Wadler12:cpgv's CP is non-confluent, and its semantics are difficult to realise using the abstractions of concurrent computation it purports to model.
I address this shortcoming by removing the commuting conversions, and showing that the resulting process calculus is well-behaved and retains its connection to linear logic.
<!-- PARALLEL COMPOSITION SHOULD STAND ALONE -->
Due to its lack of a parallel composition operator, @Wadler12:cpgv's CP is ill-suited to an analysis using standard concurrency theory.
@Wadler12:cpgv's GV lacks an operational semantics and accounts of polymorphism and replication, which were provided by Lindley and Morris [-@LindleyM14:sap;-@LindleyM15:gv;-@LindleyM16:recgv].
Unfortunately, @LindleyM15:gv's GV suffers from similar problems as CP with regard to its treatment of parallel composition, which complicates its metatheory.
I address this shortcoming in both systems by adding a parallel composition operator and showing that the resulting calculus is well-behaved and correspond to a hypersequential variant of Classical Linear Logic.
<!-- PRIORITIES ARE COOL -->
Finally, I study Priority CP, a variant of @Wadler12:cpgv's propositions-as-sessions correspondence proposed by @DardhaG18:pcp, which increases its expressivity at the cost of its compositionality and correspondence to logic.
As with CP, I remove the commuting conversions from Priority CP, and complete the correspondence with Priority GV, which is the analogous variant of GV.

```{=latex}
\endgroup
```

---
