# Classical Processes {#cp-classical-processes}
<!-- Classical Linear Logic as a Process Calculus -->

In this section, I introduce Classical Processes (CP), a session-typed process calculus that was introduced by @Wadler12:cpgv and based on πDILL by @CairesP10:pidill.
CP's process calculus resembles the π-calculus [@MilnerPW92:pi-2], and its type system is Classical Linear Logic [@Girard87:ll, CLL].

The fundamental notions of programs and computation in CP---as in most process calculi---are processes and message-passing communication. Processes communicate by passing messages over channels.
Unlike the π-calculus, CP's channels are *binary*, which means that communication always takes place between two processes.
Each channel has exactly two endpoints.
Each endpoint is held by exactly one process.
Names refer to *channel endpoints* rather than the channels themselves.
CP has no notion of multiparty communication, though there are extensions that address this [e.g., @CarboneLMSW16:mcp].

In the π-calculus, channel names fulfil two roles. Channel names are used as communication channels and as labels, compared with the conditional operator.
In CP, the two roles are separate. Channel endpoints and labels are in different syntactic sorts, and are communicated by different send and receive operators.
To simplify the presentation, CP is commonly restricted to the labels 'left' and 'right', written as $\cpInl$ and $\cpInr$.
This is no less general, as any *finite* set of labels can be encoded as a sequence of binary choices.
For any practical implementation, this restriction is easily lifted.

Processes (ranged over by $\cpP$, $\cpQ$, $\cpR$) are defined by the following grammar:
$$
  \begin{array}{l r l l}
    \cpP, \cpQ, \cpR
     & \Coloneq
     & \cpLink\cpx\cpy
     & \text{link}
    \\
     & \mid
     & \cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)
     & \text{cut}
    \\
     & \mid
     & \cpSend\cpx\cpy.(\cpP\cpPar\cpQ)
     & \text{send}
    \\
     & \mid
     & \cpRecv\cpx\cpy.\cpP
     & \text{receive}
    \\
     & \mid
     & \cpClose\cpx.0
     & \text{close}
    \\
     & \mid
     & \cpWait\cpx.\cpP
     & \text{wait}
    \\
     & \mid
     & \cpSelect\cpx<1.\cpP
     & \text{select left}
    \\
     & \mid
     & \cpSelect\cpx<2.\cpP
     & \text{select right}
    \\
     & \mid
     & \cpOffer\cpx(\cpInl: \cpP; \cpInr: \cpQ)
     & \text{choice}
    \\
     & \mid
     & \cpAbsurdZap\cpx\cpNN
     & \text{absurd offer}
  \end{array}
$$
The names $\cpx$, $\cpy$, $\cpz$, and $\cpw$ range over the endpoints of communication channels---'channel endpoints' or 'endpoints' for short.
The names $\cpx'$, $\cpy'$, $\cpz'$, and $\cpw'$ as well as $\cpa$, $\cpb$, and $\cpc$ also range over endpoints, though they are only used in specific circumstances, which I discuss shortly.
The names $\cpNN$ and $\cpNM$ range over sets of endpoints.

An endpoint is *bound* in the following cases:

- In $\cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)$,
  $\cpx$ and $\cpx'$ are bound in $\cpP$ and $\cpQ$, respectively.
- In $\cpSend\cpx\cpy.(\cpP\cpPar\cpQ)$,
  $\cpy$ is bound in $\cpP$, but not in $\cpQ$.
- In $\cpRecv\cpx\cpy.\cpP$, $\cpy$ is bound in $\cpP$.

An endpoint is *free* if it is not bound.
Notably, for $\cpAbsurdZap\cpx\cpNN$, $\cpx$ and all names in $\cpNN$ are free.
I write $\fn(\cpP)$ to denote the set of free endpoints in $\cpP$.
By convention, the names $\cpa$, $\cpb$, and $\cpc$ are used as a shorthand to imply to the reader that the endpoint is free.

Two endpoints are *dual* if they are bound by the same name restriction, e.g., in $\cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)$, $\cpx$ is bound in $\cpP$, $\cpx'$ is bound in $\cpQ$, and $\cpx$ and $\cpx'$ are dual.
By convention, the names $\cpx'$, $\cpy'$, $\cpz'$, and $\cpw'$ are used as a shorthand to imply duality to the reader, e.g., I use $\cpx$ and $\cpx'$ when they are dual endpoints of the same channel.

