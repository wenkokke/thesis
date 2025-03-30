Proof.
  ~ By induction on the derivation of the transition $\hpP\hpTo{\hpAct}\hpQ$.
    The case for \Rule{H-Str-Par} follows by @lemma:hcp-canonical-transition-act.
    The case for \Rule{H-Str-Cong} follows by induction, composing the evaluation context introduced by \Rule{H-Str-Cong} with the evaluation context in the induction hypothesis.
