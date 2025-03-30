# Legend and Errata {#priorities-legend-and-errata}

The conventions and terminology in \Cref{paper:prioritise-the-best-variation} are different from those used in the rest of this thesis.

- The terms, types, and priorities of *both* Priority CP and Priority GV are printed in $\paperIItmcolorname$, $\paperIItycolorname$, and $\paperIIprcolorname$, respectively, and are rendered in an italicised or bolded font with serif.
- The names for the rules of structural congruence, reduction, and the type system differ slightly from those used for HGV in @hgv and for HCP in @hcp.
- The following changes relate to the presentation of PCP:

  - Duality is written as $\ppA^\perp$ instead of $\co{\ppA}$.
  - The absurd offer is written as $\ppAbsurd\ppx$ instead of $\ppAbsurdZap\ppx\ppNN$.
  - Reduction is not definitionally closed under evaluation contexts, as by \Rule{H-E-Cong}. Instead, there are separate congruence rules for name restriction and parallel composition (\Rule{P-E-LiftRes} and \Rule{P-E-LiftPar}).
  - A *ready* process is called an "action" and a process *ready to act on* some endpoint is said to "act on" that endpoint (§ \hyperlink{paper:separating-sessions-smoothly.29}{II.4.5}, Definition \hyperlink{paper:prioritise-the-best-variation.29}{II.4.1}).
  - There is no proof of Progress analogous to @proposition:hcp-progress.
    Instead, the paper proves Closed Progress
    (§ \hyperlink{paper:separating-sessions-smoothly.29}{II.4.5}, Theorem \hyperlink{paper:prioritise-the-best-variation.29}{II.4.4}).
  - There is no definition of *canonical form* analogous to @definition:hcp-canonical-form, which includes both normal and neutral forms.
    (The latter is not needed for Closed Progress. Hence, $\ppZ$ suffices.)  
    Unfortunately, the paper uses the name "canonical form" to refer to a form that serves the same purpose as the *maximum configuration context* or *right-branching form*, i.e., the form
    $$
      \ppNew(\ppx_1\ppx'_1)%
      \pptm{\cdots}%
      \ppNew(\ppx_n\ppx'_n)%
      \pptm\lparen%
      \ppP_1
      \ppPar
      \pptm{\cdots}%
      \ppPar
      \ppP_m
      \pptm\rparen%
    $$
    where each process $\ppP_i$ (for $1 \leq i \leq m$) is ready
    (§ \hyperlink{paper:separating-sessions-smoothly.29}{II.4.5}, Definition \hyperlink{paper:prioritise-the-best-variation.29}{II.4.2}).
- The following changes relate to the presentation of PGV:

  - Configuration typing does not use configuration types, as in @hgv, but omits the type of the value returned by the configuration, as, e.g., in @LindleyM15:gv (see Figure \hyperlink{paper:prioritise-the-best-variation.9}{II.2}).

There are minor errors in \Cref{paper:prioritise-the-best-variation}:

- The text states that "Priority GV is more flexible than GV" and "more expressive than GV" (§ \hyperlink{paper:separating-sessions-smoothly.4}{II.2}), which is not true, as we discuss in @pcp-relation-to-cp.
- The text states that "PLL [Priority Linear Logic] is an extension of CLL"  (§ \hyperlink{paper:separating-sessions-smoothly.4}{II.4.4}), which---when taken as a statement about proofs---is not true, as we discuss in @pcp-relation-to-cp. The next sentence, which states that "PCP is not in correspondence with CLL" implies the previous statement concerns provability, rather than proofs, and while this is not known to be false, it remains unproven.
- The defintion of *normal form* (§ \hyperlink{paper:prioritise-the-best-variation.22}{II.3.2}, Definition \hyperlink{paper:prioritise-the-best-variation.24}{I.3.11}) reads "a configuration $\gvexp1{\gvCC}$ is in normal form if it is of the form
  $$
  \gvexp1{%
    \gvCNew(\gvx_1\gvx^\prime_1)%
    \gvtm\dots%
    \gvCNew(\gvx_n\gvx^\prime_n)(
    \gvCChild\gvM_1
    \gvCPar
    \gvtm\dots
    \gvCPar
    \gvCChild\gvM_m
    \gvCPar
    \gvCMain\gvV
  )}
  $$
  where each $\gvexp1{\gvM_i}$ is ready to act on $\gvexp1{\gvx_i}$."
  Instead, the final part of the phrase should read "where each $\gvexp1{\gvM_i}$ (for $1 \leq i \leq m$) is ready to act on some $\gvexp1{\gvx_j}$ (for $1 \leq j \leq n$) or some free channel endpoint."
- *Closed Progress* (Theorem \hyperlink{paper:prioritise-the-best-variation.29}{II.4.4}) is stated using equality rather than structural congruence.
  The correct statement is:
  $$
    \text{If }
    \ppP\ppSeq\ppSBot
    \text{, then either }\ppP\ppEquiv\ppQ
    \text{ or there exists a }\ppQ
    \text{ such that }\ppP\ppEval\ppQ
  $$
- In the proof for Lemma \hyperlink{paper:prioritise-the-best-variation.37}{II.4.8}, the cases for $\ppSelect{\ppx}<1.\ppP$ and $\ppSelect{\ppx}<2.\ppP$ erroneously list the premise and conclusion of the reduction as $\CtoGM(\ppSend{\ppx}{\ppy}.\ppP)$ and $\CtoGC(\ppSend{\ppx}{\ppy}.\ppP)$, rather than $\CtoGM(\ppSelect{\ppx}<1.\ppP)$ and $\CtoGC(\ppSelect{\ppx}<1.\ppP)$, and $\CtoGM(\ppSelect{\ppx}<1.\ppP)$ and $\CtoGC(\ppSelect{\ppx}<2.\ppP)$, respectively. The intermediate steps are correct.
