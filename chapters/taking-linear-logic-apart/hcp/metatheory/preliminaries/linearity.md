# Linearity {#hcp-linearity}

HCP has a *linear* type system. It ensures that resources are always used exactly once, and never copied or dropped.
However, due to HCP's reuse of endpoint names, it may appear that resources are used multiple times. (For instance, the process $\hpWait\hpx.\hpClose\hpx.\hpZ$ appears to use the endpoint $\hpx$ twice.)

I define linearity by means of a free name count---taking the sum across a parallel composition, the union across an offer, and counting the absurd offer as using all available resources.
The definition of the free name count is easily adapted to HCP.
(For an in-depth discussion, see @cp-linearity.)

Definition (Free Name Count) {#hcp-free-name-count}.
  ~ The multiset of free endpoints in $\hpP$, written $\msfn(\hpP)$, is a multiset [see @definition:multiset] with support set $\fn(\hpP)$ and multiplicity function $\msmfn{\hpP}$.
    $$
    \begin{array}{lrl}
    \msfn(\hpLink\hpx\hpy)
    & \defeq
    & \lbag\hpx,\hpy\rbag
    \\
    \msfn(\hpNew(\hpx\hpx')\hpP)
    & \defeq
    & \msfn(\hpP)\setminus\{\hpx,\hpx'\}
    \\
    \msfn(\hpP\hpPar\hpQ)
    & \defeq
    & \msfn(\hpP)
      +
      \msfn(\hpQ)
    \\
    \msfn(\hpZ)
    & \defeq
    & \lbag\rbag
    \\
    \msfn(\hpSend\hpx\hpy.\hpP)
    & \defeq
    & {\lbag\hpx\rbag}
      + \:
      (\msfn(\hpP)\setminus\{\hpx,\hpy\})
    \\
    \msfn(\hpClose\hpx.0)
    & \defeq
    & {\lbag\hpx\rbag}
    \\
    \msfn(\hpRecv\hpx\hpy.\hpP)
    & \defeq
    & {\lbag\hpx\rbag}
      + \:
      (\msfn(\hpP)\setminus\{\hpx,\hpy\})
    \\
    \msfn(\hpWait\hpx.\hpP)
    & \defeq
    & {\lbag\hpx\rbag} + \msfn(\hpP)
    \\
    \msfn(\hpSelect\hpx<1.\hpP)
    & \defeq
    & {\lbag\hpx\rbag}
      + \:
      (\msfn(\hpP)\setminus\{\hpx\})
    \\
    \msfn(\hpSelect\hpx<2.\hpP)
    & \defeq
    & {\lbag\hpx\rbag}
      + \:
      (\msfn(\hpP)\setminus\{\hpx\})
    \\
    \msfn(\hpOffer\hpx(\hpInl: \hpP; \hpInr: \hpQ))
    & \defeq
    & {\lbag\hpx\rbag}
      + \:
      ((\msfn(\hpP)\setminus\{\hpx\}) \cup (\msfn(\hpQ)\setminus\{\hpx\}))
    \\
    \msfn(\hpAbsurdZap\hpx\hpNN)
    & \defeq
    & {\lbag\hpx\rbag + \lbag\hpw\mid\hpw\in\hpNN\rbag}
    \end{array}
    $$
    Note that the operation $\msX\setminus{X}$ removes all occurrences of the elements in the set $X$ from the multiset $\msX$ (see @definition:multiset).

Linearity states that, for well-typed processes, each endpoint in the typing environment is used exactly once in the process, and vice versa.

Proposition (Linearity) {#hcp-linearity}.
  ~ If $\hpP\hpSeq\hpHG$, then:

    - $\hpx \in^k \msfn(\hpP) \implies k=1$
    - $\hpx \in^1 \msfn(\hpP) \iff \hpx\in\fn(\hpHG)$

Proof.
  ~ By induction on the derivation of $\hpP\hpSeq\hpHG$.

For any well-typed process $\hpEE[\hpP]$, each endpoint bound by $\hpEE$ is used exactly once in the process $\hpP$, and vice versa.

Corollary {#cp-linearity-evaluation-context}.
  ~ If $\hpEE[\hpP]\hpSeq\hpHG$, then:

    - $\hpx\in^k\msfn(\hpP) \implies {k=1}$
    - $\hpx\in^1\msfn(\hpP) \iff \hpx\in\bn(\hpEE)$
    - $\bn(\hpEE)\subseteq\fn(\hpP)$

For any well-typed configuration $\hpCC^n[\hpP_1,\hptm\dots,\hpP_n]$, the processes $\hpP_1$, ..., $\hpP_n$ must collectively use all the endpoints bound by $\hpCC^n$ exactly once.

Corollary {#cp-linearity-evaluation-context}.
  ~ If $\hpCC^n[\hpP_1,\hptm\dots,\hpP_n]\hpSeq\hpHG$, then:

    - $\hpx\in^k\bigcup_{1 \leq i \leq n}\msfn(\hpP_i) \implies {k=1}$
    - $\hpx\in^1\bigcup_{1 \leq i \leq n}\msfn(\hpP_i) \iff \hpx\in\bn(\hpCC)$
    - $\bn(\hpCC)\subseteq\bigcup_{1 \leq i \leq n}\fn(\hpP_i)$
