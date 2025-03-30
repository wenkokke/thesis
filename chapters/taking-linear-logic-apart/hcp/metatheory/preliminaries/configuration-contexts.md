# Configuration Contexts {#hcp-configuration-contexts}

Configuration contexts are multi-hole process contexts that consist only of name restrictions, parallel compositions, and the terminated process.

The notion of configuration contexts generalises neatly from CP to HCP.
We follow the changes made to the process language, and decompose the cut into name restriction and parallel composition, and add a new constructor for the terminated process.
The latter leads to an important distinction between CP and HCP configuration contexts, which is that HCP configuration contexts can have *zero* holes.

Definition (Configuration Context) {#hcp-configuration-context}.
  ~ *Configuration contexts* are $n$-hole process contexts, as defined by the following grammar:
    $$
    \hpCC, \hpCD
      \Coloneq \hpHole
          \mid \hpZ
          \mid \hpNew(\hpx\hpx')\hpCC
          \mid \hpCC\hpPar\hpCD
    $$
    If there is risk of ambiguity, we explicitly write the number of holes in a configuration context with a superscript, e.g., as $\hpCC^n$.

    Plugging is defined by replacing the $n$ holes with $n$ processes, left to right:
    $$
    {\setlength\arraycolsep{0pt}
    \begin{array}{llllrl}
    \hpHole
    & \,\hptm[
    & \hpP
    & \hptm]
    & \;\defeq\;
    & \hpP
    \\
    \hpZ
    & \,\hptm[
    &
    & \hptm]
    & \;\defeq\;
    & \hpZ
    \\
    \hpNew(\hpx\hpx')\hpCC^n
    & \,\hptm[
    & \hpP_1\hptm, \hptm\dots\hptm, \hpP_n
    & \hptm]
    & \;\defeq\;
    & \hpNew(\hpx\hpx')(\hpCC^n[\hpP_1,\hptm\dots,\hpP_n])
    \\
    \hptm({\hpCC^n}\hpPar{\hpCD^k}\hptm)
    & \,\hptm[
    & \hpP_1\hptm, \hptm\dots\hptm, \hpP_n\hptm, \hpP_{n+1}\hptm, \hptm\dots\hptm, \hpP_{n+k}
    & \hptm]
    & \;\defeq\;
    & \hptm(
      \hpCC^n[\hpP_1,\hptm\dots,\hpP_n]
      \hpPar
      \hpCD^k[\hpP_{n+1},\hptm\dots,\hpP_{n+k}]
    \hptm)
    \end{array}}
    $$
    I write
    ${
      \hpCC[
        \hpP_1
        ,\hptm\dots,
        \hpHole_i
        ,\hptm\dots,
        \hpP_n
      ]
    }$
    for the evaluation context focused on the $i$'th hole in $\hpCC$ such that
    ${
      \hpCC[
        \hpP_1
        ,\hptm\dots,
        \hpHole_i
        ,\hptm\dots,
        \hpP_n
      ]\hpPlug[
        \hpP_i
      ]
      =
      \hpCC[
        \hpP_1
        ,\hptm\dots,
        \hpP_i
        ,\hptm\dots,
        \hpP_n
      ]
    }$.

    I write $\dn(\hpCC)$ for the unordered pairs of dual endpoints bound by $\hpCC$.
    $$
    \begin{array}{lrl}
    \dn(\hpHole)
    & \defeq
    & \emptyset
    \\
    \dn(\hpZ)
    & \defeq
    & \emptyset
    \\
    \dn(\hpNew(\hpx\hpx')\hpCC)
    & \defeq
    & \{\{\hpx,\hpx'\}\}\cup\dn(\hpCC)
    \\
    \dn(\hpCC\hpPar\hpCD)
    & \defeq
    & \dn(\hpCC)\cup\dn(\hpCD)
    \end{array}
    $$
    I write $\bn(\hpCC)$ for the endpoints bound by $\hpCC$, i.e.,
    $\bn(\hpCC)\defeq\bigcup\dn(\hpCC)$.

    I write $\hpCC^n\hpSeq\hpHG_1\mid\dots\mid\hpHG_n\hpSeqTo\hpHG$ to mean that the configuration context $\hpCC^n$ is well-typed under input hyper-environments $\hpHG_1, \dots, \hpHG_n$ and output hyper-environment $\hpHG$.
    I use "$\cdot$" and "$\hpHG_1\vert\dots\vert\hpHG_n$" to denote sequences of hyper-environments, which correspond, in left-to-right order, to the holes in the configuration context.
    $$
    \begin{array}{c}
      \AXC{}
      \UIC{$\hpHole\hpSeq\hpHG\hpSeqTo\hpHG$}
      \DP
      \quad
      \AXC{}
      \UIC{$\hpZ\hpSeq\cdot\hpSeqTo\hpHOne$}
      \DP
      \\ \noalign{\medskip}
      \AXC{$
        \hpCC^n
        \hpSeq
        \hpHG_1\mid\dots\mid\hpHG_n
        \hpSeqTo
        \hpHG
        \hpHTens
        \hpGG,\hpx:\hpA
        \hpHTens
        \hpGD,\hpx':\co\hpA
      $}
      \UIC{$
        \hpNew(\hpx\hpx')\hpCC^n
        \hpSeq
        \hpHG_1\mid\dots\mid\hpHG_n
        \hpSeqTo
        \hpHG
        \hpHTens
        \hpGG,\hpGD
      $}
      \DP
      \\ \noalign{\medskip}
      \AXC{$
        \hpCC^n
        \hpSeq
        \hpHG_1\mid\dots\mid\hpHG_n
        \hpSeqTo
        \hpHG
      $}
      \AXC{$
        \hpCD^k
        \hpSeq
        \hpHH_{n+1}\mid\dots\mid\hpHH_k
        \hpSeqTo
        \hpHH
      $}
      \BIC{$
        \hpCC^n\hpPar\hpCD^k
        \hpSeq
        \hpHG_1\mid\dots\mid\hpHG_n
        \mid
        \hpHH_{n+1}\mid\dots\mid\hpHH_k
        \hpSeqTo
        \hpHG,\hpHH
      $}
      \DP
    \end{array}
    $$
