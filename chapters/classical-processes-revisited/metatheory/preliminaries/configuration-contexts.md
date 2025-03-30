# Configuration Contexts {#cp-configuration-context}

Processes in CP can be rewritten to right-branching form:
$$
\cpNew(\cpx_1\cpx'_1)(
  \cpP_1\cpPar\cptm\cdots\cpNew(\cpx_n\cpx'_n)(
    \cpP_n\cpPar\cpP_{n+1})\cptm\cdots)
$$
Right-branching form is a convenient form to work with. It neatly captures the prefix of top-level cuts and the connected processes, and it relates the endpoints and processes in a predictable manner---each $\cpx_i$ is free in $\cpP_i$, and each $\cpx'_i$ is free in some $\cpP_j$ where $j > i$.

Right-branching form has its downsides.
Proving that processes can be rewritten to right-branching form is far from trivial [@proposition:cp-right-branching-form].
More importantly, right-branching form is a quirk of CP's rigid process structure. In variants of CP with more expressive process structure, processes cannot be rewritten to right-branching form.

I generalise right-branching form using *configuration contexts*.
Configuration contexts are multi-hole process contexts that consist only of cuts. For instance, for the process above, an example configuration context is
$$
\cpNew(\cpx_1\cpx'_1)(
  \cpHole_1\cpPar\cptm\cdots\cpNew(\cpx_n\cpx'_n)(
    \cpHole_n\cpPar\cpHole_{n+1})\cptm\cdots)
$$
The expressions $\cpHole_1$, ..., $\cpHole_{n+1}$ are the $n+1$ holes, numbered from left to right for convenience.
The name $\cpCC^k$ ranges over configuration contexts, where $k$ denotes the number of holes.
Plugging, written $\cpCC^k\cptm[\cpP_1\cptm,\cptm\dots\cptm,\cpP_k\cptm]$, replaces the holes, from left to right, with the processes $\cpP_1$, ..., $\cpP_k$, such that each $\cpHole_i$ is replaced with the process $\cpP_i$ (for $1 < i \leq k$).
If $\cpCC^{n+1}$ refers to the example configuration context shown above and $\cpP_1$, ..., $\cpP_{n+1}$ to the processes of the example process shown above, then $\cpCC^{n+1}\cptm[\cpP_1\cptm,\cptm\dots\cptm,\cpP_{n+1}\cptm]$ is exactly equal to the example process.
The use of right-branching form requires that the prefix of cuts is a right-branching tree, i.e., a list.
Configuration contexts permit arbitrary trees.

Definition (Configuration Context) {#cp-configuration-context}.
  ~ *Configuration contexts* are $n$-hole process contexts, as defined by the following grammar:
    $$
    \cpCC, \cpCD \Coloneq \cpHole \mid \cpNew(\cpx\cpx')(\cpCC\cpPar\cpCD)
    $$
    If there is risk of ambiguity, we explicitly write the number of holes in a configuration context with a superscript, e.g., as $\cpCC^n$.

    Plugging is defined by replacing the $n$ holes with $n$ processes, left to right:
    $$
    {\setlength\arraycolsep{0pt}
    \begin{array}{llllrl}
    \cpHole
    & \,\cptm[
    & \cpP
    & \cptm]
    & \;\defeq\; &
    \cpP
    \\
    \cpNew(\cpx\cpx')({\cpCC^n}\cpPar{\cpCD^k})
    & \,\cptm[
    & \cpP_1\cptm, \cptm\dots\cptm, \cpP_n\cptm, \cpP_{n+1}\cptm, \cptm\dots\cptm, \cpP_{n+k}
    & \cptm]
    & \;\defeq\; &
    \cpNew(\cpx\cpx')(
      {\cpCC^n}\cptm[\cpP_1\cptm,\cptm\dots\cptm,\cpP_n\cptm]
      \cpPar
      {\cpCD^k}\cptm[\cpP_{n+1}\cptm, \cptm\dots\cptm, \cpP_{n+k}\cptm]
    )
    \end{array}}
    $$
    I write
    ${
      \cpCC[
        \cpP_1
        \cptm,\cptm\dots\cptm,
        \cpHole_i
        \cptm,\cptm\dots\cptm,
        \cpP_n
      ]
    }$
    for the evaluation context focused on the $i$'th hole in $\cpCC$ such that
    ${
      \cpCC[
        \cpP_1
        \cptm,\cptm\dots\cptm,
        \cpHole_i
        \cptm,\cptm\dots\cptm,
        \cpP_n
      ]\cpPlug[
        \cpP_i
      ]
      =
      \cpCC[
        \cpP_1
        \cptm,\cptm\dots\cptm,
        \cpP_i
        \cptm,\cptm\dots\cptm,
        \cpP_n
      ]
    }$.

    I write $\dn(\cpCC)$ for the unordered pairs of dual endpoints bound by $\cpCC$.
    $$
    \begin{array}{lrl}
    \dn(\cpHole)
    & \defeq
    & \emptyset
    \\
    \dn(\cpNew(\cpx\cpx')(\cpCC\cpPar\cpCD))
    & \defeq
    & \{\{\cpx,\cpx'\}\}\cup\dn(\cpCC)\cup\dn(\cpCD)
    \end{array}
    $$
    I write $\bn(\cpCC)$ for the endpoints bound by $\cpCC$, i.e.,
    $\bn(\cpCC)\defeq\bigcup\dn(\cpCC)$.

    I write $\cpCC^n\cpSeq\cpGG_1\mid\dots\mid\cpGG_n\cpSeqTo\cpGG$ to mean that the configuration context $\cpCC^n$ is well-typed under input typing contexts $\cpGG_1, \dots, \cpGG_n$ and output typing context $\cpGG$.
    $$
      \def\fCenter{\cpSeq}
      \def\defaultHypSeparation{}
      \AXC{$\vphantom{,\co\cpA}$}
      \UI$\cpHole \fCenter \cpGG \cpSeqTo \cpGG$
      \DP
      \quad
      \AX$\cpCC^n
          \fCenter
          \cpGG_1\mid\dots\mid\cpGG_n
          \cpSeqTo
          \cpGG, \cpx:\cpA$
      \AX$\cpCD^k
          \fCenter
          \cpGD_1\mid\dots\mid\cpGD_k
          \cpSeqTo
          \cpGD, \cpx':\co\cpA$
      \BI$\cpNew(\cpx\cpx')(\cpCC^n\cpPar\cpCD^k)
          \fCenter
          \cpGG_1\mid\dots\mid\cpGG_n
          \mid
          \cpGD_1\mid\dots\mid\cpGD_k
          \cpSeqTo
          \cpGG, \cpGD$
      \DP
    $$
