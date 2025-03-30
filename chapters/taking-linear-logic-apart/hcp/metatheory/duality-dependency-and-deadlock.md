# Duality, Dependency, and Deadlock {#hcp-duality-dependency-and-deadlock}

The definition of canonical form [@definition:hcp-canonical-form] requires justification. It defines canonical forms as "processes that do not reduce", which is an easy way to get in trouble and admit processes that are stuck for undesirable reasons such as deadlock as "canonical".

The section follows the same structure as the corresponding section for CP [@cp-duality-dependency-and-deadlock]:

- *Dependency Graph and Deadlock Freedom*.  
  I define the dependency graph for HCP processes, and prove that HCP processes are deadlock-free because their dependency graph is always essentially acyclic.
- *Adequacy*.  
  I define when a process is blocked on a set of endpoints, and prove that an HCP process cannot β-reduce if and only if it is blocked on a set of free endpoints.

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
- A graph is *essentially acyclic* when if it contains no essentially directed cycles.
- A graph is *strongly connected* when if there exists a path between any two vertices.
- A graph is *connected* when if the graph formed by replacing all arcs with edges is strongly connected.
- The *subgraph of* $G$ *induced by* $U$ (denoted by $G[U]$) is the graph formed by taking the subset of vertices $U$ and restricting the edges and arcs according to their correctness criteria, i.e., $\edges[G[U]]\defeq\edges[G]\cap\{\edge{u}{v}\vert{u},{v}\in{U}\land{u}\neq{v}\}$.
- A *component* of a graph is a maximal connected subgraph.
- The *undirected reachability* relation (denoted by $\dual[G]$) is the equivalence closure over $\edges[G]$.
- The *essentially directed reachability* relation (denoted by $\reaches[G]$) is the transitive closure over $\arcs[G]$ quotiented by $\dual[G]$.

The vertices of the dependency graph are endpoint names, which are a proxy for the first action on that endpoint.
The edges represent channels, created by either links or name restrictions.
The arcs represent dependencies, created by prefixing.
For instance, in $\hpWait\hpa.\hpClose\hpb.\hpZ$, the process $\hpClose\hpb.\hpZ$ is prefixed with the action $\hpWait\hpa$. Hence, the action on $\hpb$ depends on the action on $\hpa$.
(The definition of the dependency graph is unchanged from CP, except to account for the terminated process.)

