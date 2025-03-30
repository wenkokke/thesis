Proof.
  ~ @summary
    I will give the high-level intuition behind the proof, and give the formal proof for several interesting cases in @cp-omitted-proofs.

    Recall that commuting conversions commute an action past a cut, e.g.,
    to$$
    \cpNew(\cpz\cpz')(\underline{\cpRecv\cpx\cpy.}\cpP\cpPar\cpQ)
    \cpEvalCC
    \underline{\cpRecv\cpx\cpy.}\cpNew(\cpz\cpz')(\cpP\cpPar\cpQ)
    $$

    Recall that cut reductions eliminate actions, e.g.,
    $$
    \cpNew(\cpx\cpx')(
    \underline{\cpSend\cpx\cpy.}\cptm(\cpP\cpPar\cpQ\cptm)
    \cpPar
    \underline{\cpRecv{\cpx'}{\cpy'}.}\cpR
    )
    \cpEval
    \cpNew(\cpy\cpy')(
    \cpP
    \cpPar
    \cpNew(\cpx\cpx')(\cpQ\cpPar\cpR)
    )
    $$

    It follows that for any reduction $\cpP\cpEvalCC\cpEval\cpR$ there are two options. The commuting conversion and cut reduction either act on *the same action* or on *different actions*:

    - If they act on *the same action*, the commuting conversion is being used to move the action into place for the cut reduction. We can do this using the structural congruence instead.
    - Otherwise, the two reduction steps act on *different actions* in different subprocesses. We can postpone the commuting conversion.

    Unfortunately, we cannot easily formalize this high-level intuition, as actions are not a standalone syntactic sort in CP.
    Therefore, the formal proof proceeds by induction on the cut reduction $\cpEval\cpR$ followed by inversion on the commuting conversion $\cpP\cpEvalCC$.

    (For the full proof, see @cp-omitted-proofs.)
  ~ @omitted
    By induction on the cut reduction $\cpEval\cpR$ followed by inversion on the commuting conversion $\cpP\cpEvalCC$.
    The induction is guarded by the decreasing length of the derivation of the cut reduction.
    We examine three cases:

    1.  The cut reduction uses \Rule{C-E-Send} and is of the form (reusing $\cpP$ and $\cpR$)
        $$
        \cpNew(\cpx\cpx')(
        \cpSend\cpx\cpy.(\cpP\cpPar\cpQ)
        \cpPar
        \cpRecv{\cpx'}{\cpy'}.\cpR
        )
        \cpEval
        \cpNew(\cpy\cpy')(
        \cpP
        \cpPar
        \cpNew(\cpx\cpx')(\cpQ\cpPar\cpR)
        )
        $$
        By inversion, there are six cases for the commuting conversion.
        It uses either \Rule{C-CC-Send1}, \Rule{C-CC-Send2}, or \Rule{C-CC-Recv} under \Rule{C-CC-Cong}, or the symmetric version of any of these.
        We examine only the case where the reduction uses \Rule{C-CC-Recv} under \Rule{C-CC-Cong} and is of the form (reusing $\cpP$, $\cpQ$, and $\cpR$)
        $$
        \begin{array}{lll}
        \multicolumn{3}{l}{
        \cpNew(\cpx\cpx')(
        \cpSend\cpx\cpy.(\cpP\cpPar\cpQ)
        \cpPar
        \cpNew(\cpz\cpz')(\cpRecv{\cpx'}{\cpy'}.\cpR\cpPar\cpR')
        )}
        \\
        & \cpEvalCC &
        \cpNew(\cpx\cpx')(
        \cpSend\cpx\cpy.(\cpP\cpPar\cpQ)
        \cpPar
        \cpRecv{\cpx'}{\cpy'}.\cpNew(\cpz\cpz')(\cpR\cpPar\cpR')
        )
        \\
        & \cpEval &
        \cpNew(\cpy\cpy')(
        \cpP
        \cpPar
        \cpNew(\cpx\cpx')(\cpQ\cpPar\cpNew(\cpz\cpz')(\cpR\cpPar\cpR'))
        )
        \end{array}
        $$
        We replace the use of the commuting conversion with two uses of the structural congruence:
        $$
        \begin{array}{lll}
        \multicolumn{3}{l}{
        \cpNew(\cpx\cpx')(
        \cpSend\cpx\cpy.(\cpP\cpPar\cpQ)
        \cpPar
        \cpNew(\cpz\cpz')(\cpRecv{\cpx'}{\cpy'}.\cpR\cpPar\cpR')
        )}
        \\
        & \cpEquiv &
        \cpNew(\cpz\cpz')(
        \cpNew(\cpx\cpx')(
        \cpSend\cpx\cpy.(\cpP\cpPar\cpQ)
        \cpPar
        \cpRecv{\cpx'}{\cpy'}.\cpR
        )
        \cpPar\cpR'
        )
        \\
        & \cpEval &
        \cpNew(\cpz\cpz')(
        \cpNew(\cpy\cpy')(
        \cpP
        \cpPar
        \cpNew(\cpx\cpx')(\cpQ\cpPar\cpR)
        )
        \cpPar\cpR'
        )
        \\
        & \cpEquiv &
        \cpNew(\cpy\cpy')(
        \cpP
        \cpPar
        \cpNew(\cpx\cpx')(\cpQ\cpPar\cpNew(\cpz\cpz')(\cpR\cpPar\cpR'))
        )
        \end{array}
        $$
    2.  The cut reduction uses \Rule{C-E-Cong} and is of the form (reusing $\cpP$)
        $$
        \cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)
        \cpEval
        \cpNew(\cpx\cpx')(\cpP'\cpPar\cpQ)
        $$
        The premise to \Rule{C-E-Cong} is of the form $\cpP\cpEval\cpP'$.
        By inversion, there are two cases for the commuting conversion.
        It uses \Rule{C-CC-Cong}.

        a.  The reduction uses \Rule{C-CC-Cong} and is of the form
            $$
            \cpNew(\cpx\cpx')(\cpP''\cpPar\cpQ)
            \cpEvalCC
            \cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)
            \cpEval
            \cpNew(\cpx\cpx')(\cpP'\cpPar\cpQ)
            $$
            The premise to \Rule{C-CC-Cong} is of the form $\cpP''\cpEvalCC\cpP$.
            The induction hypothesis gives us either $\cpP''\cpEval\cpEvalCC\cpP'$ or $\cpP''\cpEval\cpP'$.
            In either case, the result follows immediately.

        b.  The reduction uses \Rule{C-CC-Cong} and is of the form
            $$
            \cpNew(\cpx\cpx')(\cpP\cpPar\cpQ')
            \cpEvalCC
            \cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)
            \cpEval
            \cpNew(\cpx\cpx')(\cpP'\cpPar\cpQ)
            $$
            The premise to \Rule{C-CC-Cong} is of the form $\cpQ'\cpEvalCC\cpQ$.
            The two reduction steps act on parallel processes, and can be reordered:
            $$
            \cpNew(\cpx\cpx')(\cpP\cpPar\cpQ')
            \cpEval
            \cpNew(\cpx\cpx')(\cpP'\cpPar\cpQ')
            \cpEvalCC
            \cpNew(\cpx\cpx')(\cpP'\cpPar\cpQ)
            $$

      2.  The cut reduction uses \Rule{C-E-Equiv} and is of the form
          $\cpQ\cpEquiv\cpQ'\cpEval\cpR'\cpEquiv\cpR$.
          The premise to \Rule{C-E-Equiv} is of the form $\cpQ'\cpEval\cpR'$.
          The induction hypothesis, applied to $\cpP\cpEvalCC\cpEquiv\cpQ'\cpEval\cpR'$, gives us either $\cpP\cpEval\cpEvalCC\cpR'$ or $\cpP\cpEval\cpR'$.
          The result follows as $\cpP\cpEval\cpEvalCC\cpEquiv\cpR$ or $\cpP\cpEval\cpEquiv\cpR$, respectively.
