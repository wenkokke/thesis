Proof.
  ~ @summary
    By induction on the derivation of the structural congruence $\hpP\hpEquiv\hpQ$ and inversion on the transition $\hpP\hpTo\hpLab\hpP'$.

    (For the full proof, see @hcp-omitted-proofs.)
  ~ @omitted
    Unfolding the compositions of the structural congruence and the transition relations, the goal is as follows:
    $$
      \hpP\hpEquiv\hpP' \land \hpP'\hpTo\hpLab\hpQ
      \implies
      \hpP\hpTo\hpLab\hpQ' \land \hpQ'\hpEquiv\hpQ
    $$
    I refer to the subgoals $\hpP\hpTo\hpLab\hpQ'$ and $\hpQ'\hpEquiv\hpQ$ as results (1) and (2), respectively.

    By induction on the derivation of the structural congruence $\hpP\hpEquiv\hpQ$ and inversion on the transition $\hpP\hpTo\hpLab\hpP'$.
    The case for reflexivity follows immediately. The cases for symmetric use of the rules of structural congruence follow by an analogy to the cases below. The case for transitivity follows by induction. The case for congruence follows by induction on the transition.

    - Case \Rule{H-SC-LinkComm}.

      The structural congruence is of the form:
      $$
      \hpLink\hpx\hpy
      \hpEquiv
      \hpLink\hpy\hpx
      $$
      By inversion on the transition:

      - Subcase \Rule{H-Act-Link1}.
        Result (1) follows by \Rule{H-Act-Link2}.
      - Subcase \Rule{H-Act-Link2}.
        Result (1) follows by \Rule{H-Act-Link1}.

      Result (2) follows by reflexivity.
    - Case \Rule{H-SC-ParNil}.

      The structural congruence is of the form (reusing $\hpP$):
      $$
      \hpP\hpPar\hpZ
      \hpEquiv
      \hpP
      $$
      Result (1) follows by \Rule{H-Str-Cong} with $\hpHole\hpPar\hpZ$.

      Result (2) follows by \Rule{H-SC-ParNil}.
    - Case \Rule{H-SC-ParComm}.

      The structural congruence is of the form (reusing $\hpP$ and $\hpQ$):
      $$
      \hpP\hpPar\hpQ
      \hpEquiv
      \hpQ\hpPar\hpP
      $$
      By inversion on the transition:

      - Subcase \Rule{H-Str-Par}.

        Result (1) follows as $\hpAct\hpLabPar\hpAct'$ is unordered.
      - Subcase \Rule{H-Str-Cong} with $\hpEE\hpPar\hpQ$.

        Result (1) follows by \Rule{H-Str-Cong} with $\hpQ\hpPar\hpEE$.
      - Subcase \Rule{H-Str-Cong} with $\hpP\hpPar\hpEE$.

        Result (1) follows by \Rule{H-Str-Cong} with $\hpEE\hpPar\hpP$.

      Result (2) follows by \Rule{H-SC-ParComm}.
    - Case \Rule{H-SC-ParAssoc}.

      The structural congruence is of the form (reusing $\hpP$ and $\hpQ$):
      $$
      \hpP\hpPar\hptm(\hpQ\hpPar\hpR\hptm)
      \hpEquiv
      \hptm(\hpP\hpPar\hpQ\hptm)\hpPar\hpR
      $$
      By inversion on the transition:

      - Subcase \Rule{H-Str-Par}.

        Result (1) follows as $\hpAct\hpLabPar\hpAct'$ is unordered.
      - Subcase \Rule{H-Str-Cong} with $\hpP\hpPar\hpHole$ then \Rule{H-Str-Par}.

        Result (1) follows as $\hpAct\hpLabPar\hpAct'$ is unordered.
      - Subcase \Rule{H-Str-Cong} with $\hpEE\hpPar\hptm(\hpQ\hpPar\hpR\hptm)$.

        Result (1) follows by \Rule{H-Str-Cong} with $\hptm(\hpEE\hpPar\hpQ\hptm)\hpPar\hpR$.
      - Subcase \Rule{H-Str-Cong} with $\hpP\hpPar\hptm(\hpEE\hpPar\hpR\hptm)$.

        Result (1) follows by \Rule{H-Str-Cong} with $\hptm(\hpP\hpPar\hpEE\hptm)\hpPar\hpR$.
      - Subcase \Rule{H-Str-Cong} with $\hpP\hpPar\hptm(\hpQ\hpPar\hpEE\hptm)$.

        Result (1) follows by \Rule{H-Str-Cong} with $\hptm(\hpP\hpPar\hpQ\hptm)\hpPar\hpEE$.

      Result (2) follows by \Rule{H-SC-ParAssoc}.
    - Case \Rule{H-SC-NewComm}.

      The structural congruence is of the form (reusing $\hpP$):
      $$
      \hpNew(\hpx\hpx')\hpP
      \hpEquiv
      \hpNew(\hpx'\hpx)\hpP
      $$
      By inversion on the transition.
      In the cases for \Rule{H-Tau-Link}, \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Close-Wait}, \Rule{H-Tau-Select-Offer1}, \Rule{H-Tau-Select-Offer2}, result (1) follows as $\hpAct\hpLabPar\hpAct'$ is unordered.

      In the cases for \Rule{H-Tau-Link} and \Rule{H-Tau-Close-Wait}, result (2) follows by reflexivity.
      In the cases for \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Select-Offer1}, \Rule{H-Tau-Select-Offer2}, result (2) follows by \Rule{H-SC-NewComm}.
    - Case \Rule{H-SC-NewAssoc}.

      The structural congruence is of the form  (reusing $\hpP$):
      $$
      \hpNew(\hpx\hpx')\hpNew(\hpy\hpy')\hpP
      \hpEquiv
      \hpNew(\hpy\hpy')\hpNew(\hpx\hpx')\hpP
      $$
      By inversion on the transition:

      - Subcases \Rule{H-Tau-Link}, \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Close-Wait}, \Rule{H-Tau-Select-Offer1}, or \Rule{H-Tau-Select-Offer2} then \Rule{H-Str-Cong} with $\hpNew(\hpy\hpy')\hpHole$.

        Result (1) follows by \Rule{H-Str-Cong} with $\hpNew(\hpy\hpy')\hpHole$ then \Rule{H-Tau-Link}, \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Close-Wait}, \Rule{H-Tau-Select-Offer1}, or \Rule{H-Tau-Select-Offer2}.

        In the cases for \Rule{H-Tau-Link} and \Rule{H-Tau-Close-Wait}, result (2) follows by reflexivity.
        In the cases for \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Select-Offer1}, \Rule{H-Tau-Select-Offer2}, result (2) follows by \Rule{H-SC-NewAssoc}.
      - Subcases \Rule{H-Str-Cong} with $\hpNew(\hpx\hpx')\hpHole$ then \Rule{H-Tau-Link}, \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Close-Wait}, \Rule{H-Tau-Select-Offer1}, or \Rule{H-Tau-Select-Offer2}.

        Result (1) follows by \Rule{H-Tau-Link}, \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Close-Wait}, \Rule{H-Tau-Select-Offer1}, or \Rule{H-Tau-Select-Offer2} then \Rule{H-Str-Cong} with $\hpNew(\hpx\hpx')\hpHole$.

        In the cases for \Rule{H-Tau-Link} and \Rule{H-Tau-Close-Wait}, result (2) follows by reflexivity.
        In the cases for \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Select-Offer1}, \Rule{H-Tau-Select-Offer2}, result (2) follows by \Rule{H-SC-NewAssoc}.
      - Subcase \Rule{H-Str-Cong} with $\hpNew(\hpx\hpx')\hpNew(\hpy\hpy')\hpHole$.

        Result (1) follows by \Rule{H-Str-Cong} with $\hpNew(\hpy\hpy')\hpNew(\hpx\hpx')\hpHole$.

        Result (2) follows by \Rule{H-SC-NewAssoc}.
    - Case \Rule{H-SC-ScopeExt}.

      The structural congruence is of the form (reusing $\hpP$ and $\hpQ$):
      $$
      \hpNew(\hpx\hpx')(\hpP\hpPar\hpQ)
      \hpEquiv
      \hpP\hpPar\hpNew(\hpx\hpx')\hpQ
      $$
      By inversion on the transition:

      - Subcases \Rule{H-Tau-Link}, \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Close-Wait}, \Rule{H-Tau-Select-Offer1}, or \Rule{H-Tau-Select-Offer2} then \Rule{H-Str-Par} or \Rule{H-Str-Cong} with $\hpEE\hpPar\hpQ$.

        Impossible. The side condition for \Rule{H-SC-ScopeExt} requires $\hpx,\hpx'\notin\fn(\hpP)$, but <!-- by @lemma:hcp-lts-ready and the premises of \Rule{H-Str-Par} or \Rule{H-Str-Cong} --> either $\hpx\in\fn(\hpP)$ or $\hpx'\in\fn(\hpP)$ must hold.
      - Subcases \Rule{H-Tau-Link}, \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Close-Wait}, \Rule{H-Tau-Select-Offer1}, or \Rule{H-Tau-Select-Offer2} then \Rule{H-Str-Cong} with $\hpP\hpPar\hpEE$.
        Result (1) follows by \Rule{H-Str-Cong} with $\hpP\hpPar\hpHole$, then \Rule{H-Tau-Link}, \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Close-Wait}, \Rule{H-Tau-Select-Offer1}, or \Rule{H-Tau-Select-Offer2}, then \Rule{H-Str-Cong} with $\hpEE$.

        In the cases for \Rule{H-Tau-Link} and \Rule{H-Tau-Close-Wait}, result (2) follows by reflexivity.
        In the cases for \Rule{H-Tau-Send-Recv}, \Rule{H-Tau-Select-Offer1}, \Rule{H-Tau-Select-Offer2}, result (2) follows by \Rule{H-SC-NewAssoc}.
      - Subcases \Rule{H-Str-Cong} with $\hpNew(\hpx\hpx')\hpHole$ then \Rule{H-Str-Par}.

        Result (1) follows by \Rule{H-Str-Par} then \Rule{H-Str-Cong} with $\hpNew(\hpx\hpx')\hpHole$.

        Result (2) follows by \Rule{H-SC-ScopeExt}.
      - Subcases \Rule{H-Str-Cong} with $\hpNew(\hpx\hpx')(\hpEE\hpPar\hpQ)$

        Result (1) follows by \Rule{H-Str-Cong} with $\hpEE\hpPar\hpNew(\hpx\hpx')\hpQ$

        Result (2) follows by \Rule{H-SC-ScopeExt}.
      - Subcases \Rule{H-Str-Cong} with $\hpNew(\hpx\hpx')(\hpP\hpPar\hpEE)$.

        Result (1) follows by \Rule{H-Str-Cong} with $\hpP\hpPar\hpNew(\hpx\hpx')\hpEE$.

        Result (2) follows by \Rule{H-SC-ScopeExt}.