In CP, actions are not a well-defined syntactic sort, unlike in the π-calculus.
Nonetheless, I informally write "action" in reference to the bit before the dot, e.g., the action for $\cpSend\cpx\cpy.(\cpP\cpPar\cpQ)$ is $\cpSend\cpx\cpy$.
For the troublemakers without a dot, $\cpOffer\cpx(\cpInl:\cpP;\cpInr:\cpQ)$ and $\cpAbsurdZap\cpx\cpNN$, I write $\cpOffer\cpx\cpInl$, $\cpOffer\cpx\cpInr$, and $\cpAbsurdZap\cpx$, respectively.
(The syntax $\cpOffer\cpx(\cpInl:\cpP;\cpInr:\cpQ)$ is the primary obstacle to separating actions out into their own syntactic sort. I discuss a variant that decomposes the offer construct in this manner in @hcp-variant-types-and-guarded-summation.)

Types (ranged over by $\cpA$, $\cpB$) are the formula of CLL, as defined by the following grammar:
$$
  \begin{array}{l r l r l r l r l r l r l r l r l}
    \cpA, \cpB
     & \Coloneq &
    \cpA \cpTens \cpB
     & \mid     &
    \cpOne
     & \mid     &
    \cpA \cpPlus \cpB
     & \mid     &
    \cpNil
    \\
     & \mid     &
    \cpA \cpParr \cpB
     & \mid     &
    \cpBot
     & \mid     &
    \cpA \cpWith \cpB
     & \mid     &
    \cpTop
  \end{array}
$$
Duality plays an important role in CP as in CLL.
Viewed from the perspective of a logic, it corresponds to negation.
Viewed from the perspective of a process calculus, it guarantees that processes act on dual endpoints of the same channel in dual ways, e.g., one process sends when the other receives.
As in CLL, duality is not defined as a type constructor, but as a function on types:
$$
  \begin{array}{l c l p{\arraycolsep} l c l}
    \co{\cpA \cpTens \cpB}
     & \defeq &
    \co\cpA \cpParr \co\cpB
     &   &
    \co\cpOne
     & \defeq &
    \cpBot
    \\
    \co{\cpA \cpParr \cpB}
     & \defeq &
    \co\cpA \cpTens \co\cpB
     &   &
    \co\cpBot
     & \defeq &
    \cpOne
    \\
    \co{\cpA \cpPlus \cpB}
     & \defeq &
    \co\cpA \cpWith \co\cpB
     &   &
    \co\cpNil
     & \defeq &
    \cpTop
    \\
    \co{\cpA \cpWith \cpB}
     & \defeq &
    \co\cpA \cpPlus \co\cpB
     &   &
    \co\cpTop
     & \defeq &
    \cpNil
  \end{array}
