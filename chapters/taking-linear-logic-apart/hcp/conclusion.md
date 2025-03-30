# Conclusion {#hcp-conclusion}

In this chapter, I introduced Hypersequent CP with its typing rules, reduction semantics, label-transition semantics, and their metatheory.
Hypersequent CP is a variant of CP that uses hypersequents to tighten the correspondence with the π-calculus.
I proved *preservation* [@proposition:hcp-preservation] and *progress* [@proposition:hcp-progress].
I proved that CP's processes are deadlock-free [@corollary:hcp-deadlock-free], and that its canonical forms are adequate [@corollary:hcp-canonical-implies-blocking-free].
I proved that HCP's connection graphs are forests [@proposition:hcp-connection-forest], and that any process can be disentangled into a collection of CP processes [@proposition:hcp-disentanglement].
I proved harmony between HCP's reduction and label-transition semantics [@proposition:hcp-lts-harmony].
I defined a pair of inverse translations from CP to HCP [@definition:hcp-fission] and from HCP to CP [@definition:hcp-disentanglement-cp], and proved that they preserve types (@proposition:hcp-fission-preserves-types and @proposition:hcp-preservation-disentanglement-cp) and give rise to a sound and complete operational correspondence (@proposition:hcp-fission-preserves-eval;@proposition:hcp-disentanglement-cp-eval).
Finally, I discussed the relation between HCP and similar logical systems, and introduced three variants of HCP with an exceptional semantics for the absurd offer, with synchronous semantics for links, and with guarded summation.

In the future, it would be interesting to extend HCP with the extensions for CP described in previous work.
Some of these extensions are already described in the literature.
@MontesiP:piLL describe a variant of HCP extended with the second-order quantifiers and exponentials, which are interpreted as polymorphism and replication.
@Qian21:llnd describe a variant of HCP extended with the exponentials and DiLL's co-exponentials, which are interpreted as replication and client-server interaction.
Other extensions, such as @LindleyM16:recgv's fixed points, have not yet been adapted to HCP.

Furthermore, it would be interesting to investigate a variant of Hypersequent CP with logical and structural connectives that capture sequential composition, such as "before" from @Retore97:pomset's Pomset logic or "seq" from @Guglielmi07:sis's BV.
Any system with sequential composition necessarily deviates from the π-calculus, which only has trivial sequential composition---prefixing a process with an action.
However, general sequential composition is important for programming languages.
The paper that introduced session types, @Honda93:session, describes a type system for a process calculus with general sequential composition.
@Honda93:session's type system is unsound, in the sense that well-typed processes may deadlock, and additional syntactic constraints are required to guarantee deadlock freedom.
In hindsight, this is unsurprising---@Tiu06:sisii proved that @Guglielmi07:sis's "seq" cannot be captured by a standard sequent calculus, and this result is assumed to extend to @Retore97:pomset's "before" and other systems that capture sequential composition.
However, the inference rules of @Guglielmi07:sis's BV and the proof nets of @Retore97:pomset's Pomset logic do not easily lend themselves to an interpretation as processes.
The decorated sequent calculus for Pomset logic, introduced by @Slavnov19:scmll, is an interesting candidate for further study.
