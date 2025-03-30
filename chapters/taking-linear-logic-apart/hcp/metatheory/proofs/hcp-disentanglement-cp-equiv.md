Proof.
  ~ By induction on the derivation of $\hpP\hpSeq\hpHG$ and inversion on $\hpP$. There are three distinct cases, based on whether $\hpP$ is a link, some other ready process, or some other process construct.

    - Case $\hpP\iotf\hpLink\hpx\hpy$.

      By inversion on $\hpP\hpEquiv\hpQ$, there are two cases. Either $\hpQ=\hpLink\hpx\hpy$, in which case the result follows by reflexivity, or $\hpQ=\hpLink\hpy\hpx$, in which case the result follows by \Rule{C-SC-LinkComm}.

    - Case $\hpP$ is of the form $\hpSend\hpx\hpy.\hpP'$, $\hpRecv\hpx\hpy.\hpP'$, $\hpClose\hpx.\hpP'$, $\hpWait\hpx.\hpP'$, $\hpSelect\hpx<1.\hpP'$, or $\hpSelect\hpx<2.\hpP'$.

      By inversion on $\hpP\hpEquiv\hpQ$, $\hpQ$ is of the form $\hpSend\hpx\hpy.\hpQ'$, $\hpRecv\hpx\hpy.\hpQ'$, $\hpClose\hpx.\hpQ'$, $\hpWait\hpx.\hpQ'$, $\hpSelect\hpx<1.\hpQ'$, or $\hpSelect\hpx<2.\hpQ'$.
      By the induction hypothesis, $\DisHtoM(\hpP')\mpEquiv\DisHtoM(\hpQ')$.
      The result follows by congruence.

    - Case $\hpP$ is of the form $\hpOffer\hpx(\hpInl:\hpP_1;\hpInr:\hpP_2)$.

      As above, but with two appeals to the induction hypothesis.

    - Case $\hpP$ is of the form $\hpAbsurdZap\hpx\hpNN$.

      By inversion on $\hpP\hpEquiv\hpQ$, $\hpP=\hpQ$.
      The result follows by reflexivity.

    - Case $\hpP$ is of the form $\hpNew(\hpx\hpx')\hpP'$, $\hpP_1\hpPar\hpP_2$, or $\hpZ$.

      By @lemma:hcp-equiv-decompose, there exists some $\hpR$ such that $\hpP\hpEquivLPS\hpR$ and $\hpR\hpEquivD\hpQ$.
      By @lemma:hcp-disentanglement-closed,
      $\hpBigDis(\hpP)=\hpBigDis(\hpR)$.
      Hence, $\DisHtoM(\hpP)=\DisHtoM(\hpR)$.
      We have $\hpR\iotf\hpCC^n[\hpT_1,\hptm\dots,\hpT_n]$ for some $n \geq 0$.
      By inversion on the structure of $\hpCC$, decompose $\hpR\hpEquivD\hpQ$ into separate structural congruences for each thread $\hpT_i\hpEquiv\hpT'_i$ for $1 \leq i \leq n$.
      (The "deep" restriction is not lost. For ready processes, $\hpEquivD$ is exactly $\hpEquiv$.)
      By the induction hypothesis, $\DisHtoM(\hpT_i)\mpEquiv\DisHtoM(\hpT'_i)$ for $1 \leq i \leq n$.
      The result follows by composing these intermediate results using @lemma:hcp-disentanglement-distributes-over-maximum-configuration-context.