$$
As we will see, dual endpoints have dual types. The notation for duality ($\cpA$, $\co{\cpA}$) and the naming convention for dual endpoints ($\cpx$, $\cpx'$) were chosen to emphasize this.
Duality is involutive.

Lemma {#cp-duality-involutive}.
  ~ $\co{\co\cpA} = \cpA$

Typing environments (ranged over by $\cpGG$, $\cpGD$) are sets of type assignments, as defined by the following grammar:
$$
  \cpGG, \cpGD \Coloneq \cpSBot \mid \cpGG, \cpx:\cpA
$$
The set of free endpoint names in a typing environment, written $\fn(\cpGG)$, is defined by recursion on the typing environment, i.e., $\fn(\cpSBot)\defeq\emptyset$ and $\fn(\cpGG, \cpx:\cpA)\defeq\fn(\cpGG)\cup\{\cpx\}$.
The extension $\cpGG, \cpx:\cpA$ is only defined when $\cpx$ is not free in $\cpGG$, i.e., $\cpx\notin\fn(\cpGG)$.

I write $\cpGG, \cpGD$ for the concatenation of typing environments $\cpGG$ and $\cpGD$.
The concatenation $\cpGG, \cpGD$ is only defined when the names in $\cpGG$ and $\cpGD$ are unique, i.e., $\fn(\cpGG)\cap\fn(\cpGD)=\emptyset$.

The typing judgment $\cpP\cpSeq\cpGG$ means that $\cpP$ is well-typed if, for each type assignment $\cpx:\cpA$ in $\cpGG$, exactly one process in $\cpP$ uses the endpoint $\cpx$ according to the session type $\cpA$.

Definition (Typing).
  ~ A process $\cpP$ is well-typed under typing environment $\cpGG$ if there exists a derivation with conclusion $\cpP\cpSeq\cpGG$ that uses the typing rules in @figure:cp-typing.

![Typing Rules for Classical Processes](figures/typing.tex?as=webp){#figure:cp-typing}

The names $\cpEE$ and $\cpEF$ range over *evaluation contexts*.
Evaluation contexts are one-hole process contexts that consist only of cuts.

Definition (Evaluation Context) {#cp-evaluation-context}.
  ~ *Evaluation contexts* are one-hole process contexts, as defined by the following grammar:
    $$
    \cpEE, \cpEF \Coloneq \cpHole
    \mid \cpNew(\cpx\cpx')(\cpEE\cpPar\cpQ)
    \mid \cpNew(\cpx\cpx')(\cpQ\cpPar\cpEE)
    $$
    Plugging is defined by replacing the one hole with a process:
    $$
    {\setlength\arraycolsep{0pt}
    \begin{array}{llrl}
    \cpHole
    & \cpPlug[\cpP]
    & \;\defeq\; &
    \cpP
    \\
    \cpNew(\cpx\cpx')({\cpEE}\cpPar{\cpQ})
    & \cpPlug[\cpP]
    & \;\defeq\; &
    \cpNew(\cpx\cpx')({\cpEE}\cptm[\cpP\cptm]\cpPar{\cpQ})
    \\
    \cpNew(\cpx\cpx')({\cpQ}\cpPar{\cpEE})
    & \cpPlug[\cpP]
    & \;\defeq\; &
    \cpNew(\cpx\cpx')({\cpQ}\cpPar{\cpEE[\cpP]})
    \end{array}}
    $$
    I write $\fn(\cpEE)$ for the free endpoints in $\cpEE$.
    <!--
    $$
    \begin{array}{lrl}
    \fn(\cpHole)
    & \defeq
    & \emptyset
    \\
    \fn(\cpNew(\cpx\cpx')(\cpEE\cpPar\cpQ))
    & \defeq
    & \{\cpw\in\fn(\cpEE)\mid\cpw\neq\cpx\}
      \cup
      \{\cpw\in\fn(\cpQ)\mid\cpw\neq\cpx'\}
    \\
    \fn(\cpNew(\cpx\cpx')(\cpQ\cpPar\cpEE))
    & \defeq
    & \{\cpw\in\fn(\cpQ)\mid\cpw\neq\cpx\}
      \cup
      \{\cpw\in\fn(\cpEE)\mid\cpw\neq\cpx'\}
    \end{array}
    $$
    -->

    I write $\bn(\cpEE)$ for the endpoints bound by $\cpEE$.
    <!--
    $$
    \begin{array}{lrl}
    \bn(\cpHole)
    & \defeq
    & \emptyset
    \\
    \bn(\cpNew(\cpx\cpx')(\cpEE\cpPar\cpQ))
    & \defeq
    & \{\cpx\}\cup\bn(\cpEE)
    \\
    \bn(\cpNew(\cpx\cpx')(\cpQ\cpPar\cpEE))
    & \defeq
    & \{\cpx'\}\cup\bn(\cpEE)
    \end{array}
    $$
    -->

    I write $\cpEE\cpSeq\cpGG'\cpSeqTo\cpGG$ to mean that the evaluation context $\cpEE$ is well-typed under input typing context $\cpGG'$ and output typing context $\cpGG$.
    $$
      \def\fCenter{\cpSeq}
      \def\defaultHypSeparation{}
      \AXC{$\vphantom{,\co\cpA}$}
      \UI$\cpHole \fCenter \cpGG \cpSeqTo \cpGG$
      \DP
      \quad
      \AX$\cpEE \fCenter \cpGG' \cpSeqTo \cpGG, \cpx  : \cpA $
      \AX$\cpQ  \fCenter \cpGD,  \cpx' : \co\cpA$
      \BI$\cpNew(\cpx\cpx')(\cpEE\cpPar\cpQ)
          \fCenter
          \cpGG' \cpSeqTo \cpGG, \cpGD$
      \DP
      \quad
      \AX$\cpQ  \fCenter \cpGG,  \cpx  : \cpA$
      \AX$\cpEE \fCenter \cpGD' \cpSeqTo \cpGD, \cpx' : \co\cpA$
      \BI$\cpNew(\cpx\cpx')(\cpQ\cpPar\cpEE)
          \fCenter
          \cpGD' \cpSeqTo \cpGG, \cpGD$
      \DP
    $$

Processes are considered equivalent up to structural congruence.

Definition (Structural Congruence) {#cp-equiv}.
  ~ *Structural congruence*, written $\cpP\cpEquiv\cpQ$, is the congruence closure over processes which satisfies the rules in @figure:cp-equiv.

![Structural Congruence for Classical Processes](figures/structural-congruence.tex?as=webp){#figure:cp-equiv}

The semantics of CP processes is given by *reduction*.
Reduction is closed over evaluation contexts, and structural congruence is embedded in reduction by allowing pre- and post-composition using \Rule{C-E-Cong}, written as $\cpEquiv\cpEval$, $\cpEval\cpEquiv$, or $\cpEquiv\cpEval\cpEquiv$.

Definition (Reduction) {#cp-eval}.
  ~ *Reduction*, written $\cpP\cpEval\cpQ$, is the smallest relation on processes defined by the rules in @figure:cp-eval.

![Reduction for Classical Processes](figures/reduction.tex?as=webp){#figure:cp-eval}

In the remainder of the section, I discuss each process construct together with its typing rule and operational semantics, either by itself---e.g. *link*---or together with its dual---e.g., *send* and *receive*.

## Process Structure {#cp-cut}

The process $\cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)$ denotes a *cut*, which creates a communication channel with two endpoints, $\cpx$ and $\cpx'$.
For communication safety, the two endpoints must have dual types.
Hence, $\cpx:\cpA$ and $\cpx':\co\cpA$.
For deadlock freedom, the two endpoints must be used in different processes, and those processes cannot share any other channels.
Hence, $\cpx$ is bound in $\cpP$ and $\cpx'$ is bound in $\cpQ$, and the typing environment is split between $\cpP$ and $\cpQ$.
$$
  \cpCUT*{\cpx}{\cpx'}\cpP\cpQ\cpGG\cpGD\cpA\DP
$$
The cut combines two process constructs from the π-calculus: name restriction $\cpNew(\cpx\cpx')$ and parallel composition $\cpP\cpPar\cpQ$.
The two do not detach.
In CP, $\cpNew(\cpx\cpx')\cpP$ and $\cpP\cpPar\cpQ$ are not syntactically well-formed processes.

Cuts are *commutative* and *quasi-associative*:
$$
  \begin{array}{lcll}
    \cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)
     & \cpEquiv
     & \cpNew(\cpx'\cpx)(\cpQ\cpPar\cpP)
     & \Rule{C-SC-CutComm}
    \\
    \cpNew(\cpx\cpx')(\cpNew(\cpy\cpy')(\cpP\cpPar\cpQ)\cpPar\cpR)
     & \cpEquiv
     & \cpNew(\cpy\cpy')(\cpNew(\cpx\cpx')(\cpP\cpPar\cpR)\cpPar\cpQ)
     & \Rule{C-SC-CutAssoc}
    \\
     & \multicolumn{2}{c}{\text{where }\cpx\notin\cpQ\text{ and }\cpy\notin\cpR}
  \end{array}
$$
The \Rule{C-SC-CutAssoc} rule is not quite an associativity rule. Hence, *quasi-associative*.
@Wadler12:cpgv refers to the rule as "(Assoc)" in reference to the change of bracketing.
In fact, the rule combines the associativity rule of parallel composition with scope extrusion, which commutes parallel composition and name restriction, as we will see in @hcp-fission-fusion-and-disentanglement (see @proposition:hcp-fission-preserves-equiv).

There is no specific reduction rule for cut.
Rather, all other reduction rules resolve dual communication actions *under a cut*, i.e., over an existing channel.
\Rule{C-E-Cong} allows reduction under cuts.
$$
  \begin{RuleWithLabel}*{C}{E-Cong}
    \AXC{$\cpP \cpEval \cpP'$}
    \UIC{$\cpEE[\cpP]\cpEval\cpEE[\cpP']$}
    \DP
  \end{RuleWithLabel}
$$

## Link {#cp-link}

The process $\cpLink\cpx\cpy$ denotes a *link*.
It forwards any messages received on $\cpx$ to $\cpy$, and vice versa.
For communication safety, the two endpoints must have dual types.
Hence, $\cpx:\cpA$ and $\cpy:\co\cpA$.
$$
  \cpLINK*\cpx\cpy\cpA\DP
$$
Links are *commutative*.
If two channels are connected by a link, the order in which they are connected is irrelevant.
This property is captured by the following equivalence:
$$
  \begin{array}{lcll}
    \cpLink\cpx\cpy
     & \cpEquiv
     & \cpLink\cpy\cpx
     & \Rule{C-SC-LinkComm}
  \end{array}
$$
CP's semantics for link does not explicitly forward messages, but treats links as suspended α-renaming.
When a link $\cpLink\cpx\cpy$ reduces, it renames all occurrences of the dual of $\cpx$ to $\cpy$, or all occurrences of the dual of $\cpy$ to $\cpx$.
In essence, this updates all the processes connected to the one side of the link to point directly at the other side, circumventing the link.
$$
  \begin{array}{lcll}
    \cpNew(\cpx\cpx')(\cpLink\cpx\cpy\cpPar\cpP)
     & \cpEval
     &
    \cpP\cpSubst{\cpy}{\cpx'}
     & \Rule{C-E-Link}
  \end{array}
$$
The renaming targets a bound name. Hence, there cannot be any other occurrences of that name, and the link can be removed.
The rule \Rule{C-E-Link} gives link an asynchronous semantics, as $\cpP$ is not required to be ready on $\cpx'$, whereas all other actions are synchronous.
(I discuss synchronous semantics for link in @hcp-sync-link.)

## Send and Receive {#cp-send-and-receive}

The send and receive actions are dual:

- The process $\cpSend\cpx\cpy.(\cpP\cpPar\cpQ)$ denotes a *send* action.  
  It creates a fresh channel, names one endpoint of that channel $\cpy$, sends the other endpoint over $\cpx$, then continues as $\cpP$ and $\cpQ$ in parallel, where $\cpy$ is bound in $\cpP$ and $\cpx$ is bound in $\cpQ$.
- The process $\cpRecv\cpx\cpy.\cpP$ denotes a *receive* action.  
  It receives an endpoint over $\cpx$, names it $\cpy$, then continues as $\cpP$.

The typing rules for send and receive are as follows:
$$
  \cpSEND*\cpx\cpy\cpP\cpQ\cpGG\cpGD\cpA\cpB\DP
  \qquad
  \cpRECV*\cpx\cpy\cpP\cpGG\cpA\cpB\DP
$$
The behaviour of send and receive is given by the following rule:
$$
  \begin{array}{lcll}
    \cpNew(\cpx\cpx')(
    \cpSend\cpx\cpy.(\cpP\cpPar\cpQ)
    \cpPar
    \cpRecv{\cpx'}{\cpy'}.\cpR
    )
     & \cpEval
     &
    \cpNew(\cpy\cpy')(
    \cpP
    \cpPar
    \cpNew(\cpx\cpx')(\cpQ\cpPar\cpR)
    )
     & \Rule{C-E-Send}
  \end{array}
$$
After a send action, the endpoints $\cpy$ and $\cpx$ are passed to different parallel processes, which ensures that they are handled independently.
After a receive action, the two endpoints are kept by the same process.
This may seem restrictive---*and it is*---but it is paramount to type preservation and deadlock freedom.

The send action is a *bound* send. It cannot send just any old endpoint that the process happens to have laying around. It only sends *fresh* endpoints.
As part of the reduction, the send action *creates* a fresh channel with two fresh endpoints. It sends one of those endpoints, and keeps the other.
You can see this in \Rule{C-E-Send}. The left-hand side has one name restriction, $\cpNew(\cpx\cpx')$, but the right-hand side has two, creating a fresh channel with $\cpNew(\cpy\cpy')$.

You can think of the bound send action as a suspended cut. For deadlock freedom, the two processes connected by a cut cannot share any other channel.
(The relation between $\cpTens$ and cut is widely known in logic, e.g., @Girard87:ll treats cut as a special case of $\cpTens$.)

I could extend CP with an *unbound* send action. @LindleyM15:gv discuss such an extension [section 3.1, under "A Simpler Send"]. They propose the following syntax, typing, and reduction rules:
$$
\begin{array}{c}
  \cpP,\cpQ,\cpR
  \Coloneq
  \dots
  \mid
  \cpUSend\cpx\cpy.\cpP
  \\[1.5em]
  \begin{RuleWithLabel}{C}{T-USend}
    \AXC{$
      \cpP
      \cpSeq
      \cpGG, \cpy : \cpA, \cpx : \cpB
      $}
    \UIC{$
      \cpUSend{\cpx}{\cpy}.\cpP
      \cpSeq
      \cpGG, \cpx : \cpA\cpTens\cpB, \cpy : \co{\cpA}
      $}
    \DP
  \end{RuleWithLabel}
  \qquad
  \begin{RuleWithLabel}{C}{E-USend}
  \cpNew(\cpx\cpx')(
    \cpUSend\cpx\cpy.\cpP
    \cpPar
    \cpRecv{\cpx'}{\cpz}.\cpQ
  )
  \cpEval
  \cpNew(\cpx\cpx')(
    \cpP
    \cpPar
    \cpQ\cpSubst\cpy\cpz
  )
  \end{RuleWithLabel}
\end{array}
$$
The unbound send $\cpUSend\cpx\cpy.\cpP$ sends the *free* endpoint $\cpy$ over $\cpx$, then continues as $\cpP$.
In the π-calculus, unbound send is strictly more expressive than bound send [see @Boreale96:internal-mobility;@Sangiorgi96:internal-mobility].
In CP, unbound send can be defined in terms of bound send, but the converse does not hold. Unbound send can be defined as follows:
$$
  \cpUSend\cpx\cpy.\cpP
  \defeq
  \cpSend\cpx\cpz.(\cpLink\cpz\cpy\cpPar\cpP)
$$
The definition has the same reduction behavior as \Rule{C-E-USend}, albeit with an extra step for the link reduction.
$$
\begin{array}{
  r@{\;}l
  @{\qquad}
  r@{\;}l
  }
  \multicolumn{2}{l}{%
  \cpNew(\cpx\cpx')(
    \cpUSend\cpx\cpy.\cpP
    \cpPar
    \cpRecv{\cpx'}{\cpz}.\cpQ
  )}
& \multicolumn{2}{l}{%
  \cpNew(\cpx\cpx')(
    \cpUSend\cpx\cpy.\cpP
    \cpPar
    \cpRecv{\cpx'}{\cpz}.\cpQ
  )}
\\
  \qquad\cpEval
& \cpNew(\cpx\cpx')(
    \cpP
    \cpPar
    \cpQ\cpSubst{\cpy}{\cpz}
  )
& \qquad\defeq
& \cpNew(\cpx\cpx')(
    \cpSend\cpx\cpw.(\cpLink\cpw\cpy\cpPar\cpP)
    \cpPar
    \cpRecv{\cpx'}{\cpz}.\cpQ
  )
\\
&
& \qquad\cpEval
& \cpNew(\cpx\cpx')(
    \cpP
    \cpPar
    \cpNew(\cpw\cpw')(
    \cpLink\cpw\cpy
    \cpPar
    \cpQ\cpSubst{\cpw'}{\cpz}
    )
  )
\\
&
& \qquad\cpEval
& \cpNew(\cpx\cpx')(
    \cpP
    \cpPar
    \cpQ\cpSubst{\cpy}{\cpz}
  )
\end{array}
$$
The converse does not hold. One might try and define bound send in terms of unbound send as follows:
$$
  \cpSend\cpx\cpy.(\cpP\cpPar\cpQ)
  \defeq
  \cpNew(\cpy\cpy')(\cpP\cpPar\cpUSend\cpx{\cpy'}.\cpQ)
$$
However, the two do not behave quite the same. In the former, reductions in both $\cpP$ and $\cpQ$ are blocked on the send action. In the latter, only reductions in $\cpQ$ are blocked on the send action, while reductions in $\cpP$ can happen before the send action.

In @Wadler12:cpgv's CP, the adoption of unbound send breaks the proof of progress, as it introduces cuts that cannot easily be eliminated by means of a commuting conversion.
The cut in $\cpNew(\cpx\cpx')(\cpUSend\cpa\cpx.\cpP\cpPar\cpWait\cpx.\cpQ)$ cannot be eliminated by a commuting conversion, as the unbound send action $\cpUSend\cpa\cpx$ cannot commute past it, which breaks the simple left-to-right evaluation strategy proposed by @Wadler12:cpgv.
In CP, as presented in this chapter, the adoption of unbound send would not pose any problem, as my canonical form accounts for and justifies ineliminable top-level cuts.

By its very nature, bound send can only send endpoints, which means it does not easily generalise to sending other data. Hence, unbound send is important in the context of GV, where programs can send arbitrary data.

In the interest of an exact correspondence with CLL, and a close correspondence to @Wadler12:cpgv's CP, the version of CP presented in this chapter uses bound send.

## Close and Wait {#cp-close-and-wait}

The close and wait actions are dual:

- The process $\cpClose\cpx.0$ denotes a *close* action.  
  It sends a ping over $\cpx$, then terminates.
- The process $\cpWait\cpx.\cpP$ denotes a *wait* action.  
  It receives a ping over $\cpx$, then continues as $\cpP$.

(I say 'ping' to imply the interaction between close and wait is merely a synchronisation and does not transmit any information.)

The typing rules for close and wait are as follows:
$$
  \cpCLOSE*\cpx\DP
  \qquad
  \cpWAIT*\cpx\cpP\cpGG\DP
$$
The behaviour of these two actions is given by the following rule:
$$
  \begin{array}{lcll}
    \cpNew(\cpx\cpx')(
    \cpClose\cpx.0
    \cpPar
    \cpWait{\cpx'}.\cpQ
    )
     & \cpEval
     &
    \cpQ
     & \Rule{C-E-Close}
  \end{array}
$$
After a close action, the process must terminate, but after a wait action, the process continues. As with send and receive, this seems restrictive---*because it is restrictive*---but is paramount to type preservation.

The close and wait actions close the channel, which removes the cut.
Any two processes connected by a cut cannot share any other channel.
If both processes were allowed to continue, that would leave them unconnected.
This would break an important property of CP---that all processes are connected---and relaxing it would be logically equivalent to admitting the \Rule{CLL-Mix} rule (see @hcp-and-mix) and would break the exact correspondence with CLL.
(Such a variant of CP is explored by @AtkeyLM16:ccc.)

## Select and Offer {#cp-select-and-offer}

The select and offer actions are dual:

- The process $\cpSelect\cpx<1.\cpP$ denotes a *left selection* action.  
  It sends the label $\cpInl$ over $\cpx$, then continues as $\cpP$.
- The process $\cpSelect\cpx<2.\cpP$ denotes a *right selection* action.  
  It sends the label $\cpInr$ over $\cpx$, then continues as $\cpP$.
- The process $\cpOffer\cpx(\cpInl: \cpP; \cpInr: \cpQ)$ denotes a *choice* action.  
  It receives a label over $\cpx$, and then continues as either $\cpP$ or $\cpQ$, depending on which label was received.

The typing rules for select and offer are as follows:
$$
  \begin{array}{c}
  \cpSELECTINL*\cpx\cpP\cpGG\cpA\cpB\DP
  \quad
  \cpSELECTINR*\cpx\cpP\cpGG\cpA\cpB\DP
  \\[1.5em]
  \cpOFFER*\cpx\cpP\cpQ\cpGG\cpA\cpB\DP
  \end{array}
$$
The behaviour of these actions is given by the following rules:
$$
  \begin{array}{lcll}
    \cpNew(\cpx\cpx')(
    \cpSelect\cpx<1.\cpP
    \cpPar
    \cpOffer{\cpx'}(\cpInl: \cpQ; \cpInr: \cpR)
    )
     & \cpEval
     &
    \cpNew(\cpx\cpx')(\cpP\cpPar\cpQ)
     & \Rule{C-E-Select1}
    \\
    \cpNew(\cpx\cpx')(
    \cpSelect\cpx<2.\cpP
    \cpPar
    \cpOffer{\cpx'}(\cpInl: \cpQ; \cpInr: \cpR)
    )
     & \cpEval
     &
    \cpNew(\cpx\cpx')(\cpP\cpPar\cpR)
     & \Rule{C-E-Select2}
  \end{array}
$$
The syntax for the select and offer actions was adapted from @DardhaG18:pcp, rather than from @Wadler12:cpgv.
It is easily generalized from binary choice to variant types by removing the restriction that labels must always be drawn from $\{\cpInl,\cpInr\}$.
(I discuss variant types in @hcp-variant-types-and-guarded-summation.)

## The Absurd Offer {#cp-the-absurd-offer}

The process $\cpAbsurdZap\cpx\cpNN$ denotes the *absurd offer*. It waits to receive a choice between *zero* alternatives. Such a choice cannot be made, which means that there is no corresponding select action, and no corresponding reduction rule. In essence, an absurd offer is inert. The absurd offer is the sole process that is allowed to leave endpoints unused, and the set of those unused endpoints is denoted by $\cpNN$.
$$
  \cpABSURDZAP*\cpx\cpNN\cpGG\DP
$$
The 'inert semantics' for absurd is unsatisfying---something has clearly gone wrong, and instead of cleaning up, we leave the garbage strewn around. However, it is not *incorrect*. By accident, it satisfies all the expected properties of normalisation for CP.
(The accident is the fact that CP processes are fully connected. Hence, even if $\cpAbsurd\cpx$ did not have immediate license to kill some process $\cpP$, it would have obtained it eventually.)
In variants where processes are not always fully connected, the inert semantics break progress (see, e.g., @hcp).
(I present an *exceptional* semantics for the absurd offer in @hcp-zap-exceptionally-absurd-offer[^clarify-exceptional].)

The syntax for the absurd offer deviates from the naming scheme for the binary select and offer actions. If I were to follow the naming scheme, I would write '$\cpAbsurd\cpx$'. However, it is important for the absurd offer to record which endpoints it discards. For one, recording those names allows us to define linearity by counting names (as in @cp-linearity). More importantly, to give an exceptional semantics to the absurd offer, those names are needed to be able to erase types. For an intuition, let us look at the absurd offer in @Wadler12:cpgv's CP. It does not record the discarded endpoints and it has the following reduction rule:
$$
  \AXC{}
  \UIC{$\cpAbsurd{\cpa} \cpSeq \cpGG, \cpa:\cpTop, \cpx:\cpA$}
  \AXC{$\cpP \cpSeq \cpGD, \cpx':\co\cpA$}
  \BIC{$\cpNew(\cpx\cpx')(\cpAbsurd{\cpa}\cpPar\cpP) \cpSeq \cpGG, \cpGD, \cpa:\cpTop$}
  \DP
  \cpEval
  \AXC{$\vphantom{\co{\co{\cpA}}}$}
  \UIC{$\cpAbsurd{\cpa} \cpSeq \cpGG, \cpGD, \cpa:\cpTop$}
  \DP
$$
If the absurd offer discarded an endpoint $\cpx$, it may kill the process $\cpP$ that owns the dual endpoint $\cpx'$.
The reduction rule appears innocuous, but a problem surfaces when we erase types and consider the equivalent reduction rule on *processes*:
$$
  \cpNew(\cpx\cpx')(\cpAbsurd{\cpa}\cpPar\cpP)
  \cpEval
  \cpAbsurd{\cpa}
$$
It is no longer possible to see whether $\cpP$ owns any of the endpoints dual to those discarded, which means that $\cpAbsurd\cpa$ has license to kill *any process*[^clarify-license-to-kill].
Surprisingly, by itself this does not pose a *huge* problem for CP. Ultimately, all processes in CP are connected, so even if $\cpAbsurd\cpa$ were to kill a process it was not immediately connected to, it would have gotten there eventually.
However, if the language were extended with parallel but unconnected processes---as in, e.g., HCP---this leads to immediate problems, where some $\cpAbsurd\cpa$ kills a process it was in no way connected to.
It also leads to issues with scope extrusion in \Rule{C-SC-CutAssoc}:
$$
  \cpNew(\cpx\cpx')(
    \cpNew(\cpy\cpy')(
      \cpP
      \cpPar
      \cpAbsurd\cpa
      )
      \cpPar
      \cpAbsurd\cpb
    )
  \cpEquiv
  \cpNew(\cpy\cpy')(
    \cpNew(\cpx\cpx')(
      \cpP
      \cpPar
      \cpAbsurd\cpb
      )
      \cpPar
      \cpAbsurd\cpa
    )
$$
If $\cpAbsurd\cpa$ is responsible for killing $\cpx$ on the left-hand side of the structural congruence, then on the right-hand side it moves out of the scope of $\cpNew(\cpx\cpx')$.

My syntax, $\cpAbsurdZap\cpa\cpNN$, is an effort to avoid clutter: I omit the absurd continuation and add a lightning bolt, which, to me, implies that something has gone wrong[^clarify-zap].

[^clarify-exceptional]: I use 'exceptional' to mean 'reminiscent of exceptions', but I also happen to believe they are very good semantics.

[^clarify-license-to-kill]: Wadler was unaware of the issue with the absurd offer and type erasure.

[^clarify-zap]: The lightning bolt is an homage to Simon Fowler's Exceptional GV, where it marks "zapper threads" [@Fowler19:thesis, Figure 9.4], and to a poster titled "*zap* is why we can't have nice things" that I presented at my CDT's 2016 Industrial Engagement Event.
