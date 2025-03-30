# Conclusion {#cp-conclusion}

In this chapter, I revisited Classical Processes and its metatheory.
I dropped the commuting conversions, which cause @Wadler12:cpgv's CP to be non-confluent, from the reduction semantics.
I proved *preservation* [@proposition:cp-preservation], and proved that *progress* [@proposition:cp-progress] continues to hold, albeit with a different canonical form [@definition:cp-canonical-form].
I proved that CP's processes are deadlock-free [@proposition:cp-deadlock-free], and that the new canonical forms are adequate [@corollary:cp-canonical-implies-blocking-free].
I proved that CP's connection graphs are trees [@proposition:cp-connection-tree], and that any process can be rewritten to right-branching form [@proposition:cp-right-branching-form].
Finally, I discussed the relation between CP with and CP without commuting conversions.
I proved that any process in canonical form can reduce to a process in @Wadler12:cpgv's canonical form using only commuting conversions [@proposition:cp-canonical-form-implies-weak-cut-free-form]; and that any reduction that uses commuting conversions is equivalent to a reduction that does not use commuting conversions followed by a reduction using only commuting conversions [@proposition:cp-commuting-conversions-last].
