Proof.
  ~ @summary
    The proof proceeds by picking the tree corresponding to $\hpGG$ from the connection forest, using the isomorphism constructed by @proposition:hcp-connection-forest, and then iteratively picking its leaves and rewriting the corresponding process to right-branching form, as in @proposition:cp-right-branching-form.

    (For the full proof, see @hcp-omitted-proofs.)
  ~ @omitted
    By @proposition:hcp-connection-forest, $\connection(\hpP)$ is a forest and some component $T$ is a tree such that $\fn(\hpGG)=\fn(\vertices[T])$.
    By induction, guarded by the size of $T$.

    - Case $\card{\vertices[T]}=1$.

      There is some thread $\hpR$ such that $\vertices[T]=\{\hpR\}$, and some evaluation context $\hpEE$ such that $\hpP=\hpEE[\hpR]$.
      As $T$ is a component of $\connection(\hpP)$, $\fn(\hpR)\cap\bn(\hpEE)=\emptyset$.
      By @corollary:hcp-evaluation-context-commute-nil, $\hpP\hpEquivLPS\hpEE[\hpZ]\hpPar\hpR$.
      Let $\hpQ$ be $\hpEE[\hpZ]$.
      Recall that $\hpR$ is in right-branching form, as it is ready.

    - Case $\card{\vertices[T]}>1$.

      Let $\hpT_i$ be any leaf of $T$.
      As $\hpT_i$ is a leaf, exactly one free endpoint in $\hpT_i$ is bound in $\hpP$.
      Let us name that endpoint $\hpx$ and its dual $\hpx'$.
      There exist some $\hpEE_1$, $\hpEE_2$, $\hpEF_i$, $\hpEF_j$, and $\hpP_j$ such that
      $$
      \begin{array}{l@{\;\hpEquivLPS\;}ll}
      \hpP
      & \hpEE_1[
          \hpNew(\hpx\hpx')(
            \hpEE_2[
              \hpEF_i[\hpT_i]
              \hpPar
              \hpEF_j[\hpP_j]
            ]
          )
        ]
      & \langle
        \text{by~\cref{corollary:hcp-separation}}
        \rangle
      \\
      & \hpNew(\hpx\hpx')(
          \hpEE_1[
            \hpEE_2[
              \hpEF_i[\hpT_i]
              \hpPar
              \hpEF_j[\hpP_j]
            ]
          ]
        )
      & \langle
        \text{by~\cref{lemma:hcp-evaluation-context-commute-new}}
        \rangle
      \\
      & \hpNew(\hpx\hpx')(
          \hpEE_1[
            \hpEE_2[
              \hpEF_i[
                \hpT_i
                \hpPar
                \hpEF_j[\hpP_j]
              ]
            ]
          ]
        )
      & \langle
        \text{by~\cref{lemma:hcp-evaluation-context-commute-par}}
        \rangle
      \\
      & \hpNew(\hpx\hpx')(
          \hpT_i
          \hpPar
          \hpEE_1[
            \hpEE_2[
              \hpEF_i[
                \hpEF_j[
                  \hpP_j
                ]
              ]
            ]
          ]
        )
      & \langle
        \text{by~\cref{lemma:hcp-evaluation-context-commute-par}}
        \rangle
      \end{array}
      $$
      Let $\hpP'$ be $\hpEE_1[\hpEE_2[\hpEF_i[\hpEF_j[\hpP_j]]]]$.
      By @lemma:hcp-preservation-equiv, $\hpP'$ is well-typed.

      Let $T'$ be the tree formed by deleting the vertex $\hpT_i$ and its only edge from $T$.
      Clearly, $\card{\vertices[T]}=\card{\vertices[T']}+1$.
      Every thread in $\hpP$ is preserved in $\hpP'$, except $\hpT_i$. Therefore, the connection graph $\connection(\hpP')$ is the forest formed by replacing $T$ with $T'$.

      By induction with $\hpP'$, there exist processes $\hpQ$ and $\hpR'$ such that $\hpP'\hpEquivLPS\hpQ\hpPar\hpR'$ and $\hpR'$ is in right-branching form.
      Therefore,
      $$
      \begin{array}{l@{\;\hpEquivLPS\;}ll}
      \hpP
      & \hpNew(\hpx\hpx')(
          \hpT_i
          \hpPar
          \hpEE_1[
            \hpEE_2[
              \hpEF_i[
                \hpEF_j[
                  \hpP_j
                ]
              ]
            ]
          ]
        )
      & \mathrlap{%
            \langle
            \text{see above}
            \rangle
          }{\hphantom{
            \langle
            \text{by~\cref{corollary:hcp-separation}}
            \rangle
          }}
      \\
      & \hpNew(\hpx\hpx')(
          \hpT_i
          \hpPar
          \hptm(
            \hpQ
            \hpPar
            \hpR'
          \hptm)
        )
      & \langle
        \text{by induction}
        \rangle
      \\
      & \hpQ
        \hpPar
        \hpNew(\hpx\hpx')(
          \hpT_i
          \hpPar
          \hpR'
        )
      & \langle
        \text{by~\cref{lemma:hcp-evaluation-context-commute-par}}
        \rangle
      \end{array}
      $$
      Let $\hpR$ be $\hpNew(\hpx\hpx')(\hpT_i\hpPar\hpR')$.
      As $\hpR'$ is in right-branching tree form, $\hpR$ is in right-branching tree form.

      It remains to show that the processes $\hpQ$ and $\hpR$ have the correct types.

      For some $\hpGG_i$, $\hpGG_j$, and $\hpA$, $\hpT_i\hpSeq\hpGG_i,\hpx:\hpA$ and $\hpP_j\hpSeq\hpGG_j,\hpx':\co\hpA$.

      Since $\hpT_i$ is a leaf, the evaluation contexts $\hpEE_1$, $\hpEE_2$, and $\hpEF_i$ must preserve the contents of its typing environment $\hpGG_i$.
      In essence, we can assign $\hpEE_1$, $\hpEE_2$, and $\hpEF_i$ type schemas, rather than types.
      For some $\hpHG'$, $\hpHG'_i$, $\hpHG'_j$, $\hpGG'''$, $\hpGG''$, and $\hpGG'$ the evaluation contexts $\hpEE_1$, $\hpEE_2$, and $\hpEF_i$ have the following type schemas, and $\hpEF_j$ has the following type.
      $$
      \begin{array}{l@{\ }l@{\;\hpSeq\;}l@{\;\hpSeqTo\;}ll}
      \forall\hpGD.
      & \hpEE_1
      & \hpHG'
        \hpHTens
        \hpGG'',\hpGD
      & \hpHG
        \hpHTens
        \hpGG',\hpGD
      & \text{or}
      \\
      \forall\hpGD.
      & \hpEE_1
      & \hpHG'
        \hpHTens
        \hpGG'',\hpx':\co\hpA
        \hpHTens
        \hpGD
      & \hpHG
        \hpHTens
        \hpGG',\hpx':\co\hpA
        \hpHTens
        \hpGD
      \\
      \forall\hpGD.
      & \hpEE_2
      & \hpHG'_i
        \hpHTens
        \hpHG'_j
        \hpHTens
        \hpGG''',\hpx':\co\hpA
        \hpHTens
        \hpGD
      & \hpHG'
        \hpHTens
        \hpGG'',\hpx':\co\hpA
        \hpHTens
        \hpGD
      \\
      \forall\hpGD.
      & \hpEF_i
      & \hpGD
      & \hpHG'_i
        \hpHTens
        \hpGD
      \\
      & \hpEF_j
      & \hpGG_j,\hpx':\co\hpA
      & \hpHG'_j\hpHTens\hpGG''',\hpx':\co\hpA
      \end{array}
      $$
      Hence, $\hpGG=\hpGG',\hpGG_i$ and $\hpP'\hpSeq\hpHG\hpHTens\hpGG',\hpx':\co\hpA\hpHTens\hpGG_i,\hpx:\hpA$.

      By induction, $\hpQ\hpSeq\hpHG$ and $\hpR'\hpSeq\hpGG',\hpx':\co\hpA$. Hence, $\hpR\hpSeq\hpGG$.
