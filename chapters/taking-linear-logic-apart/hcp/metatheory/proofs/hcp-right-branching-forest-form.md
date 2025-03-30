Proof.
  ~ @summary
    The proof proceeds by iteratively picking typing environments in the hyper-environment and moving the corresponding process to the top-level in right-branching tree form using @lemma:hcp-right-branching-tree-form.

    (For the full proof, see @hcp-omitted-proofs.)
  ~ @omitted
    By induction on the hyper-environment $\hpHG$.

    - Case $\hpHG$ is of the form $\hpHOne$.

      By @lemma:hcp-hyper-consistency, $\hpP\hpEquivLPS\hpZ$.
      Let $\hpQ$ be $\hpZ$.
      The result follows.

    - Case $\hpHG$ is of the form $\hpHG\hpHTens\hpGG$ (reusing $\hpHG$).

      By @lemma:hcp-right-branching-tree-form, there exist processes $\hpP'$ and $\hpR$ such that $\hpP'\hpSeq\hpHG$, $\hpR\hpSeq\hpGG$, $\hpP\hpEquivLPS\hpP'\hpPar\hpR$, and $\hpR$ is in right-branching tree form.

      By induction, there exists a process $\hpQ'$ such that $\hpP'\hpEquivLPS\hpQ'$ and $\hpQ'$ is in right-branching forest form.
      There are two cases:

      - If $\hpQ'=\hpZ$, let $\hpQ$ be $\hpR$.
        By inversion, $\hpHG=\hpHOne$.
        The result follows, as, by \Rule{H-SC-ParNil}, $\hpP\hpEquivLPS\hpR$, and $\hpR$ is in right-branching forest form.

      - Otherwise, let $\hpQ$ be $\hpQ'\hpPar\hpR$.
        The result follows, as $\hpP\hpEquivLPS\hpQ$ and $\hpQ$ is in right-branching forest form.
