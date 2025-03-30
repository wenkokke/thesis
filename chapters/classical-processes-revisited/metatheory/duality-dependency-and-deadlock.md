# Duality, Dependency, and Deadlock {#cp-duality-dependency-and-deadlock}

The definition of canonical form [@definition:cp-canonical-form] requires justification: it defines "canonical forms" as "processes that do not reduce", which is an easy way to get in trouble by admitting processes as "canonical" when they are, in fact, stuck for undesirable reasons such as deadlock.

It is straightforward to argue that processes in canonical form *must* contain a process ready to act on a free endpoint, which puts @definition:cp-canonical-form on par with @Wadler12:cpgv's definition of canonical form [see @cp-commuting-conversions] and @LindleyM15:gv's definition of blocking.
The argument relies on the simple combinatorics of configuration contexts.
Any configuration context with $n$ holes must contain exactly $n - 1$ cuts, and therefore must create exactly $n - 1$ channels.

Lemma {#cp-configuration-context-bound-name-count}.
  ~ For any $\cpCC^n$,
    $\card{\dn(\cpCC^n)} = n - 1$ and $\card{\bn(\cpCC^n)} = 2 (n - 1)$.

```include
proofs/cp-configuration-context-bound-name-count.md
```

The fact that *some* process must be ready to act on a free endpoint follows, since you cannot have $n$ processes ready to act on $n - 1$ channels without having at least two of them ready to act on the same channel.

Proposition (Canonical Form) {#cp-canonical-form}.
  ~ Any well-typed process $\cpP$ in canonical form contains a thread that is ready to act on a free endpoint.

```include
proofs/cp-canonical-form.md
```

Unfortunately, that characterisation is *inadequate*, since it does not guarantee that the process cannot reduce.
An adequate definition should to match the intuition that *all communication* in processes that cannot reduce is blocked on free endpoints.
To formalise this notion, we must ensure that every ready action is blocked on an action on (1) a free endpoint or (2) a bound endpoint whose dual depends on some ready action that is blocked. For instance, in the process
$$
  \cpNew(\cpx\cpx')(\cpWait\cpa.\cpClose\cpx.0\cpPar\cpWait{\cpx'}.\cpP)
$$
the action $\cpWait\cpa$ is blocked on the free endpoint $\cpa$, but the action $\cpWait{\cpx'}$ is blocked because its dual action, $\cpClose\cpx$, depends on the action $\cpWait\cpa$, which is blocked on the free endpoint $\cpa$.

I formalise the notion of one action *depending* on another as the *shallow dependency graph* of a process. The dependency graph is a mixed graph, where undirected edges represent connected endpoints, either by link or by cut, and directed edges---or arcs---represent sequential dependencies. For instance, the shallow dependency graph for the above process is
$$
\begin{tikzpicture}
  \node (a) at (0, 0) {$\cpWait{\cpa}$};
  \node (x) at (2, 0) {$\cpClose{\cpx}$};
  \node (X) at (2,-1.5) {$\cpWait{\cpx'}$};
  \node (P) at (4,-1.5) {$\dots$};
  \draw [->] (a) -- (x);
  \draw      (x) -- (X);
  \draw [->] (X) -- (P.north west);
  \draw [->] (X) -- (P.west);
  \draw [->] (X) -- (P.south west);
\end{tikzpicture}
$$
where the arrows out of $\cpWait{\cpx'}$ connect to the actions in $\cpP$.
The graph is *shallow* because it only tracks dependencies up to the *first action*, e.g., any dependencies within $\cpP$ are not tracked.

To define the dependency graph, we need some way to uniquely refer to actions. Unfortunately, the actions themselves are not unique---consider, e.g., $\cpSelect\cpx<1.\cpSelect\cpx<1.\cpClose\cpx.0$.
For shallow dependencies, it suffices to use endpoint names to refer to the first action on that endpoint. The dependency graph of the above process then becomes
$$
\begin{tikzpicture}
  \node (a) at (0, 0) {$\cpa$};
  \node (x) at (2, 0) {$\cpx$};
  \node (X) at (2,-1.5) {$\cpx'$};
  \node (P) at (4,-1.5) {$\fn(\cpP)$};
  \draw [->] (a) -- (x);
  \draw      (x) -- (X);
  \draw [->] (X) -- (P.north west);
  \draw [->] (X) -- (P.west);
  \draw [->] (X) -- (P.south west);
\end{tikzpicture}
$$
For the *deep* dependency graph, we could augment names with indices tracking the usage, e.g., letting $(\cpSelect\cpx<1,1)$ and $(\cpSelect\cpx<1,0)$ refer to the first and second occurrence of $\cpSelect\cpx<1$ in $\cpSelect\cpx<1.\cpSelect\cpx<1.\cpClose\cpx.0$.
Alternatively, we could assign fresh vertices to each action [as is done in Priority CP, see @priorities].
Fortunately, the shallow variants suffice for my purposes in this chapter.

The dependency graph is a mixed graph.
I informally revisit the relevant definitions.
For a detailed discussion, see @glossary-graphs.

- A *mixed graph* $G$ has a set of vertices (denoted $\vertices[G]$, ranged over by $u$, $v$), a set of edges (denoted $\edges[G]$), a set of arcs (denoted $\arcs[G]$).
  Edges are unordered pairs denoted by juxtaposition, i.e., $\edge{u}{v}\defeq\{u,v\}$.
  The set of edges may not contain loops $\edge{u}{u}$.
  Arcs are ordered pairs denoted by juxtaposition overset with an arrow to indicate the direction, i.e., $\arc{u}{v}\defeq(u,v)$.
  The set of arcs may not contain loops $\arc{u}{u}$.
- For any graph $G$ with vertices $u,v\in\vertices[G]$, $u$ is *adjacent* to $v$ when there exists some edge $\edge{u}{v}\in\edges[G]$ or some arc $\arc{u}{v}\in\arcs[G]$.
- A *walk* $w$ is a sequence of pairwise adjacent vertices.
- A *path* $p$ is a walk with no repeated vertices, except possibly the first and last.
- A *cycle* $c$ is a path that begins and ends at the same vertex.
- A walk is *essentially directed* when it contains at least one arc.
- A graph is *essentially acyclic* if and only if it contains no essentially directed cycles.
- The *undirected reachability* relation (denoted by $\dual[G]$) is the equivalence closure over $\edges[G]$.
- The *essentially directed reachability* relation (denoted by $\reaches[G]$) is the transitive closure over $\arcs[G]$ quotiented by $\dual[G]$.

The vertices of the dependency graph are endpoint names, which are a proxy for the first action on that endpoint.
The edges represent channels, created by either links or cuts.
The arcs represent dependencies, created by prefixing.
For instance, in $\cpWait\cpa.\cpClose\cpb.\cpZ$, the process $\cpClose\cpb.\cpZ$ is prefixed with the action $\cpWait\cpa$. Hence, the action on $\cpb$ depends on the action on $\cpa$.

Definition (Dependency graph) {#cp-dependency-graph}.
  ~ The *shallow dependency graph* of a process $\cpP$, written $\dependency(\cpP)$, is a mixed graph (see @glossary-graphs) defined by the structure of the process $\cpP$.
    The process $\cpP\iotf\cpCC^n[\cpT_1\cptm,\cptm\dots\cptm,\cpT_n]$ (for some $n \geq 1$).
    The shallow dependency graph $\dependency(\cpP)$ is defined as:
    $$
    \begin{array}{l@{\;\defeq\;}l}
    \vertices[\dependency(\cpP)]
    &
    \bigcup_{1 \leq i \leq n}
    \fn(\cpT_i)
    \\
    \edges[\dependency(\cpP)]
    &
    \bigcup_{1 \leq i \leq n}
    \{
      \edge\cpx\cpy
      \vert
      \cpT_i=\cpLink\cpx\cpy
    \}
    \cup
    \{
      \edge{\cpx}{\cpx'}
      \vert
      \{\cpx,\cpx'\}\in\dn(\cpCC)
    \}
    \\
    \arcs[\dependency(\cpP)]
    &
    \bigcup_{1 \leq i \leq n}
    \{
      \arc\cpx\cpy
      \vert
      \cpx,\cpy\in\fn(\cpT_i),
      \readyOn{\cpT_i}{\cpx}
      \land
      \neg\readyOn{\cpT_i}{\cpy}
    \}
    \end{array}
    $$
<!--
    $$
    \def\LongestCaseForDependency{%
      \{
        \arc\cpx\cpy
        \vert
        \cpx,\cpy\in\fn(\cpP),
        \readyOn\cpP\cpx\land\cpx\neq\cpy
      \}}
    \newlength{\cpWidthOfLongestCaseForDependency}
    \settowidth{\cpWidthOfLongestCaseForDependency}{$\LongestCaseForDependency$}
    \begin{aligned}
      \vertices[\dependency(\cpP)]
      & \defeq
      \begin{cases}
      \makebox[\cpWidthOfLongestCaseForDependency][l]{$
        \vertices[\dependency(\cpP_1)]
        \cup
        \vertices[\dependency(\cpP_2)]
      $}
      &\text{if }\cpP=\cpNew(\cpx\cpx')(\cpP_1\cpPar\cpP_2)
      \\
      \fn(\cpP)
      &\text{otherwise}
      \end{cases}
      \\
      \edges[\dependency(\cpP)]
      & \defeq
      \begin{cases}
      \makebox[\cpWidthOfLongestCaseForDependency][l]{$
        \{\edge{\cpx}{\cpy}\}
      $}
      &\text{if }\cpP=\cpLink\cpx\cpy
      \\
      \{\edge{\cpx}{\cpx'}\}
      \cup
      \edges[\dependency(\cpP_1)]
      \cup
      \edges[\dependency(\cpP_2)]
      &\text{if }\cpP=\cpNew(\cpx\cpx')(\cpP_1\cpPar\cpP_2)
      \\
      \emptyset
      &\text{otherwise}
      \end{cases}
      \\
      \arcs[\dependency(\cpP)]
      & \defeq
      \begin{cases}
      \emptyset
      &\text{if }\cpP=\cpLink\cpx\cpy
      \\
      \arcs[\dependency(\cpP_1)]
      \cup
      \arcs[\dependency(\cpP_2)]
      &\text{if }\cpP=\cpNew(\cpx\cpx')(\cpP_1\cpPar\cpP_2)
      \\
      \LongestCaseForDependency
      &\text{otherwise}
      \end{cases}
    \end{aligned}
    $$
-->
    By @lemma:cp-separation, $\edges[\dependency(\cpP)]$ and $\arcs[\dependency(\cpP)]$ contain no loops.
    If $G$ is (the subgraph of) some dependency graph, I write $\fn(G)$ for its vertices, i.e., $\fn(G)=\vertices[G]$.

The dependency graph gives us *duality* on actions, which is undirected reachability in the dependency graph.

Definition (Duality) {#cp-duality}.
  ~ An endpoint $\cpx$ is *dual* to some endpoint $\cpy$ in $\cpP$, written $\cpx\dual[\cpP]\cpy$, if and only if there exists an undirected path from $\cpx$ to $\cpy$ in $\dependency(\cpP)$.

If $\cpx\dual[\cpP]\cpy$, the corresponding path in $\dependency(\cpP)$ may be arbitrarily long, as undirected edges arise from both cuts and links. Consider the process
$$
  \cpNew(\cpx\cpx')(\cpLink\cpa\cpx\cpPar\cpLink{\cpx'}\cpb)
$$
The duality $\cpa\dual\cpb$ is witnessed by the path $(\edge\cpa\cpx, \edge\cpx{\cpx'}, \edge{\cpx'}\cpb)$. The structure generated by cuts and links does not fork, i.e., each component of the undirected subgraph of the dependency graph is a path.

The dependency graph also gives us *dependency* on actions, which is the converse of essentially directed reachability in the dependency graph.

Definition (Dependency) {#cp-dependency}.
  ~ An endpoint $\cpx$ *depends* on some endpoint $\cpy$, written $\cpx\depends[\cpP]\cpy$, if and only if there exists an essentially directed path from $\cpy$ to $\cpx$ in $\dependency(\cpP)$.

One quirk of using endpoints as a proxy for actions is that the duality and dependency appear to "leak" restricted names, i.e., $\dual[\cpP]$ and $\depends[\cpP]$ are not relations over $\fn(\cpP)$, but relations over $\fn(\cpP)\cup\bn(\cpCC)$, where $\cpCC$ is the maximum configuration context of $\cpP$. However, as discussed, these relations should be viewed as relations on the first actions on those endpoints, not the endpoints themselves.

A process is in deadlock if the dependency relation is not antisymmetric, or, equivalently, if there is an essentially directed cycle in the dependency graph that contains at least one arc.

Definition (Deadlock) {#cp-deadlock}.
  ~ A process $\cpP$ is in deadlock, written $\deadlock(\cpP)$, if $\dependency(\cpP)$ contains an essential cycle.

Every well-typed CP process is deadlock-free.

Proposition {#cp-deadlock-free}.
  ~ If $\cpP\cpSeq\cpGG$, then $\neg\deadlock(\cpP)$.

```include
proofs/cp-deadlock-free.md
```

The definition of deadlock is *shallow*.
If a process is "free from deadlock", that means the process is not in *immediate deadlock*.
However, it does not mean that the process can never become deadlocked.
Fortunately, the latter follows by type preservation.
Since well-typed processes are free from immediate deadlock, and reduction preserves types, no well-typed process can ever reduce to a deadlocked process.

Care should be taken to only use @definition:cp-deadlock for well-typed processes, as it does not imply session fidelity, the property that dual endpoints are used in dual ways. Hence, there are ill-typed processes that are morally in deadlock, but whose dependency graphs are essentially acyclic. For instance, the ill-typed process $\cpNew(\cpx\cpx')(\cpWait{\cpx}.\cpP\cpPar\cpWait{\cpx'}.\cpQ)$ is *morally* in deadlock, but its dependency graph is essentially acyclic:
$$
\begin{tikzpicture}
  \node (P) at (0, 0) {$\fn(\cpP)$};
  \node (Q) at (2, 0) {$\fn(\cpQ)$};
  \node (x) [below=1em of P] {$\cpx$};
  \node (X) [below=1em of Q] {$\cpx'$};
  \draw      (x) -- (X);
  \draw [->] (x) -- (P.south east);
  \draw [->] (x) -- (P.south);
  \draw [->] (x) -- (P.south west);
  \draw [->] (X) -- (Q.south east);
  \draw [->] (X) -- (Q.south);
  \draw [->] (X) -- (Q.south west);
\end{tikzpicture}
$$

A *blocking action* is an action that blocks a process from making progress.
For instance, in the process
$$
  \cpNew(\cpx\cpx')(\cpWait\cpa.\cpClose\cpx.0\cpPar\cpWait{\cpx'}.\cpP)
$$
the action $\cpWait\cpa$ is *blocking*. However, not every ready action is *blocking*. The action $\cpWait{\cpx'}$ is ready, but not blocking. Rather, it is *blocked*: its dual $\cpClose\cpx$ depends on $\cpWait\cpa$, so it cannot reduce until $\cpWait\cpa$ does.

As with dependency, I approximate blocking actions by their endpoints.
*Blocking endpoint* are the maxima of the dependency relation, or, equivalently, the sources of the dependency graph. The blocking set of a process is the set of all sources of its dependency graph. Every ready action in a process is blocked on one of the endpoints in the blocking set.

Definition (Blocking Set) {#cp-blocking-set}.
  ~ The *blocking set* of endpoints of a process $\cpP$, written $\blocking(\cpP)$, is the set of sources of $\dependency(\cpP)$, i.e.,
    $\{
      \cpx\in{V_{\dependency(\cpP)}}
      \vert
      \nexists\cpy.\cpx\depends[\cpP]\cpy
    \}$.

The blocking set is closed under duality.

Lemma {#cp-blocking-closed-under-duality}.
  ~ If $\cpP\cpSeq\cpGG$ and $\cpx\dual[\cpP]\cpy$,
    then $\cpx\in\blocking(\cpP)\implies\cpy\in\blocking(\cpP)$.

Each endpoint in the blocking set corresponds to a ready action.

Lemma {#cp-blocking-implies-ready}.
  ~ If $\cpP\cpSeq\cpGG$ and $\cpx\in\blocking(\cpP)$,
    then $\cpP\iotf\cpEE[\cpT]$ such that $\readyOn\cpT\cpx$.

Due to the dualities generated by links, the blocking set may contain more endpoints than necessary. For instance, the blocking set of the process
$$
  \cpNew(\cpx\cpx')(\cpLink\cpx\cpa\cpPar\cpWait{\cpx'}.\cpP)
$$
is $\{\cpx,\cpx',\cpa\}$. An action in $\cpP$ is blocked on all of these endpoints. However, I want to be able to say that every action is blocked on a free name, and, in this case, the set $\{\cpa\}$ suffices.
A process is blocked on a set of endpoints if any action is blocked on at least one endpoint in that set.

Definition (Blocked) {#cp-blocked}.
  ~ A process $\cpP$ is *blocked* on a set of endpoints $\cptm{X}$, written $\blocked(\cpP,\cptm{X})$, if closing $\cptm{X}$ under duality yields the blocking set $\blocking(\cpP)$, i.e., if $\cpx\in\cptm{X}$ and $\cpx\dual[\cpP]\cpy$, then $\cpy\in\blocked(\cpP)$.

Any process is blocked on its blocking set.

Lemma {#cp-blocked-blocking}.
  ~ If $\cpP\cpSeq\cpGG$, then $\blocked(\cpP,\blocking(\cpP))$.

If a process is blocked on some set of endpoints, it is blocked on the set formed by replacing any endpoint in that set with its dual.

Lemma {#cp-blocked-closed-under-duality}.
  ~ If $\cpP\cpSeq\cpGG$ and $\cpx\dual[\cpP]\cpy$,
    then $\blocked(\cpP,\cptm{X})\implies\blocked(\cpP,\cptm{X}\cpSubst\cpy\cpx)$.

If a process cannot β-reduce, then it is blocked on some set of free names.

Proposition {#cp-beta-free-iff-blocked-on-free}.
  ~ If $\cpP\cpSeq\cpGG$,
    then $\cpP\cpEvalB/ \iff \exists\cptm{A}\subseteq\fn(\cpP).\blocked(\cpP,\cptm{A})$.

```include
proofs/cp-beta-free-iff-blocked-on-free.md
```

Corollary {#cp-canonical-implies-blocking-free}.
  ~ If $\cpP\cpSeq\cpGG$,
    then $\canonical(\cpP) \implies \blocking(\cpP)\subseteq\fn(\cpP)$.

```include
proofs/cp-canonical-implies-blocking-free.md
```

Unfortunately, "blocked on free endpoints" does not characterise canonical forms, as $\blocking(\cpP)\subseteq\fn(\cpP) \nimplies \cpP\cpEvalA/$. For instance, the process
$$
  \cpNew(\cpx\cpx')(
    \cpWait\cpa.\cpClose\cpx.0
    \cpPar
    \cpNew(\cpy\cpy')(
      \cpLink{\cpx'}\cpy
      \cpPar
      \cpWait\cpb.\cpWait{\cpy'}.\cpP
    )
  )
$$
can α-reduce. Its dependency graph, with blocking endpoints circled, is
$$
\begin{tikzpicture}
  \node[draw,circle,minimum size=25] (a) at (0, 1.5) {$\cpa$};
  \node                              (x) at (2, 1.5) {$\cpx$};
  \node                              (X) at (2, 0)   {$\cpx'$};
  \node[draw,circle,minimum size=25] (b) at (4, 1.5) {$\cpb$};
  \node                              (Y) at (6, 1.5) {$\cpy'$};
  \node                              (y) at (6, 0)   {$\cpy$};
  \node                              (P) at (8, 1.5) {$\dots$};
  \draw[->]                          (a) -- (x);
  \draw[->]                          (b) -- (Y);
  \draw                              (x) -- (X);
  \draw                              (X) -- (y);
  \draw                              (y) -- (Y);
  \draw[->]                          (Y) -- (P.north west);
  \draw[->]                          (Y) -- (P.west);
  \draw[->]                          (Y) -- (P.south west);
\end{tikzpicture}
$$
In conclusion, my definition of canonical form [@definition:cp-canonical-form] is *adequate*: any process in canonical form is blocked on some set of free endpoints.
Due to the behaviour of links, "blocked on free endpoints" is insufficient to characterise canonical forms.
As this would be a desirable property to have, I consider an alternative semantics for the link construct when discussing HCP in @hcp-discussion.
I have not adopted any of these alternatives as standard to maintain backwards compatibility with the work based on @Wadler12:cpgv's CP.
