# Hypersequent Classical Processes {#hcp-hypersequent-classical-processes}

In this section, I introduce Hypersequent Classical Processes (HCP), a session-typed process calculus based on CP.
HCP's process calculus resembles the π-calculus more closely than CP, and its type system corresponds to a logic that is a slight variation of Classical Linear Logic, which I call Hypersequent Classical Linear Logic (HCLL).
To the best of my knowledge, HCLL does not exist in the literature, and is only implicitly defined in this thesis by means of squinting and ignoring the red parts.
HCLL is a well-behaved and interesting logic, and, moreover, a conservative extension of CLL.

The fundamental notions of programs and computation in HCP, as in CP, are processes and message-passing communication.
Processes communicate by passing messages over channels.
Communication channels are *binary*, which means that each channel has exactly two endpoints, and each endpoint is held by exactly one process.
Names refer to channel endpoints, rather than channels.

Processes (ranged over by $\hpP$, $\hpQ$, $\hpR$) are defined by the following grammar:
$$
  \begin{array}{l r l l}
    \hpP, \hpQ, \hpR
     & \Coloneq
     & \hpLink\hpx\hpy
     & \text{link}
    \\
     & \mid
     & \hpNew(\hpx\hpx')\hpP
     & \text{new}
    \\
     & \mid
     & \hpP\hpPar\hpQ
     & \text{parallel}
    \\
     & \mid
     & \hpZ
     & \text{terminated process}
    \\
     & \mid
     & \hpSend\hpx\hpy.\hpP
     & \text{send}
    \\
     & \mid
     & \hpRecv\hpx\hpy.\hpP
     & \text{receive}
    \\
     & \mid
     & \hpClose\hpx.\hpP
     & \text{close}
    \\
     & \mid
     & \hpWait\hpx.\hpP
     & \text{wait}
    \\
     & \mid
     & \hpSelect\hpx<1.\hpP
     & \text{select left}
    \\
     & \mid
     & \hpSelect\hpx<2.\hpP
     & \text{select right}
    \\
     & \mid
     & \hpOffer\hpx(\hpInl: \hpP; \hpInr: \hpQ)
     & \text{choice}
    \\
     & \mid
     & \hpAbsurdZap\hpx\hpNN
     & \text{absurd}
  \end{array}
$$
The names $\hpx$, $\hpy$, $\hpz$, and $\hpw$ range over the endpoints of communication channels---'channel endpoints' or 'endpoints' for short.
The names $\hpx'$, $\hpy'$, $\hpz'$, and $\hpw'$ as well as $\hpa$, $\hpb$, and $\hpc$ also range over endpoints, and are used with the same conventions as in @cp, which we revisit shortly.
The names $\hpNN$ and $\hpNM$ range over sets of endpoints.

An endpoint is *bound* in the following cases:

- In $\hpNew(\hpx\hpx')\hpP$, $\hpx$ and $\hpx'$ are bound in $\hpP$.
- In $\hpSend\hpx\hpy.\hpP$, $\hpy$ is bound in $\hpP$.
- In $\hpRecv\hpx\hpy.\hpP$, $\hpy$ is bound in $\hpP$.

An endpoint is *free* if it is not bound.
Notably, for $\hpAbsurdZap\hpx\hpNN$, $\hpx$ and all names in $\hpNN$ are free.
I write $\fn(\hpP)$ to denote the set of free endpoints in $\hpP$.
By convention, the names $\hpa$, $\hpb$, and $\hpc$ are used as a shorthand to imply to the reader that the endpoint is free.

Two endpoints are *dual* if they are bound by the same name restriction, e.g., in $\hpNew(\hpx\hpx')\hpP$, $\hpx$ and $\hpx'$ are bound in $\hpP$, and are dual.
By convention, the names $\hpx'$, $\hpy'$, $\hpz'$, and $\hpw'$ are used as a shorthand to imply duality to the reader, e.g., I use $\hpx$ and $\hpx'$ when they are dual endpoints of the same channel.

In HCP, as in CP, actions are not a well-defined syntactic sort. Nonetheless, I will informally write "action" in reference to the bit before the dot, e.g., the action for $\hpSend\hpx\hpy.(\hpP\hpPar\hpQ)$ is $\hpSend\hpx\hpy$.
For the troublemakers without a dot, $\hpOffer\hpx(\hpInl:\hpP;\hpInr:\hpQ)$ and $\hpAbsurdZap\hpx\hpNN$, I write $\hpOffer\hpx\hpInl$, $\hpOffer\hpx\hpInr$, and $\hpAbsurdZap\hpx$, respectively.

Types (ranged over by $\hpA$, $\hpB$) are the formulas of CLL, as defined by the following grammar:
$$
  \begin{array}{l r l r l r l r l r l r l r l r l}
    \hpA, \hpB
     & \Coloneq &
    \hpA \hpTens \hpB
     & \mid     &
    \hpOne
     & \mid     &
    \hpA \hpPlus \hpB
     & \mid     &
    \hpNil
    \\
     & \mid     &
    \hpA \hpParr \hpB
     & \mid     &
    \hpBot
     & \mid     &
    \hpA \hpWith \hpB
     & \mid     &
    \hpTop
  \end{array}
$$

Duality plays an important role in HCP, as it does in CP and CLL.
Viewed from the perspective of a logic, it corresponds to negation.
Viewed from the perspective of a process calculus, it guarantees session fidelity, i.e., that processes act on dual endpoints of the same channel in dual ways, e.g., one process sends when the other receives.
As in CP and CLL, duality is not defined as a type constructor, but as a function on types:
$$
  \begin{array}{l c l p{\arraycolsep} l c l}
    \co{\hpA \hpTens \hpB}
     & \defeq &
    \co\hpA \hpParr \co\hpB
     &   &
    \co\hpOne
     & \defeq &
    \hpBot
    \\
    \co{\hpA \hpParr \hpB}
     & \defeq &
    \co\hpA \hpTens \co\hpB
     &   &
    \co\hpBot
     & \defeq &
    \hpOne
    \\
    \co{\hpA \hpPlus \hpB}
     & \defeq &
    \co\hpA \hpWith \co\hpB
     &   &
    \co\hpNil
     & \defeq &
    \hpTop
    \\
    \co{\hpA \hpWith \hpB}
     & \defeq &
    \co\hpA \hpPlus \co\hpB
     &   &
    \co\hpTop
     & \defeq &
    \hpNil
  \end{array}
$$
As we will see, dual endpoints have dual types. The notation for duality ($\hpA$, $\co{\hpA}$) and the naming convention for dual endpoints ($\hpx$, $\hpx'$) were chosen to emphasize this.
Duality is involutive.

Lemma {#hcp-duality-involutive}.
  ~ $\co{\co\hpA} = \hpA$

Typing environments (ranged over by $\hpGG$, $\hpGD$) are sets of type assignments, as defined by the following grammar:
$$
  \hpGG, \hpGD \Coloneq \hpSBot \mid \hpGG, \hpx:\hpA
$$
The set of free endpoint names in a typing environment, written $\fn(\hpGG)$, is defined by recursion on the environment, i.e., $\fn(\hpSBot)\defeq\emptyset$ and $\fn(\hpGG, \hpx:\hpA)\defeq\fn(\hpGG)\cup\{\hpx\}$.
The extension $\hpGG, \hpx:\hpA$ is only defined when $\hpx$ is not free in $\hpGG$, i.e., $\hpx\notin\fn(\hpGG)$.

We write $\hpGG, \hpGD$ for the concatenation of typing environments $\hpGG$ and $\hpGD$.
The concatenation $\hpGG, \hpGD$ is only defined when the names in $\hpGG$ and $\hpGD$ are unique, i.e., $\fn(\hpGG)\cap\fn(\hpGD)=\emptyset$.

Hyper-environments (ranged over by $\hpHG$, $\hpHH$) are multisets of typing environments, as defined by the following grammar:
$$
  \hpHG, \hpHH \Coloneq \hpHOne \mid \hpHG \hpHTens \hpGG
$$
The set of free endpoint names in a hyper environment, written $\fn(\hpHG)$, is defined by recursion on the hyper environment, i.e., $\fn(\hpHOne)\defeq\emptyset$ and $\fn(\hpHG \hpHTens \hpGG)\defeq\fn(\hpHG)\cup\fn(\hpGG)$.
The extension $\hpHG \hpHTens \hpGG$ is only defined when the names in all typing environments in $\hpHG$ and $\hpGG$ are unique, i.e., $\fn(\hpHG)\cap\fn(\hpGG)=\emptyset$.

We write $\hpHG\hpHTens\hpHH$ for the concatenation of hyper-environments $\hpHG$ and $\hpHH$.
The concatenation $\hpHG\hpHTens\hpHH$ is only defined when the names in all typing environments in $\hpHG$ and $\hpHH$ are unique, i.e., $\fn(\hpHG)\cap\fn(\hpHH)=\emptyset$.

We write $\hpHG^k$ to mean that the hyper-environment $\hpHG$ consists of $k$ typing environments, i.e., $\hpHG^k$ is of the form $\hpGG_1\hpHTens\dots\hpHTens\hpGG_k$.

The typing judgment $\hpP\hpSeq\hpHG$ means that $\hpP$ is well-typed if, for each typing environment $\hpGG$ in $\hpHG$, and for each type assignment $\hpx:\hpA$ in $\hpGG$, exactly one process in $\hpP$ uses the endpoint $\hpx$ according to the session type $\hpA$ and that process only uses free endpoints that are in $\hpGG$.

Definition (Typing).
  ~ A process $\hpP$ is well-typed under typing environment $\hpHG$ if there exists a derivation with conclusion $\hpP\hpSeq\hpHG$ that uses the typing rules in @figure:hcp-typing.

![Typing Rules for Hypersequent CP](figures/typing.tex?as=webp){#figure:hcp-typing}

Processes are considered equivalent up to structural congruence, written $\hpEquiv$, which ensures that, e.g., the direction of a link and the order of a parallel composition are irrelevant.

Definition (Structural Congruence) {#hcp-equiv}.
  ~ *Structural congruence*, written $\hpP\hpEquiv\hpQ$, is the congruence closure over processes which satisfies the rules in @figure:hcp-equiv.

![Structural Congruence for Hypersequent CP](figures/structural-congruence.tex?as=webp){#figure:hcp-equiv}

Definition (Evaluation Context) {#hcp-evaluation-context}.
  ~ *Evaluation contexts* are one-hole process contexts, as defined by the following grammar:
    $$
    \hpEE, \hpEF \Coloneq \hpHole
    \mid \hpNew(\hpx\hpx')\hpEE
    \mid \hpEE\hpPar\hpQ
    \mid \hpQ\hpPar\hpEE
    $$
    Plugging is defined by replacing the one hole with a process:
    $$
    {\setlength\arraycolsep{0pt}
    \begin{array}{ll@{\;\defeq\;}l}
    \hpHole
    & \,\hptm[\hpP\hptm]
    & \hpP
    \\
    \hpNew(\hpx\hpx')\hpEE
    & \,\hptm[\hpP\hptm]
    & \hpNew(\hpx\hpx'){\hpEE}\hptm[\hpP\hptm]
    \\
    \hptm({\hpEE}\hpPar{\hpQ}\hptm)
    & \,\hptm[\hpP\hptm]
    & {\hpEE}\hptm[\hpP\hptm]\hpPar{\hpQ}
    \\
    \hptm({\hpQ}\hpPar{\hpEE}\hptm)
    & \,\hptm[\hpP\hptm]
    & {\hpQ}\hpPar{\hpEE[\hpP]}
    \end{array}}
    $$
    We write $\fn(\hpEE)$ for the free endpoints in $\hpEE$.

    We write $\bn(\hpEE)$ for the endpoints bound by $\hpEE$.

    We write $\hpEE\hpSeq\hpHG\hpSeqTo\hpHH$ to mean that the evaluation context $\hpEE$ is well-typed under input typing context $\hpHG$ and output typing context $\hpHH$.
    $$
      \begin{array}{c}
        \AXC{$\vphantom{,\co\hpA}$}
        \UIC{$
            \hpHole \hpSeq \hpHG \hpSeqTo \hpHG
          $}
        \DP
        \quad
        \AXC{$
            \hpEE
            \hpSeq
            \hpHG
            \hpSeqTo
            \hpHH
            \hpHTens
            \hpGG,\hpx:\hpA\hpHTens\hpGD,\hpx':\co\hpA
          $}
        \UIC{$
          \hpNew(\hpx\hpx')\hpEE
          \hpSeq
          \hpHG
          \hpSeqTo
          \hpHH
          \hpHTens
          \hpGG,\hpGD
          $}
        \DP
        \\
        \\
        \AXC{$
            \hpEE
            \hpSeq
            \hpHG
            \hpSeqTo
            \hpHH_1
          $}
        \AXC{$
            \hpQ
            \hpSeq
            \hpHH_2
          $}
        \BIC{$
            \hpEE\hpPar\hpQ
            \hpSeq
            \hpHG
            \hpSeqTo
            \hpHH_1
            \hpHTens
            \hpHH_2
          $}
        \DP
        \quad
        \AXC{$
            \hpQ
            \hpSeq
            \hpHH_1
          $}
        \AXC{$
            \hpEE
            \hpSeq
            \hpHG
            \hpSeqTo
            \hpHH_2
          $}
        \BIC{$
            \hpQ\hpPar\hpEE
            \hpSeq
            \hpHG
            \hpSeqTo
            \hpHH_1
            \hpHTens
            \hpHH_2
          $}
        \DP
      \end{array}
    $$

The semantics of HCP processes is given by *reduction*, written $\hpEval$.
Reduction is closed over evaluation contexts, and structural congruence is embedded in reduction by allowing pre- and post-composition using \Rule{H-E-Cong}, written as $\hpEquiv\hpEval$, $\hpEval\hpEquiv$, or $\hpEquiv\hpEval\hpEquiv$.

Definition (Reduction) {#hcp-eval}.
  ~ Reduction is the smallest relation on processes defined by the rules in @figure:hcp-eval.

![Reduction for Hypersequent CP](figures/reduction.tex?as=webp){#figure:hcp-eval}

In the remainder of the section, I discuss each process construct together with its typing rule and operational semantics, either by itself---e.g. *link*---or together with its dual---e.g., *send* and *receive*.

## Process Structure {#hcp-process-structure}
<!-- Name Restriction, Parallel Composition, and The Terminated Process -->

The process $\hpNew(\hpx\hpx')\hpP$ denotes a *name restriction*, which creates a communication channel with two endpoints, $\hpx$ and $\hpx'$, and the process $\hpP\hpPar\hpQ$ denotes a *parallel composition*, which---well---composes two processes in parallel.

The typing rules for name restriction and parallel composition are as follows:
$$
  \hpNEW*\hpx{\hpx'}\hpP\hpHG\hpGG\hpGD\hpA\DP
  \qquad
  \hpPAR*\hpP\hpQ\hpHG\hpHH\DP
$$
For communication safety, it is important that the two endpoints $\hpx$ and $\hpx'$ have dual types, and that every endpoint is used exactly once.

- The \Rule{H-T-New} rule guarantees the former.  
  It requires that $\hpx:\hpA$ and $\hpx':\co\hpA$.

- The \Rule{H-T-Par} rule guarantees the latter.  
  It requires that the processes $\hpP$ and $\hpQ$ do not share any free endpoints, as the concatenation $\hpHG\hpHTens\hpHH$ is only defined when the hyper-environments $\hpHG$ and $\hpHH$ do not share any endpoint names.

For deadlock freedom---as well as a close correspondence to CLL---it is important that the two endpoints of a channel are used in separate processes, and that any two processes share *at most* one channel.
Both of these requirements are guaranteed by the \Rule{H-T-New} rule, but the \Rule{H-T-Par} rule does the bookkeeping that enables this. Therefore, let us start our discussion with the \Rule{H-T-Par} rule:

- In a parallel composition $\hpP\hpPar\hpQ$, the two processes $\hpP$ and $\hpQ$ are not connected by any channel, as there is no name restriction that takes scope over both. Hence, there cannot be any dependency between any of their endpoints. The two processes are disjoint.
  The \Rule{H-T-Par} rule registers this disjointness in the sequent by separating their respective hyper-environments with a "$\hpHTens$".

- In a name restriction $\hpNew(\hpx\hpx')\hpP$, it is important that the two endpoints of a channel are used in separate processes, and that any two processes share *at most* one channel.
  The \Rule{H-T-New} rule guarantees both:

  - For the former, it requires that the two endpoints $\hpx$ and $\hpx'$ are separated by "$\hpHTens$" in the premise, which means that they will *eventually* be split between two separate processes.
  - For the latter, it removes the "$\hpHTens$" in the conclusion, to register the fact that the two processes that use $\hpx$ and $\hpx'$ are now connected by that channel.

The process $\hpZ$ denotes the *terminated process*, which does nothing.
The typing rule for the terminated process is as follows:
$$
  \hpHALT*\DP
$$
Hyper-environments are multisets. They are considered equal up to the unit rule for $\hpHTens$ and $\hpHOne$, and the commutativity and associativity rules for $\hpHTens$.
$$
\begin{array}{l@{\;=\;}l}
    \hpHG\hpHTens\hpHOne
  & \hpHG
  \\
    \hpHG_1\hpHTens\hpHG_2
  & \hpHG_2\hpHTens\hpHG_1
  \\
    \hpHG_1\hpHTens(\hpHG_2\hpHTens\hpHG_3)
  & (\hpHG_1\hpHTens\hpHG_2)\hpHTens\hpHG_3
\end{array}
$$
These structural rules for hypersequents are used implicitly, e.g., the following typing derivation implicitly uses the right unit rule.
$$
  \AXC{$\vdots$}
  \noLine
  \UIC{$\hpP\hpSeq\hpHG$}
  \AXC{}
  \UIC{$\hpZ\hpSeq\hpHOne$}
  \BIC{$\hpP\hpPar\hpZ\hpSeq\hpHG$}
  \DP
$$
Processes are equivalent up to structural congruence, which includes the unit rule for $\hpPar$ and $\hpZ$ and the commutativity and associativity rules for $\hpPar$.
These explicit structural rules for processes mirror the implicit structural rules for hyper-environments.
$$
\begin{array}{lclll}
  \hpP\hpPar\hpZ
    & \hpEquiv
    & \hpP
    &
    & \Rule{H-SC-ParNil}
  \\
  \hpP\hpPar\hpQ
    & \hpEquiv
    & \hpQ\hpPar\hpP
    &
    & \Rule{H-SC-ParComm}
  \\
  \hpP\hpPar\hptm(\hpQ\hpPar\hpR\hptm)
    & \hpEquiv
    & \hptm(\hpP\hpPar\hpQ\hptm)\hpPar\hpR
    &
    & \Rule{H-SC-ParAssoc}
\end{array}
$$
The structural congruence also permits flipping the direction of a channel, permuting two name restrictions, and scope extrusion---which permits a process to move out of and into the scope of a name restriction, as long as it does not use the channel bound by that name restriction.
$$
\begin{array}{lclll}
  \hpNew(\hpx\hpx')\hpP
    & \hpEquiv
    & \hpNew(\hpx'\hpx)\hpP
    &
    & \Rule{H-SC-NewComm}
  \\
  \hpNew(\hpx\hpx')\hpNew(\hpy\hpy')\hpP
    & \hpEquiv
    & \hpNew(\hpy\hpy')\hpNew(\hpx\hpx')\hpP
    &
    & \Rule{H-SC-NewAssoc}
    \\
  \hpNew(\hpx\hpx')(\hpP\hpPar\hpQ)
    & \hpEquiv
    & \hpP\hpPar\hpNew(\hpx\hpx')\hpQ
    & \text{if }\hpx,\hpx'\notin\fn(\hpP)
    & \Rule{H-SC-ScopeExt}
\end{array}
$$
There are no reduction rules associated with name restriction, parallel composition, or the terminated process.
None of these constructs perform any action.
Rather, they manage the structure of connections and parallel processes that facilitate message-passing communication.

Name restriction and parallel composition appear in every reduction rule, as communication can only happen over a channel, which requires the presence of a name restriction, and between parallel processes, which requires the presence of a parallel composition.
Furthermore, the \Rule{H-E-Cong} rule permits communication to occur under an arbitrary evaluation context of name restrictions, parallel compositions, and unrelated processes.
$$
\begin{RuleWithLabel}*{H}{E-Cong}
  \AXC{$\hpP \hpEval \hpP'$}
  \UIC{$\hpEE[\hpP] \hpEval \hpEE[\hpP']$}
  \DP
\end{RuleWithLabel}
$$

## Link {#hcp-link}

The process $\hpLink\hpx\hpy$ denotes a *link*.
It forwards any messages received on $\hpx$ to $\hpy$, and vice versa.
For communication safety, the two endpoints must have dual types.
Hence, $\hpx:\hpA$ and $\hpy:\co\hpA$.
$$
  \hpLINK*\hpx\hpy\hpA\DP
$$
HCP's semantics follows CP's semantics for link, and does not explicitly forward messages, but treats links as suspended α-renaming.
When a link $\hpLink\hpx\hpy$ reduces, it renames all occurrences of the dual of $\hpx$ to $\hpy$, or all occurrences of the dual of $\hpy$ to $\hpx$.
In essence, this updates all the processes connected to the one side of the link to point directly at the other side, circumventing the link.
$$
\begin{array}{lcll}
  \hpNew(\hpx\hpx')(\hpLink\hpx\hpw\hpPar\hpP)
    & \hpEval
    &
  \hpP\hpSubst{\hpw}{\hpx'}
    & \Rule{H-E-Link}
\end{array}
$$
The renaming targets a bound name. Hence, there cannot be any other occurrences of that name, and the link can be removed.

Links are *commutative*.
If two channels are connected by a link, the order in which they are connected is irrelevant.
This property is captured by the following equivalence:
$$
\begin{array}{lclll}
  \hpLink\hpx\hpy
    & \hpEquiv
    & \hpLink\hpy\hpx
    &
    & \Rule{H-SC-LinkComm}
\end{array}
$$

## Send and Receive {#hcp-send-and-receive}

The send and receive actions are dual:

- The process $\hpSend\hpx\hpy.\hpP$ denotes a *send* action.  
  It creates a fresh channel, names one endpoint of that channel $\hpy$, sends the other endpoint over $\hpx$, then continues as $\hpP$.
- The process $\hpRecv\hpx\hpy.\hpP$ denotes a *receive* action.  
  It receives an endpoint over $\hpx$, names it $\hpy$, then continues as $\hpP$.

The typing rules for send and receive are as follows:
$$
  \hpSEND*\hpx\hpy\hpP\hpGG\hpGD\hpA\hpB\DP
  \qquad
  \hpRECV*\hpx\hpy\hpP\hpGG\hpA\hpB\DP
$$
The behaviour of send and receive is given by the following rule:
$$
\begin{array}{lcll}
  \hpNew(\hpx\hpx')(
  \hpSend\hpx\hpy.\hpP
  \hpPar
  \hpRecv{\hpx'}{\hpy'}.\hpQ
  )
    & \hpEval
    &
  \hpNew(\hpx\hpx')\hpNew(\hpy\hpy')(\hpP\hpPar\hpQ)
    & \Rule{H-E-Send}
\end{array}
$$
The continuation of a send action is $\hpP$, as opposed to CP's send, $\cpexp2{\cpSend\cpx\cpy.(\cpP\cpPar\cpQ)}$, which requires that the endpoints $\cpexp2{\cpy}$ and $\cpexp2{\cpx}$ are immediately split between the processes $\cpexp2{\cpP}$ and $\cpexp2{\cpQ}$. This is misleading. HCP *still* requires that the channels $\hpy$ and $\hpx$ are split between parallel processes. It does not require that the split happens *immediately*, settling for *eventually*. However, HCP's *eventually* is not as lenient as one might assume. As discussed in the introduction to @hcp, the \Rule{H-T-Send} rule does not permit the presence of any unrelated typing environments---i.e., there is no generic $\hpHG$ in the rule, as there is in the \Rule{H-T-New} rule. The same is true for the typing rules for the other actions.
Consequently, no other action may come between the send action $\hpSend\hpx\hpy$ and the parallel composition that splits $\hpx$ and $\hpy$.
The only process constructs that may come between those are unrelated name restrictions and parallel compositions.
In effect, the only possible forms for a send action and its continuation are
$$
\hpSend\hpx\hpy.\hpEE[\hpP\hpParSplit\hpx\hpy\hpQ]
\quad\text{and}\quad
\hpSend\hpx\hpy.\hpEE[\hpP\hpParSplit\hpy\hpx\hpQ]
\text{.}
$$
Where $\hpP\hpParSplit\hpx\hpy\hpQ$ denotes the parallel composition that splits $\hpx$ and $\hpy$ such that $\hpx\in\fn(\hpP)$ and $\hpy\in\fn(\hpQ)$.
This may seem restrictive---*and it is*---but the purpose of HCP is to preserve the semantics of CP.

(The alternative---permitting unrelated typing environments---is explored in DHCP [@KokkeMP19:dhcp]. DHCP preserves the semantics of CLL, but not of CP. It uses *delayed* actions, where the actions in a process may to some extent resolve out of order.)

## Close and Wait {#hcp-close-and-wait}

The close and wait actions are dual:

- The process $\hpClose\hpx.\hpP$ denotes a *close* action.  
  It sends a ping over $\hpx$, then continues as $\hpP$.
- The process $\hpWait\hpx.\hpP$ denotes a *wait* action.  
  It receives a ping over $\hpx$, then continues as $\hpP$.

(I say 'ping' to imply the interaction between close and wait is merely a synchronisation, and does not transmit any information.)

The typing rules for close and wait are as follows:
$$
  \hpCLOSE*\hpx\DP
  \qquad
  \hpWAIT*\hpx\hpP\hpGG\DP
$$
The behaviour of these two actions is given by the following rule:
$$
\begin{array}{lcll}
  \hpNew(\hpx\hpx')(
  \hpClose\hpx.\hpP
  \hpPar
  \hpWait{\hpx'}.\hpQ
  )
    & \hpEval
    &
  \hpQ
    & \Rule{H-E-Close}
\end{array}
$$
The continuation of the close action is $\hpP$, as opposed to CP's close, $\cpexp2{\cpClose\cpx.\cpZ}$, which requires that the process immediately terminates. This is misleading. HCP *still* requires that the process immediately terminates, but as a consequence of its type system rather than its process syntax. The \Rule{H-T-Close} rule requires that the continuation $\hpP$ is typed under the empty hyper-environment, and---as I will show @lemma:hcp-hyper-consistency---all processes typed under the empty hyper-environment are equivalent to the terminated process.
In effect, the only possible forms for a close action and its continuation are variations of $\hpClose\hpx.\hpZ\hpPar\hptm\dots\hpPar\hpZ$.

## Select and Offer {#hcp-select-and-offer}

The select and offer actions are dual:

- The process $\hpSelect\hpx<1.\hpP$ denotes a *left selection* action.  
  It sends the label $\hpInl$ over $\hpx$, then continues as $\hpP$.
- The process $\hpSelect\hpx<2.\hpP$ denotes a *right selection* action.  
  It sends the label $\hpInr$ over $\hpx$, then continues as $\hpP$.
- The process $\hpOffer\hpx(\hpInl: \hpP; \hpInr: \hpQ)$ denotes a *choice* action.  
  It receives a label over $\hpx$, and then continues as either $\hpP$ or $\hpQ$, depending on which label was received.

The typing rules for select and offer are as follows:
$$
\begin{array}{c}
  \hpSELECTINL*\hpx\hpP\hpGG\hpA\hpB\DP
  \qquad
  \hpSELECTINR*\hpx\hpP\hpGG\hpA\hpB\DP
  \\[1.5em]
  \hpOFFER*\hpx\hpP\hpQ\hpGG\hpA\hpB\DP
\end{array}
$$
The behaviour of these actions is given by the following rules:
$$
\begin{array}{lcll}
  \hpNew(\hpx\hpx')(
  \hpSelect\hpx<1.\hpP
  \hpPar
  \hpOffer{\hpx'}(\hpInl: \hpQ; \hpInr: \hpR)
  )
    & \hpEval
    &
  \hpNew(\hpx\hpx')(\hpP\hpPar\hpQ)
    & \Rule{H-E-Select1}
  \\
  \hpNew(\hpx\hpx')(
  \hpSelect\hpx<2.\hpP
  \hpPar
  \hpOffer{\hpx'}(\hpInl: \hpQ; \hpInr: \hpR)
  )
    & \hpEval
    &
  \hpNew(\hpx\hpx')(\hpP\hpPar\hpR)
    & \Rule{H-E-Select2}
  \end{array}
$$
As discussed in @cp-select-and-offer, this syntax was adapted from @DardhaG18:pcp, because is more easily generalized to variant types.

## The Absurd Offer {#hcp-the-absurd-offer}

The process $\hpAbsurdZap\hpx\hpNN$ denotes the *absurd offer*. It waits to receive a choice between *zero* alternatives. Such a choice cannot be made, which means that there is no corresponding select action, and no corresponding reduction rule. In essence, an absurd offer is inert. The absurd offer is the sole process that is allowed to leave endpoints unused, and the set of those unused endpoints is denoted by $\hpNN$.
$$
  \hpABSURDZAP*\hpx\hpNN\hpGG\DP
$$
For an in-depth discussion of the absurd offer, its syntax, its inert semantics, and its relation to @Wadler12:cpgv's absurd offer, see @cp-the-absurd-offer.
I present an exceptional semantics for the absurd offer in @hcp-zap-exceptionally-absurd-offer.
