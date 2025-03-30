Proof.
  ~ @summary
    By iteratively permuting each commuting conversion past the reduction using @lemma:cp-commuting-conversions-swap.
    (For the full proof, see @cp-omitted-proofs.)
  ~ @omitted
    By induction on the length of the reduction $\cpP\cpEvalCC*$.

    There are two cases:

    1.  The length is $0$.

        The reduction is of the form
        $\cpP\cpEval\cpEvalCC*\cpR$.

        The result follows immediately.

    2.  The length is $N+1$.

        The reduction is of the form
        $\cpP\cpEvalCC*\cpP'\cpEvalCC\cpEval\cpR'\cpEvalCC*\cpR$.

        By @lemma:cp-commuting-conversions-swap, one of two cases must hold:

        a.  There is a reduction $\cpP'\cpEval\cpEvalCC\cpR'$.

            Hence,
            $\cpP\cpEvalCC*\cpP'\cpEval\cpEvalCC\cpR'\cpEvalCC*\cpR$.

            The result follows from the induction hypothesis.

        b.  There is a reduction $\cpP'\cpEval\cpR'$.

            Hence,
            $\cpP\cpEvalCC*\cpP'\cpEval\cpR'\cpEvalCC*\cpR$.

            The result follows from the induction hypothesis.
