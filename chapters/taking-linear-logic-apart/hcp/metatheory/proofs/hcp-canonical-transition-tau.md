Proof.
  ~ By induction on the structure of the transition.
    The cases for \Rule{H-Tau-Link}, \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Close-Wait}, \Rule{H-Tau-Select-Offer1}, or \Rule{H-Tau-Select-Offer2} follow by @lemma:hcp-canonical-transition-par.
    The case for \Rule{H-Str-Cong} follows by induction, composing the evaluation context introduced by \Rule{H-Str-Cong} with the evaluation context in the induction hypothesis.