Definition (Dependency Graph) {#hcp-dependency-graph}.
  ~ The *shallow dependency graph* of a process $\hpP$, written $\dependency(\hpP)$, is a mixed graph (see @glossary-graphs).
    The process $\hpP\iotf\hpCC^n[\hpT_1,\hptm\dots,\hpT_n]$ (for some $n \geq 0$).
    The shallow dependency graph $\dependency(\hpP)$ is defined as:
    $$
    \begin{array}{l@{\;\defeq\;}l}
    \vertices[\dependency(\hpP)]
    &
    \bigcup_{1 \leq i \leq n}
    \fn(\hpT_i)
    \\
    \edges[\dependency(\hpP)]
    &
    \bigcup_{1 \leq i \leq n}
    \{
      \edge{\hpx}{\hpy}
      \vert
      \hpT_i=\hpLink\hpx\hpy
    \}
    \cup
    \{
      \edge{\hpx}{\hpx'}
      \vert
      \{\hpx,\hpx'\}\in\dn(\hpCC)
    \}
    \\
    \arcs[\dependency(\hpP)]
    &
    \bigcup_{1 \leq i \leq n}
    \{
      \arc{\hpx}{\hpy}
      \vert
      \hpx,\hpy\in\fn(\hpT_i),
      \readyOn{\hpT_i}{\hpx}
      \land
      \neg\readyOn{\hpT_i}{\hpy}
    \}
    \end{array}
    $$
    By @lemma:hcp-separation, $\edges[\dependency(\hpP)]$ and $\arcs[\dependency(\hpP)]$ contain no loops.
    If $G$ is (the subgraph of) some dependency graph, I write $\fn(G)$ for its vertices, i.e., $\fn(G)=\vertices[G]$.

The dependency graph gives us *duality* on actions, which is undirected reachability in the dependency graph.
(The definition of duality is unchanged from CP.)

Definition (Duality) {#hcp-duality}.
  ~ An endpoint $\hpx$ is *dual* to some endpoint $\hpy$ in $\hpP$, written $\hpx\dual[\hpP]\hpy$, if and only if there exists an undirected path from $\hpx$ to $\hpy$ in $\dependency(\hpP)$.

If $\hpx\dual[\hpP]\hpy$, the corresponding path in $\dependency(\hpP)$ may be arbitrarily long, as undirected edges arise from both cuts and links. Consider the process
$$
  \hpNew(\hpx\hpx')(\hpLink\hpa\hpx\hpPar\hpLink{\hpx'}\hpb)
$$
The duality $\hpa\dual\hpb$ is witnessed by the path $(\edge\hpa\hpx, \edge\hpx{\hpx'}, \edge{\hpx'}\hpb)$.
However, while the paths arising from cuts and links may be arbitrarily long, they must alternate between cut-edges and link-edges and can never branch.

The dependency graph also gives us *dependency* on actions, which is the converse of essentially directed reachability in the dependency graph.
(The definition of dependency is unchanged from CP.)

Definition (Dependency) {#hcp-dependency}.
  ~ An endpoint $\hpx$ *depends* on some endpoint $\hpy$, written $\hpx\depends[\hpP]\hpy$, if and only if there exists an essentially directed path from $\hpy$ to $\hpx$ in $\dependency(\hpP)$.

One quirk of using endpoints as a proxy for actions is that the duality and dependency appear to "leak" restricted names, i.e., $\dual[\hpP]$ and $\depends[\hpP]$ are not relations over $\fn(\hpP)$, but relations over $\fn(\hpP)\cup\bn(\hpCC)$, where $\hpCC$ is the maximum configuration context of $\hpP$. However, as stated, these relations should be viewed as relations on the first actions on those endpoints, not the endpoints themselves.

A process is in deadlock if the dependency relation is not antisymmetric, or, equivalently, if there is a cycle in the dependency graph that contains at least one arc.

Definition (Deadlock) {#hcp-deadlock}.
  ~ A process $\hpP$ is in deadlock, written $\deadlock(\hpP)$, if $\dependency(\hpP)$ contains an essential cycle.

For HCP, the statement that well-typed processes are deadlock free is too weak as an induction hypothesis.
Instead, we prove the stronger proposition that (1) the dependency graph is essentially acyclic, and (2) that the components of the dependency graph correspond one-to-one to the typing environments in the hyper-environment.
When specialised to CP, this property becomes deadlock freedom, since every CP process is typed under exactly one typing environment, and its dependency graph is always connected.

Let us start with the base case. If a process is ready, then its dependency graph is essentially acyclic and connected. The latter suffices, since threads are always typed under a single typing environment.

Lemma {#hcp-dependency-graph-ready}.
  ~ If $\hpP$ is ready, then $\dependency(\hpP)$ is essentially acyclic and connected.

```include
proofs/hcp-dependency-graph-ready.md
```

While the statement of deadlock freedom is stronger, the actual proof does not differ significantly from CP. There is only the small additional burden of maintaining the isomorphism between components and typing environments.
The interesting case is the case for name restriction, which, as for CP, relies on @lemma:mixed-graph-connection, the property that connecting two essentially acyclic graphs with a single edge yields another essentially acyclic graph.

Proposition {#hcp-dependency-graph}.
  ~ If $\hpP\hpSeq\hpHG$, then the dependency graph $\dependency(\hpP)$ is essentially acyclic, and there is an isomorphism $f$ between the typing environments in $\hpHG$ and the components of $\dependency(\hpP)$ that preserves $\fn$, i.e., $\fn(\hpGG)=\fn(f(\hpGG))$.

```include
proofs/hcp-dependency-graph.md
```

Every well-typed HCP process is deadlock-free.
This follows immediately from @proposition:hcp-dependency-graph by forgetting the isomorphism.

Corollary {#hcp-deadlock-free}.
  ~ If $\hpP\hpSeq\hpHG$, then $\neg\deadlock(\hpP)$.

A *blocking action* is an action that blocks a process from making progress.
For instance, in the process
$$
  \hpNew(\hpx\hpx')(\hpWait\hpa.\hpClose\hpx.0\hpPar\hpWait{\hpx'}.\hpP)
$$
the action $\hpWait\hpa$ is *blocking*. However, not every ready action is *blocking*. The action $\hpWait{\hpx'}$ is ready, but not blocking. Rather, it is *blocked*: its dual $\hpClose\hpx$ depends on $\hpWait\hpa$, so it cannot reduce until $\hpWait\hpa$ does.

As I did with dependency, I approximate blocking actions with blocking endpoints. *Blocking endpoints* are the maxima of the dependency relation, or, equivalently, the sources of the dependency graph. The blocking set of a process is the set of all sources of its dependency graph. Every ready action in a process is blocked on one of the endpoints in the blocking set.
(The definition of the blocking set is unchanged from CP.)

Definition (Blocking Set) {#hcp-blocking-set}.
  ~ The blocking set of endpoints of a process $\hpP$, written $\blocking(\hpP)$, is the set of sources of $\dependency(\hpP)$, i.e.,
    $\{
      \hpx\in{V_{\dependency(\hpP)}}
      \vert
      \nexists\hpy.\hpx\depends[\hpP]\hpy
    \}$.

The blocking set is closed under duality.

Lemma {#hcp-blocking-closed-under-duality}.
  ~ If $\hpP\hpSeq\hpGG$ and $\hpx\dual[\hpP]\hpy$,
    then $\hpx\in\blocking(\hpP)\implies\hpy\in\blocking(\hpP)$.

Each endpoint in the blocking set corresponds to a ready action.

Lemma {#hcp-blocking-implies-ready}.
  ~ If $\hpP\hpSeq\hpGG$ and $\hpx\in\blocking(\hpP)$,
    then $\hpP=\hpEE[\hpT]$ and $\readyOn\hpT\hpx$.

Due to the dualities generated by links, the blocking set may contain more endpoints than necessary. For instance, the blocking set of the process
$$
  \hpNew(\hpx\hpx')(\hpLink\hpx\hpa\hpPar\hpWait{\hpx'}.\hpP)
$$
is $\{\hpx,\hpx',\hpa\}$. An action in $\hpP$ is blocked on all of these endpoints. However, I want to be able to say that any action in is blocked on a free name, and, in this case, the set $\{\hpa\}$ suffices.
A process is blocked on a set of endpoints if any action is blocked on at least one endpoint in that set.
(The definition of blocking is unchanged from CP.)

Definition (Blocked) {#hcp-blocked}.
  ~ A process $\hpP$ is blocked on a set of endpoints $\hptm{X}$, written $\blocked(\hpP,\hptm{X})$, if closing $\hptm{X}$ under duality yields the blocking set $\blocking(\hpP)$, i.e., if $\hpx\in\hptm{X}$ and $\hpx\dual[\hpP]\hpy$, then $\hpy\in\blocked(\hpP)$.

Any process is blocked on its blocking set.

Lemma {#hcp-blocked-blocking}.
  ~ If $\hpP\hpSeq\hpGG$, then $\blocked(\hpP,\blocking(\hpP))$.

If a process is blocked on some set of endpoints, it is blocked on the set formed by replacing any endpoint in that set with its dual.

Lemma {#hcp-blocked-closed-under-duality}.
  ~ If $\hpP\hpSeq\hpGG$ and $\hpx\dual[\hpP]\hpy$,
    then $\blocked(\hpP,\hptm{X})\implies\blocked(\hpP,\hptm{X}\hpSubst\hpy\hpx)$.

If a process cannot β-reduce, then it is blocked on some set of free names.

Proposition {#hcp-beta-free-iff-blocked-on-free}.
  ~ If $\hpP\hpSeq\hpGG$,
    then $\hpP\hpEvalB/ \iff \exists\hptm{A}\subseteq\fn(\hpP).\blocked(\hpP,\hptm{A})$.

```include
proofs/hcp-beta-free-iff-blocked-on-free.md
```

Corollary {#hcp-canonical-implies-blocking-free}.
  ~ If $\hpP\hpSeq\hpGG$,
    then $\canonical(\hpP) \implies \blocking(\hpP)\subseteq\fn(\hpP)$.

```include
proofs/hcp-canonical-implies-blocking-free.md
```

Unfortunately, as with CP, "blocked on free endpoints" does not characterise canonical forms, as $\blocking(\hpP)\subseteq\fn(\hpP) \nimplies \hpP\hpEvalA/$. For instance, the process
$$
  \hpNew(\hpx\hpx')(
    \hpWait\hpa.\hpClose\hpx.0
    \hpPar
    \hpNew(\hpy\hpy')(
      \hpLink{\hpx'}\hpy
      \hpPar
      \hpWait\hpb.\hpWait{\hpy'}.\hpP
    )
  )
$$
can α-reduce. Its dependency graph, with blocking endpoints circled, is
$$
\begin{tikzpicture}
  \node[draw,circle,minimum size=25] (a) at (0, 1.5) {$\hpa$};
  \node                              (x) at (2, 1.5) {$\hpx$};
  \node                              (X) at (2, 0)   {$\hpx'$};
  \node[draw,circle,minimum size=25] (b) at (4, 1.5) {$\hpb$};
  \node                              (Y) at (6, 1.5) {$\hpy'$};
  \node                              (y) at (6, 0)   {$\hpy$};
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
In conclusion, my definition of canonical form [@definition:hcp-canonical-form] is *adequate*: any process in canonical form is blocked on some set of free endpoints.
Due to the behaviour of links, "blocked on free endpoints" is insufficient to characterise canonical forms.
As this would be a desirable property to have, I consider alternative semantics for the link construct in @hcp-discussion.
I have not adopted any of these alternatives as standard to maintain backwards compatibility with the work based on @Wadler12:cpgv's CP.
