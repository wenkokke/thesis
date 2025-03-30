# Conclusion {#hgv-conclusion}

In this chapter, we introduced Hypersequent GV, as well as GV, with their typing rules, reduction semantics, and their metatheory.
Hypersequent GV rectifies a design flaw that complicates all previous metatheory of GV by dropping lock typing in favour of hypersequents.
For HGV, we proved *preservation* (Theorem \hyperlink{paper:separating-sessions-smoothly.8}{I.3.3}), the *tree-structure* of connections in configurations (Theorem \hyperlink{paper:separating-sessions-smoothly.11}{I.3.14}), *global progress* (Theorem \hyperlink{paper:separating-sessions-smoothly.13}{I.3.20}), the *diamond property* (Theorem \hyperlink{paper:separating-sessions-smoothly.13}{I.3.21}), and *termination* (Theorem \hyperlink{paper:separating-sessions-smoothly.13}{I.3.22}).
We related HGV to GV by means of a translation from GV to HGV (Theorem \hyperlink{paper:separating-sessions-smoothly.14}{I.4.3}) and a translation from HGV to GV (Corollary \hyperlink{paper:separating-sessions-smoothly.16}{I.4.7}).
We related HGV to HCP by means of two translations, which translate HGV to HCP via fine-grain call-by-value HGV, and proved that the latter translation preserves types (Lemma \hyperlink{paper:separating-sessions-smoothly.20}{I.5.9}), and that it gives rise to a sound and complete operational correspondence (Theorem \hyperlink{paper:separating-sessions-smoothly.20}{I.5.11}).
Finally, I introduced a variant of GV which uses cuts, instead of lock typing, and compared Hypersequent GV to GV with lock typing and GV with cuts.

In the future, it would be interesting to extend Hypersequent GV with the extensions for GV described in previous work, such as unlimited types [@LindleyM15:gv], fixed points [@LindleyM16:recgv], polymorphism [@LindleyM17:fst], and exceptions [@FowlerLMD19:egv].
Furthermore, it would be interesting to describe the construction of GV compositionally, as the combination of a process calculus and a λ-calculus.
