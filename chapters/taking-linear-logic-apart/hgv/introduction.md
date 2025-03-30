<!-- markdownlint-disable MD041 -->
This chapter presents Hypersequent GV (HGV), concurrent λ-calculus with session-typed concurrency primitives, which has a tight correspondence to Hypersequent CP.

Hypersequent GV was first introduced by @FowlerKDLM21:hgv, as a variant of GV that uses hypersequents for its runtime type system. While CP has not undergone many significant changes since its publication by @Wadler12:cpgv, GV's history is much more storied:

- Good Variation was first published under that name by @Wadler12:cpgv, who adapted the LAST calculus of @GayV10:last to fit a correspondence with CP.
However, @Wadler12:cpgv's GV has neither an operational semantics---except implicitly, by its translation to CP---nor an account of polymorphism or replication.

  This work has an error in its translation from GV to CP, which does not preserve typing in the case for session termination (Theorem 3).
- @LindleyM14:sap[^gv14-name] extend GV with operations for forwarding, polymorphism, and servers and clients, rectify the error in @Wadler12:cpgv's translation from GV to CP that breaks typing, and describe the first translation from CP to GV.

  This work does not give an operational semantics for GV, and its translation from GV to CP does not preserve reduction.
- @LindleyM15:gv give an operational semantics for GV, drop polymorphism and servers and clients, refactor GV so that the concurrency primitives are constant functions rather than term constructors, and switch to an encoding of the choice operators following @DardhaGS17:str.

  This work has an error in its operational semantics, which does not satisfy the diamond property in the case for link (Theorem 13), and in its translation from GV to CP, which does not preserve the reductions for products and sums[^gv15-simulation] (Lemma 21 and Theorems 22 and 23).
- @LindleyM16:recgv present μCP and μGV, which adds fixed points to both GV and CP. Orthogonally, this work also rectifies the error in the semantics for link, and adds the direct unit "$\llTop$" and the direct product "$\llWith$" [@GirardL87:ill].

  This work has the same error in its translation from GV to CP as @LindleyM15:gv, which does not preserve the reductions for products and sums (Theorem 16).
- @LindleyM17:fst present FST, which adds record & variant types with row polymorphism, an account of subkinding for linear and unrestricted types, asynchrony, and access points, and drops link, weak explicit substitution, and the correspondence with CP.
  This work does not present any of the metatheory of FST.
- @FowlerLMD19:egv and @Fowler19:thesis present EGV, which adds exceptions and handlers to GV. This work also drops link, weak explicit substitution, and the correspondence with CP.
- @FowlerKDLM21:hgv present Hypersequent GV, which rectifies a design flaw that complicates all previous metatheory of GV by dropping lock typing in favour of hypersequents.
  Orthogonally, this work also rectifies the error in the translation from GV to CP, and presents the first such translation from that both preserves and reflects reduction.
  (The extended version of this paper is presented in @hgv.)

In one sense, Hypersequent GV relates to GV as Hypersequent CP relates to CP. It uses hypersequents to separate name restriction from parallel composition in its configuration typing. In doing so, it removes lock typing and makes the structural congruence type preserving, which significantly simplifies the metatheory of GV.

In another sense, Hypersequent GV is simply GV. Recall that GV separates its language into a static fragment and a runtime fragment, and the static fragment---the user-facing programming language---is unchanged from GV.
Hypersequent CP generalises CP's process structure from trees to forests, and likewise Hypersequent GV generalises GV's configuration structures from trees to forests.
However, reduction from a single term---a single user program---only ever reaches tree-structured configurations.
That does not mean that we could not use the framework of GV to study configurations arising from multiple user programs---we could, although, since they are disconnected, this is unlikely to provide us any novel insights.

The bulk of this chapter consists of the paper *Separating Sessions Smoothly* by @FowlerKDLM23:hgv-ext, hereafter referred to as \hyperlink{paper:separating-sessions-smoothly.1}{Paper~I}.
References made from the main body of this thesis into \hyperlink{paper:separating-sessions-smoothly.1}{Paper~I} will be prefixed by an "I", e.g., "Theorem \hyperlink{paper:separating-sessions-smoothly.13}{I.3.20}".
This chapter proceeds as follows:

