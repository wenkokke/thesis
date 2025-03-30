# Legend and Errata {#hgv-legend-and-errata}

```{=latex}
\gvset1%
```

The conventions and terminology in \Cref{paper:separating-sessions-smoothly} are different from those used in the rest of this thesis.

- The terms and types of *both* Hypersequent CP and Hypersequent GV are printed in $\paperItmcolorname$ and $\paperItycolorname$, respectively, and are rendered in a font with serif. The keywords in HGV's syntax are bolded.
- The names for the rules of structural congruence, reduction, and the type system differ slightly from those used for HCP in @hcp.
- Instead of including a single rule for congruence under evaluation contexts, the paper includes separate congruence rules for name restriction and parallel composition (\Rule{HGV-E-Res} and \Rule{HGV-E-Par}).
- Instead of the *connection graph*, the paper uses the "abstract process structure" (§ \hyperlink{paper:separating-sessions-smoothly.8}{I.3.1},  Definition \hyperlink{paper:separating-sessions-smoothly.10}{I.3.9}), which is derived from a hyper-environment and co-name set, as opposed to the configuration.
- Instead of *ready thread*, the paper uses the term "blocked thread" (§ \hyperlink{paper:separating-sessions-smoothly.8}{I.3.1}, Definition \hyperlink{paper:separating-sessions-smoothly.12}{I.3.16}.)
- The duality for HCP is written as $\hpexp1{\hpPerp\hpA}$ rather than $\hpexp1{\co\hpA}$ (see Figure \hyperlink{paper:separating-sessions-smoothly.16}{I.6}).
- The lts for HCP (see Figure \hyperlink{paper:separating-sessions-smoothly.17}{I.7}) combines a number of action rules into \Rule{HCP-Act-Pref}, renames \Rule{H-Act-Offer1} and \Rule{H-Act-Offer2} to \Rule{HCP-Act-Off-Inl} and \Rule{HCP-Act-Off-Inr}, respectively, makes the distinction between α-transition and β-transition explicit in the rules for $\hpexp1{\hpTau}$-transition, rather than a post-facto restriction, replaces the congruence rule \Rule{H-Str-Cong} with individual congruence rules for name restriction and parallel composition (\Rule{HCP-Str-Res}, \Rule{HCP-Str-Par1}, and \Rule{HCP-Str-Par2}), and renames \Rule{H-Str-Par} to \Rule{HCP-Str-Syn}.

To the best of my knowledge, there are no significant errors in \Cref{paper:separating-sessions-smoothly}, but there are a small number of typesetting errors:

