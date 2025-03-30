Proof.
  ~ @summary
    By iteratively commuting all commuting conversion past each reduction using @lemma:cp-commuting-conversions-swap-star.
    (For the full proof, see @cp-omitted-proofs.)
  ~ @omitted
    By induction on the length of the reduction $\cpP\wcpEval*\cpR$.

    There are three cases:

    1.  The length is $0$.

        The result follows by reflexivity.

    2.  The length is $N+1$ and the reduction is of the form
        $\cpP\wcpEval*\cpR'\cpEval\cpR$.

        By induction, we have $\cpP\cpEval*\cpEvalCC*\cpR'$.
        Hence, $\cpP\cpEval*\cpEvalCC*\cpR'\cpEval\cpR$.

        The result follows by @lemma:cp-commuting-conversions-swap-star.

    3.  The length is $N+1$ and the reduction is of the form
        $\cpP\wcpEval*\cpR'\cpEvalCC\cpR$.

        By induction, we have $\cpP\cpEval*\cpEvalCC*\cpR'$.
        Hence, $\cpP\cpEval*\cpEvalCC*\cpR'\cpEvalCC\cpR$.

        The result follows immediately.
