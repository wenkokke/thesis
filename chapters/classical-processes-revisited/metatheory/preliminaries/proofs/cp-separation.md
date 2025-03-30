Proof.
  ~ By induction on the structure of the configuration context $\cpCC$.

    There are two cases:

    - $\cpP_i$ and $\cpP_j$ are on different sides of the cut.

      There are two cases, corresponding to the two equations:

      - $\cpP_i$ is to the left and $\cpP_j$ is to the right.

        ${
          \cpP=
          \cpNew(\cpx\cpx')(
            \cpCC_i[
              \cpP_1\cptm,\cptm\dots\cptm,\cpP_i\cptm,\cptm\dots\cptm,\cpP_k]
            \cpPar
            \cpCC_j[
              \cpP_{k+1}\cptm,\cptm\dots\cptm,\cpP_j\cptm,\cptm\dots\cptm,\cpP_n]
          )
        }$.

        By $\cpP\cpSeq\cpGG$ and \Rule{C-T-Cut}, the bound endpoints must be $\{\cpx,\cpx'\}$.

        Let
        ${
          \begin{array}{lrl}
            \cpEE
            & =
            & \cpHole
            \\
            \cpEF_i
            & =
            & \cpCC_i[
                  \cpP_1\cptm,\cptm\dots\cptm,\cpHole_i\cptm,\cptm\dots\cptm,\cpP_k]
            \\
            \cpEF_j
            & =
            & \cpCC_j[
                  \cpP_{k+1}\cptm,\cptm\dots\cptm,\cpHole_j\cptm,\cptm\dots\cptm,\cpP_n]
          \end{array}
        }$

        The result follows.

      - $\cpP_i$ is to the right and $\cpP_j$ is to the left.

        As above.
        <!--
        ${
          \cpP=
          \cpNew(\cpx'\cpx)(
            \cpCC_j[
              \cpP_1\cptm,\cptm\dots\cptm,\cpP_j\cptm,\cptm\dots\cptm,\cpP_k]
            \cpPar
            \cpCC_i[
              \cpP_{k+1}\cptm,\cptm\dots\cptm,\cpP_i\cptm,\cptm\dots\cptm,\cpP_n]
          )
        }$.

        By $\cpP\cpSeq\cpGG$ and \Rule{C-T-Cut}, the bound endpoints must be $\{\cpx',\cpx\}$.

        Let
        ${
          \begin{array}{lrl}
            \cpEE
            & =
            & \cpHole_j
            \\
            \cpEF_j
            & =
            & \cpCC_j[
                  \cpP_1\cptm,\cptm\dots\cptm,\cpHole_j\cptm,\cptm\dots\cptm,\cpP_k]
            \\
            \cpEF_i
            & =
            & \cpCC_i[
                  \cpP_{k+1}\cptm,\cptm\dots\cptm,\cpHole_i\cptm,\cptm\dots\cptm,\cpP_n]
          \end{array}
        }$

        The result follows.
        -->

    - $\cpP_i$ and $\cpP_j$ are on the same side of the cut.

      There are two cases:

      - $\cpP_i$ and $\cpP_j$ are both to the left.

        ${
          \cpP=
          \cpNew(\cpz\cpz')(
            \cpCD[\cpP_1\cptm,\cptm\dots\cptm,\cpP_k]
            \cpPar
            \cpR
          )
        }$
        and $1 \leq i, j \leq k$.

        By $\cpP\cpSeq\cpGG$ and \Rule{C-T-Cut}, the bound endpoints $\{\cpz,\cpz'\}$ cannot be $\{\cpx,\cpx'\}$.

        By induction, one of the following holds:

        - ${
            \cpCD[\cpP_1\cptm,\cptm\dots\cptm,\cpP_k]
            =
            \cpEE'[\cpNew(\cpx\cpx')(
              \cpEF_i[\cpP_i]\cpPar\cpEF_j[\cpP_j])]
          }$; or
        - ${
            \cpCD[\cpP_1\cptm,\cptm\dots\cptm,\cpP_k]
            =
            \cpEE'[\cpNew(\cpx'\cpx)(
              \cpEF_j[\cpP_j]\cpPar\cpEF_i[\cpP_i])]
          }$.

        Let $\cpEE=\cpNew(\cpz\cpz')(\cpEE'\cpPar\cpR)$.

        The result follows.

      - $\cpP_i$ and $\cpP_j$ are both to the right.

        As above.
        <!--
        ${
          \cpP=
          \cpNew(\cpz\cpz')(
            \cpQ
            \cpPar
            \cpCD[\cpP_{k+1}\cptm,\cptm\dots\cptm,\cpP_n]
          )
        }$
        and $k < i, j \leq n$.

        By $\cpP\cpSeq\cpGG$ and \Rule{C-T-Cut}, the bound endpoints $\{\cpz',\cpz\}$ cannot be $\{\cpx',\cpx\}$.

        By induction, one of the following holds:

        - ${
            \cpCD[\cpP_{k+1}\cptm,\cptm\dots\cptm,\cpP_n]
            =
            \cpEE'[\cpNew(\cpx\cpx')(
              \cpEF_i[\cpP_i]\cpPar\cpEF_j[\cpP_j])]
          }$; or
        - ${
            \cpCD[\cpP_{k+1}\cptm,\cptm\dots\cptm,\cpP_n]
            =
            \cpEE'[\cpNew(\cpx'\cpx)(
              \cpEF_j[\cpP_j]\cpPar\cpEF_i[\cpP_i])]
          }$.

        Let $\cpEE=\cpNew(\cpz\cpz')(\cpQ\cpPar\cpEE')$.

        The result follows.
        -->