- The definition of internal and external choice (§ \hyperlink{paper:separating-sessions-smoothly.3}{I.3}, under "\hyperlink{paper:separating-sessions-smoothly.8}{Choice}") define $\gvS\gvtyPlus\gvS'$ and $\gvS\gvtyWith\gvS'$ in terms of $\gvS_1$ and $\gvS_2$, rather than $\gvS$ and $\gvS'$. The correct definitions are:
  $$
      \gvS\gvtyPlus\gvS'
      \defeq
      \gvtySend{\gvtyUnit}{\gvtySend{\gvty\lparen\co{\gvS}\gvtySum\co{\gvS'}\gvty\rparen}{\gvtyEnd!}}
    \qquad
      \gvS\gvtyWith\gvS'
      \defeq
      \gvtyRecv{\gvtyUnit}{\gvtyRecv{\gvty\lparen\gvS\gvtySum\gvS'\gvty\rparen}{\gvtyEnd?}}
  $$
- The defintion of an *abstract process structure* (§ \hyperlink{paper:separating-sessions-smoothly.8}{I.3.1}, Definition \hyperlink{paper:separating-sessions-smoothly.10}{I.3.9}) uses the function $\envs$ without prior definition. The function maps hyper-environments to sets of environments, and may be defined as $\envs(\gvGG_1\gvHTens\dots\gvHTens\gvGG_n)\defeq\{\gvGG_1,\dots,\gvGG_n\}$.
- The definition of a *ground configuration* (§ \hyperlink{paper:separating-sessions-smoothly.8}{I.3.1}, Definition \hyperlink{paper:separating-sessions-smoothly.12}{I.3.19}) states that a configuration $\gvC$ is a ground configuration if $\gvSUnit\gvSeq\gvC:\gvT$, amongst other conditions.
  This is syntactically ill-formed, as $\gvT$ is not a configuration type, and should be $\gvSUnit\gvSeq\gvC:\gvtyMain\:\gvT$.
- One of \Rule{GV-TG-Connect1} and \Rule{GV-TG-Connect2} can be elided from GV's configuration typing rules (Figure \hyperlink{paper:separating-sessions-smoothly.13}{I.5}) without compromising type preservation of reduction, since reduction is only defined on bound endpoints and one can always dualise the type of the bound endpoints.
  Having both comes at a cost, as parallel compositions no longer have unique typing derivations.
  Fortunately, the problem is easily addressed by eliding either \Rule{GV-TG-Connect1} or \Rule{GV-TG-Connect2}.

  The rules \Rule{GV-TG-Connect1} and \Rule{GV-TG-Connect2} were mistakenly reproduced from @Fowler19:thesis.
  In @Fowler19:thesis's GV, both rules are needed, since reduction is allowed outside of the scope of a name restriction, and therefore, it is not possible to dualise the type of the locked channel without breaking preservation. However, the version of GV presented in this chapter only permits reduction under a name restriction.
- The proof of *global progress* (§ \hyperlink{paper:separating-sessions-smoothly.8}{I.3.1}, Theorem \hyperlink{paper:separating-sessions-smoothly.13}{I.3.20}) states that any ground configuration that cannot be reduced can be written as:
  $$
    \gvCNew(\gvx_1\gvy_1)(
      \gvChild\:\gvTA_1
      \gvCPar
      \gvtm\dots
      \gvCPar
      \gvCNew(\gvx_n\gvy_n)(
        \gvChild\:\gvTA_n
        \gvCPar
        \gvMain\:\gvV
      )
      \gvtm\dots
    )
  $$
  This is syntactically ill formed, as $\gvTA$ denotes an auxiliary thread, which already includes the thread flag $\gvChild$. The correct statement is:
  $$
    \gvCNew(\gvx_1\gvy_1)(
      \gvTA_1
      \gvCPar
      \gvtm\dots
      \gvCPar
      \gvCNew(\gvx_n\gvy_n)(
        \gvTA_n
        \gvCPar
        \gvMain\:\gvV
      )
      \gvtm\dots
    )
  $$
- The statement of the *diamond property* (§ \hyperlink{paper:separating-sessions-smoothly.8}{I.3.1}, Theorem \hyperlink{paper:separating-sessions-smoothly.13}{I.3.21}) is:
  $$
    \text{If }
    \gvHG\gvSeq\gvCC:\gvT
    \text{, }
    \gvCC\gvEval\gvCD
    \text{, }
    \gvCC\gvEval\gvCD'
    \text{, then }
    \gvCD\gvEquiv\gvCD'
    \text{.}
  $$
  This does not hold---and, arguably, is not the diamond property---since it does not permit the result to perform any reductions. Hence, if the reductions $\gvCC\gvEval\gvCD$ and $\gvCC\gvEval\gvCD'$ eliminate different redexes, there is no leeway to eliminate the redex targeted by $\gvCC\gvEval\gvCD$ in $\gvCD'$ and vice versa.
  The correct statement is:
  $$
  \!\!
  \begin{array}{l}
    \text{If }
    \gvHG\gvSeq\gvCC:\gvT
    \text{ and }
    \gvCC\gvEval\gvCD_1
    \text{ and }
    \gvCC\gvEval\gvCD_2
    \text{, then either }\gvCD_1\gvEquiv\gvCD_2
    \\
    \text{or there exists some }
    \gvCD_3
    \text{ such that }
    \gvCD_1\gvEval\gvCD_3
    \text{ and }
    \gvCD_2\gvEval\gvCD_3
    \text{.}
  \end{array}
  $$
- The definition of *flattening* (§ \hyperlink{paper:separating-sessions-smoothly.13}{I.4}, Definition \hyperlink{paper:separating-sessions-smoothly.14}{I.4.1}) translates the empty hyper-environment to the empty hyper-environment, i.e., $\hvFlat\hvHUnit=\hvHUnit$.  
  This is incorrect, as the codomain of flattening is HGV *typing environments*, and the empty typing environment is denoted by $\hvSUnit$.
  The correct definition is $\hvFlat\hvHUnit=\hvSUnit$.
