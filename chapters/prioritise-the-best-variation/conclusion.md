# Conclusion {#priorities-conclusion}

In this chapter, we introduced Priority GV with its typing rules, reduction semantics, and metatheory, and we revisited Priority CP with its typing rules, reduction semantics, and metatheory, and introduced an operational correspondence between PCP and PGV.
Priority CP and Priority GV are variants of CP and GV that use priority typing to permit processes with benign cyclic connections.
For PGV, we proved *preservation* (Theorem \hyperlink{paper:prioritise-the-best-variation.20}{II.3.5}) and *global progress* (Theorem \hyperlink{paper:prioritise-the-best-variation.24}{II.3.14}).
For PCP, we dropped the commuting conversions, which cause @DardhaG18:pcp's PCP to be non-confluent, from the reduction semantics, we added the additive units, and we proved *preservation* (Theorem \hyperlink{paper:prioritise-the-best-variation.20}{II.3.5}), and proved that *global progress* (Theorem \hyperlink{paper:prioritise-the-best-variation.24}{II.3.14}) continues to hold.
We related PCP to PGV by means of a translation, proved that it preserves types (Theorem \hyperlink{paper:prioritise-the-best-variation.32}{II.4.6}), and proved that it gives rise to a complete (Theorem \hyperlink{paper:prioritise-the-best-variation.35}{II.4.7}) and sound (Theorem \hyperlink{paper:prioritise-the-best-variation.38}{II.4.10}) operational correspondence.
I demonstrated that PCP and PGV are not extensions of CP and GV, respectively, and that PCP does not satisfy identity expansion.
Finally, I introduced priority inference for PCP.

I conjecture that multiplicative PCP---the fragment ($\ppTens$,$\ppOne$,$\ppParr$,$\ppBot$)---does extend multiplicative CP, and proving this would be an interesting topic for future work.
It is easily verified that most typing rules for multiplicative CP preserve essential acyclicity of the priority graph.
The exception is cut.
I conjecture that a successful proof for cut proceeds by induction on the cut formula, and relies on *splitting*---the property that the subgraphs of the priority graph which are reachable from the arguments of a tensor are disjoint.

It would be interesting to investigate the exact relation between priority graphs and proof nets.
Certainly, they are not equivalent, since priority graphs encode the order in which the sequent calculus rules are used.
However, I conjecture that if priority graphs were extended with type information, they would contain sufficient information to reconstruct the entire typing derivation, and hence, they encode the entire process.

It would be interesting to extend PCP and PGV with fixed points, following @LindleyM16:recgv and @Padovani14:priorites, and with first- and second-order quantifiers, interpreted as priority and type polymorphism.

Finally, it would be interesting to investigate solutions for the expressivity of additives in priority-based calculi by extending the structure of priority graphs with choice, e.g., by boxing, as done in the proof nets of linear logic [@Girard87:ll].
