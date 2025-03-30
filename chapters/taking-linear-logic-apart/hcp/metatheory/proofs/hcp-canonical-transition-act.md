Proof.
  ~ By induction on the derivation of the transition $\hpP\hpTo{\hpAct}\hpQ$.
    The cases for \Rule{H-Act-Link1}, \Rule{H-Act-Link2}, \Rule{H-Act-send}, \Rule{H-Act-Recv}, \Rule{H-Act-Close}, \Rule{H-Act-Wait}, \Rule{H-Act-Select1}, \Rule{H-Act-Select2}, \Rule{H-Act-Offer1}, or \Rule{H-Act-Offer2} follow immediately.
    The case for \Rule{H-Str-Cong} follows by induction, composing the evaluation context introduced by \Rule{H-Str-Cong} with the evaluation context in the induction hypothesis.
