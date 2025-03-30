# Linearity {#cp-linearity}

CP has a *linear* type system. It ensures that resources are always used exactly once, and never copied or dropped.
Given the correspondence between CP and linear logic, that seems almost painfully obvious.
However, due to CP's reuse of endpoint names, it may appear that resources are used multiple times. (For instance, the process $\cpWait\cpx.\cpClose\cpx.\cpZ$ appears to use the endpoint $\cpx$ twice.)

The true measure of a linear calculus lies in its execution.
Any execution should use all linear resources exactly once.
Unfortunately, such a formulation of linearity is a bit tedious.

For my purposes, it suffices to define linearity by counting the uses of free endpoint names---taking the sum across any parallel composition, and the union across an offer.
This formulation reveals the implicit rebinding of names in CP's actions.
For instance, the action $\cpRecv\cpx\cpy.\cpP$ uses the name $\cpx$, but then binds a *fresh* $\cpx$ for the remainder of the session.

Definition (Free Name Count) {#cp-free-name-count}.
  ~ The multiset of free endpoints in $\cpP$, written $\msfn(\cpP)$, is a multiset [see @definition:multiset] with support set $\fn(\cpP)$ and multiplicity function $\msmfn{\cpP}$.
    $$
    \begin{array}{lrl}
    \msfn(\cpLink\cpx\cpy)
    & \defeq
    & \lbag\cpx,\cpy\rbag
    \\
    \msfn(\cpNew(\cpx\cpx')(\cpP\cpPar\cpQ))
    & \defeq
    & (\msfn(\cpP)\setminus\{\cpx\})
      +
      (\msfn(\cpQ)\setminus\{\cpx'\})
    \\
    \msfn(\cpSend\cpx\cpy.(\cpP\cpPar\cpQ))
    & \defeq
    & {\lbag\cpx\rbag}
      +
      (\msfn(\cpP)\setminus\{\cpy\})
      +
      (\msfn(\cpQ)\setminus\{\cpx\})
    \\
    \msfn(\cpClose\cpx.0)
    & \defeq
    & {\lbag\cpx\rbag}
    \\
    \msfn(\cpRecv\cpx\cpy.\cpP)
    & \defeq
    & {\lbag\cpx\rbag}
      +
      (\msfn(\cpP)\setminus\{\cpx,\cpy\})
    \\
    \msfn(\cpWait\cpx.\cpP)
    & \defeq
    & {\lbag\cpx\rbag}
      +
      \msfn(\cpP)
    \\
    \msfn(\cpSelect\cpx<1.\cpP)
    & \defeq
    & {\lbag\cpx\rbag}
      +
      (\msfn(\cpP)\setminus\{\cpx\})
    \\
    \msfn(\cpSelect\cpx<2.\cpP)
    & \defeq
    & {\lbag\cpx\rbag}
      +
      (\msfn(\cpP)\setminus\{\cpx\})
    \\
    \msfn(\cpOffer\cpx(\cpInl: \cpP; \cpInr: \cpQ))
    & \defeq
    & {\lbag\cpx\rbag}
      +
      (
        (\msfn(\cpP)\setminus\{\cpx\})
        \cup
        (\msfn(\cpQ)\setminus\{\cpx\})
      )
    \\
    \msfn(\cpAbsurdZap\cpx\cpNN)
    & \defeq
    & {\lbag\cpx\rbag}
      +
      \lbag\cpw\mid\cpw\in\cpNN\rbag
    \end{array}
    $$
    Note that the operation $\msX\setminus{X}$ removes all occurrences of the elements in the set $X$ from the multiset $\msX$ (see @definition:multiset).

The only unusual case is the case for the absurd offer $\cpAbsurdZap\cpx\cpNN$, which counts all names in $\cpNN$ as used.
This seems wrong, since the absurd offer never uses the names in $\cpNN$.
However, it is correct in the tedious sense.
All executions of $\cpAbsurdZap\cpx\cpNN$ use all the names in $\cpNN$, trivially, since $\cpAbsurdZap\cpx\cpNN$ is never executed.

For actions, $\msfn$ removes all previous occurrences of the relevant name, which hides any potential non-linear usage of that name, e.g., $\msfn(\cpWait\cpx.\cpP)\defeq\lbag\cpx\rbag+(\msfn(\cpP)\setminus\{\cpx\})$ hides the count of $\cpx$ in $\cpP$.
Hence, $\msfn$ is *shallow*, in the sense that it only accurately counts the top-most parallel usages of the name. This suffices for my purposes.

Linearity states that, for well-typed processes, each endpoint in the typing environment is used exactly once in the process, and vice versa.

Proposition (Linearity) {#cp-linearity}.
  ~ If $\cpP\cpSeq\cpGG$, then:

    - $\cpx\in^k\msfn(\cpP) \implies k=1$
    - $\cpx\in^1\msfn(\cpP) \iff \cpx\in\fn(\cpGG)$

Proof.
  ~ By induction on the derivation of $\cpP\cpSeq\cpGG$.

For any well-typed process $\cpEE[\cpP]$, each endpoint bound by $\cpEE$ is used exactly once in the process $\cpP$, and vice versa.

Corollary {#cp-linearity-evaluation-context}.
  ~ If $\cpEE[\cpP]\cpSeq\cpGG$, then:

    - $\cpx\in^k\msfn(\cpP) \implies {k=1}$
    - $\cpx\in^1\msfn(\cpP) \iff \cpx\in\bn(\cpEE)$
    - $\bn(\cpEE)\subseteq\fn(\cpP)$

For any well-typed configuration $\cpCC^n[\cpP_1\cptm,\cptm\dots\cptm,\cpP_n]$, the processes $\cpP_1$, ..., $\cpP_n$ must collectively use all the endpoints bound by $\cpCC^n$ exactly once.

Corollary {#cp-linearity-configuration-context}.
  ~ If $\cpCC^n[\cpP_1\cptm,\cptm\dots\cptm,\cpP_n]\cpSeq\cpGG$, then:

    - $\cpx\in^k\bigcup_{1 \leq i \leq n}\msfn(\cpP_i) \implies {k=1}$
    - $\cpx\in^1\bigcup_{1 \leq i \leq n}\msfn(\cpP_i) \iff \cpx\in\bn(\cpCC)$
    - $\bn(\cpCC)\subseteq\bigcup_{1 \leq i \leq n}\fn(\cpP_i)$
