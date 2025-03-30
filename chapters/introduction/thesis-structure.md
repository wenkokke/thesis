## Thesis Structure

This thesis proceeds as follows.

- In \Cref{part:classical-processes-revisited}, I present a variant of Classical Processes without commuting conversions, which break confluence in @Wadler12:cpgv's CP, and show that this variant is free from deadlock and has adequate canonical forms.

- In \Cref{part:taking-linear-logic-apart}, I present Hypersequent CP, which is a session-typed process calculus based on CP with a tighter correspondence to the π-calculus, and Hypersequent GV, which is the corresponding session-typed concurrent λ-calculus.

- In \Cref{part:prioritise-the-best-variation}, I present a variant of Priority CP without commuting conversions and introduce Priority GV which is the corresponding session-typed concurrent λ-calculus.

- In \Cref{part:deadlock-free-session-types-in-linear-haskell}, I describe an implementation of session-typed channels based on GV and Priority GV in Linear Haskell.