- In @hgv-legend-and-errata, we provide a legend and an errata for \hyperlink{paper:separating-sessions-smoothly.1}{Paper~I}.
- In @separating-sessions-smoothly, we present Hypersequent GV and its metatheory, together with translations to and from GV, and an operational correspondence with Hypersequent CP.
  This section consists entirely of \hyperlink{paper:separating-sessions-smoothly.1}{Paper~I}, and proceeds as follows:

  - In § \hyperlink{paper:separating-sessions-smoothly.3}{I.2}, we discuss the complications in GV's metatheory that arise from the use of lock typing.
  - In § \hyperlink{paper:separating-sessions-smoothly.4}{I.3}, we present HGV.
  - In § \hyperlink{paper:separating-sessions-smoothly.8}{I.3.1}, we present the metatheory for HGV.

    Notably, we prove *preservation* (Theorem \hyperlink{paper:separating-sessions-smoothly.8}{I.3.3}), the *tree-structure* of connections in configurations (Theorem \hyperlink{paper:separating-sessions-smoothly.11}{I.3.14}), *global progress* (Theorem \hyperlink{paper:separating-sessions-smoothly.13}{I.3.20}), the *diamond property* (Theorem \hyperlink{paper:separating-sessions-smoothly.13}{I.3.21}), and *termination* (Theorem \hyperlink{paper:separating-sessions-smoothly.13}{I.3.22}).
  - In § \hyperlink{paper:separating-sessions-smoothly.14}{I.4}, we present the relation between HGV and GV.

    Notably, we prove that any GV configuration is typeable in HGV (Theorem \hyperlink{paper:separating-sessions-smoothly.14}{I.4.3}), and that any HGV configuration can be rewritten by structural congruence to obtain a configuration that is typeable in GV (Corollary \hyperlink{paper:separating-sessions-smoothly.16}{I.4.7}).

  - In § \hyperlink{paper:separating-sessions-smoothly.16}{I.5}, we present the relation between HGV and HCP.

    Notably, we define fine-grain call-by-value HGV (\fgHGV, § \hyperlink{paper:separating-sessions-smoothly.16}{I.5}, under "\hyperlink{paper:separating-sessions-smoothly.19}{\fgHGV}"), define a naive translation from HGV to \fgHGV (§ \hyperlink{paper:separating-sessions-smoothly.16}{I.5}, Definition \hyperlink{paper:separating-sessions-smoothly.20}{I.5.8}) and define a translation from \fgHGV to HCP (§ \hyperlink{paper:separating-sessions-smoothly.16}{I.5}, Figure \hyperlink{paper:separating-sessions-smoothly.21}{I.8}), and prove that the latter translation preserves types (§ \hyperlink{paper:separating-sessions-smoothly.16}{I.5}, Lemma \hyperlink{paper:separating-sessions-smoothly.20}{I.5.9}) and is a sound and complete operational correspondence (§ \hyperlink{paper:separating-sessions-smoothly.16}{I.5}, Theorem \hyperlink{paper:separating-sessions-smoothly.20}{I.5.11}). Finally, we define a translation from HCP to HGV, by composing existing translations (§ \hyperlink{paper:separating-sessions-smoothly.16}{I.5}, under "\hyperlink{paper:separating-sessions-smoothly.22}{Translating HCP to HGV}").
  - In § \hyperlink{paper:separating-sessions-smoothly.22}{I.6}, we present extensions of HGV.
  - In § \hyperlink{paper:separating-sessions-smoothly.25}{I.7}, we discuss the possibility of using hyper-environments in term typing.
  - In § \hyperlink{paper:separating-sessions-smoothly.26}{I.8}, we discuss the related work.

[^gv14-name]: @LindleyM14:sap name their system "Harmonious GV" as the operations in the their version of GV restore the balance between and CP.
Later publications in the same line of work refer to their system as GV.
[^gv15-simulation]: @LindleyM15:gv use weak explicit substitution in an effort to obtain a translation from GV to CP that preserves reduction, which works in principle, as the translation preserves β-reduction.
Unfortunately, their implementation of weak explicit substitution only suspends substitution on λ-abstraction. Hence, the translation does not preserve reductions that involve the other binders, i.e., those for products and sums.
Consequently, Lemma 21, Theorem 22, and Theorem 23 fail to hold.
Presumably, this is easily solved by either suspending substitution on all binders, or by encoding the eliminators for products and sums as constants and making λ-abstraction the only binder.
