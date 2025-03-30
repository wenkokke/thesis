# Connection and Disentanglement {#hcp-connection-and-disentanglement}

In this section, I formalise the notion of the *connection graph* of a process, and prove *disentanglement*, the property that any HCP process can be rewritten into the parallel composition of CP-like processes, where I use "CP-like" to mean processes that would be syntactically well-formed and well-typed CP processes, i.e., each name restriction is followed by its corresponding parallel composition, each send action is followed by its corresponding parallel composition in the correct order, and each close action is followed by the terminated process.

The first part of this section follows the same structure as the corresponding section for CP [@cp-connection-and-right-branching-form]:

- *Connection Forest*.  
  I define the connection graph for HCP processes, and prove that the connection graph is always a forest.
- *Right-Branching Forest Form*.  
  I define the equivalent of right-branching form for HCP, which is right-branching *forest* form, and prove that any process can be rewritten to right-branching forest form.

The second part of this section proves disentanglement for HCP.
In the introduction, I defined disentanglement as a function that converts HCLL proofs into a sequence of CLL proofs:
$$
  \AXC{$p$}
  \noLine\UIC{$\vdots$}\noLine
  \UIC{$\hpSeq\hpGG_1\hpHTens\dots\hpHTens\hpGG_n$}
  \DP
  \implies
  \AXC{$p_1$}
  \noLine\UIC{$\vdots$}\noLine
  \UIC{$\hpSeq\hpGG_1$}
  \DP
  ,
  \dots
  ,
  \AXC{$p_n$}
  \noLine\UIC{$\vdots$}\noLine
  \UIC{$\hpSeq\hpGG_n$}
  \DP
$$
For the process calculus HCP, I prefer a slightly stronger property.
Disentanglement should convert HCP processes to the parallel composition of CP-like processes *and* should be justified by the structural congruence.
For any well-typed process $\hpP\hpSeq\hpHG^k$:

- If $k=0$, then $\hpP\hpEquiv\hpZ$ and $\hpHG^0=\hpHOne$.
- If $k \geq 1$, then  $\hpP\hpEquiv\hpP_1\hpPar\hptm\dots\hpPar\hpP_k$ and $\hpHG^k=\hpGG_1\hpHTens\dots\hpHTens\hpGG_k$ such that $\hpP_i\hpSeq\hpGG_i$ (for $1 \leq i \leq k$) and each $\hpP_i$ is CP-like.

The conversion to right-branching forest form satisfies part of this definition. It converts an HCP process to a sequence of processes that are typed under a single typing environment, *and* it is justified by the structural congruence.
However, the conversion is *shallow*.
It only rewrites the maximum configuration context.
Hence, the resulting processes are *shallowly* CP-like.
Only the name restrictions and parallel compositions in their maximum configuration contexts are arranged as CP cuts.

I define disentanglement by iterating the conversion to right-branching forest form, which arranges *all* name restrictions and parallel compositions as CP cuts, and subsequently arranging the continuations of send and close actions to match those of CP send and close actions.
(I defer the proof that disentangled processes are CP-like to @hcp-fission-fusion-and-disentanglement, where I discuss the translation between HCP processes and multisets of CP processes.)

Let us revisit connection graphs by examining three example processes:
$$
\begin{array}{ll}
  (1)
  &
  \hpNew(\hpx\hpx')%
  \hpNew(\hpy\hpy')%
  \hpNew(\hpz\hpz')(\;%
    \hpClose\hpx.0\;%
    \hpPar\;%
    \hpClose\hpy.0\;%
    \hpPar\;%
    \hpClose\hpz.0\;%
    \hpPar\;%
    \hpWait{\hpx'}.\hpWait{\hpy'}.\hpWait{\hpz'}.\hpP\;%
  )
  \\[1em]
  (2)
  &
  \hpNew(\hpx\hpx')%
  \hpNew(\hpy\hpy')%
  \hpNew(\hpz\hpz')(\;%
    \hpClose\hpy.0\;%
    \hpPar\;%
    \hpWait{\hpy'}.\hpClose\hpx.0\;%
    \hpPar\;%
    \hpClose\hpz.0\;%
    \hpPar\;%
    \hpWait{\hpz'}.\hpWait{\hpx'}.\hpP\;%
  )
  \\[1em]
  (3)
  &
  \hpNew(\hpx\hpx')%
  \hpNew(\hpy\hpy')(\;%
    \hpClose\hpx.0\;%
    \hpPar\;%
    \hpWait{\hpx'}.\hpP\;%
    \hpPar\;%
    \hpClose\hpy.0\;%
    \hpPar\;%
    \hpWait{\hpy'}.\hpQ\;%
  )
\end{array}
$$
The connection graph of a process is the graph formed of all ready sub-processes and the channels that connect them.
Whereas CP's connection graphs are trees, HCP's connection graphs are forests.
The connection graphs for processes (1) and (2) are equivalent to those for the example processes discussed in @cp-connection-and-right-branching-form.
Both are fully connected, consisting of four threads, connected by three channels.
Process (3) is *not* fully connected. It consists of four processes, connected in pairs by two channels.
$$
\begin{array}{ll}
  (1)
  &
  \vcenter{\hbox{%
  \begin{tikzpicture}
    \node (P1) at (-3, 0) {$\hpClose\hpx.0$};
    \node (P2) at (-1, 0) {$\hpClose\hpy.0$};
    \node (P3) at ( 1, 0) {$\hpClose\hpz.0$};
    \node (P4) at ( 3, 0) {$\hpWait{\hpx'}.\hpWait{\hpy'}.\hpWait{\hpz'}.\hpP$};
    \draw (P1) to [out=-45,in= 225] node [below=10pt] {$(\hpx,\hpx')$} (P4);
    \draw (P2) to [out=-45,in= 225] node [below=10pt] {$(\hpy,\hpy')$} (P4);
    \draw (P3) to [out=-45,in= 225] node [below=10pt] {$(\hpz,\hpz')$} (P4);
  \end{tikzpicture}}}
  \\[3.5em]
  (2)
  &
  \vcenter{\hbox{%
  \begin{tikzpicture}
    \node (P1) at (-3, 0) {$\hpClose\hpy.0$};
    \node (P2) at (-1, 0) {$\hpWait{\hpy'}.\hpClose\hpx.0$};
    \node (P3) at ( 1, 0) {$\hpClose\hpz.0$};
    \node (P4) at ( 3, 0) {$\hpWait{\hpz'}.\hpWait{\hpx'}.\hpP$};
    \draw (P1) to [out=-45,in= 225] node [below] {$(\hpy,\hpy')$} (P2);
    \draw (P3) to [out=-45,in= 225] node [below] {$(\hpz,\hpz')$} (P4);
    \draw (P2) to [out= 45,in=-225] node [above] {$(\hpx,\hpx')$} (P4);
  \end{tikzpicture}}}
  \\[3.5em]
  (3)
  &
  \vcenter{\hbox{%
  \begin{tikzpicture}
    \node (P1) at (-3, 0) {$\hpClose\hpx.0$};
    \node (P2) at (-1, 0) {$\hpWait{\hpx'}.\hpP$};
    \node (P3) at ( 1, 0) {$\hpClose\hpy.0$};
    \node (P4) at ( 3, 0) {$\hpWait{\hpy'}.\hpQ$};
    \draw (P1) to [out=-45,in= 225] node [below] {$(\hpx,\hpx')$} (P2);
    \draw (P3) to [out=-45,in= 225] node [below] {$(\hpy,\hpy')$} (P4);
  \end{tikzpicture}}}
\end{array}
$$
We can use the connection graph to rewrite any process into right-branching forest form, which is the parallel composition of a sequence of processes in right-branching tree form, which is more or less CP's right-branching form:
$$
\hpNew(\hpx^1_1\hpx'^1_1)(
  \hpP^1_1
  \hpPar
  \hptm\cdots
  \hpNew(\hpx^1_n\hpx'^1_n)(
    \hpP^1_n
    \hpPar
    \hpP^1_{n+1}
  )
  \hptm\cdots
)
\hpPar
\hptm\cdots
\hpPar
\hpNew(\hpx^k_1\hpx'^k_1)(
  \hpP^k_1
  \hpPar
  \hptm\cdots
  \hpNew(\hpx^k_n\hpx'^k_n)(
    \hpP^k_n
    \hpPar
    \hpP^k_{n+1}
  )
  \hptm\cdots
)
$$
As mentioned, CP's right-branching form is often used to write nice and concise proofs. Unfortunately, HCP's right-branching forest form is a bit too verbose to fill the same niche. Worse, the presentation above does not communicate the case where $k=0$ and the process is $\hpZ$.

The procedure to convert processes to right-branching forest form picks a tree from the connection graph, moves *all* the corresponding name restrictions and threads to the top-level, arranges them in right-branching tree form, removes the tree, and continues until the graph is empty.

The procedure to convert processes to right-branching tree form is the same as the procedure for CP. It picks a leaf from the tree, moves the corresponding name restriction and thread to the topmost, leftmost position, removes the leaf, and continues until all of the tree is empty.

A process may have multiple different right-branching forest forms.
The following are one possible right-branching forest form for each of the example processes above:
$$
\begin{array}{ll}
  (1)
  &
  \hpNew(\hpx\hpx')(\;%
    \hpClose\hpx.0\;%
    \hpPar\;%
    \hpNew(\hpy\hpy')(\;%
      \hpClose\hpy.0\;%
      \hpPar\;%
      \hpNew(\hpz\hpz')(\;%
        \hpClose\hpz.0\;%
        \hpPar\;%
        \hpWait{\hpx'}.\hpWait{\hpy'}.\hpWait{\hpz'}.\hpP\;%
      )\;%
    )\;%
  )
  \\[1.5em]
  (2)
  &
  \hpNew(\hpy\hpy')(\;%
    \hpClose\hpy.0\;%
    \hpPar\;%
    \hpNew(\hpx\hpx')(\;%
      \hpWait{\hpy'}.\hpClose\hpx.0\;%
      \hpPar\;%
      \hpNew(\hpz\hpz')(\;%
        \hpClose\hpz.0\;%
        \hpPar\;%
        \hpWait{\hpz'}.\hpWait{\hpx'}.\hpP\;%
      )\;%
    )\;%
  )
  \\[1.5em]
  (3)
  &
  \hpNew(\hpx\hpx')(\;%
  \hpClose\hpx.0\;%
  \hpPar\;%
  \hpWait{\hpx'}.\hpP\;%
  )\;%
  \hpPar\;%
  \hpNew(\hpy\hpy')(\;%
  \hpClose\hpy.0\;%
  \hpPar\;%
  \hpWait{\hpy'}.\hpQ\;%
  )
\end{array}
$$
As in @cp-connection-and-right-branching-form, the definition of connection graph is *shallow*, rather than deep, as we only account for the connections up to the maximum configuration context.
However, in the second part of this section, I will demonstrate that we can use the shallow connection graph to reason about the deep connection structure of a process.

The connection graph is a undirected edge-labelled graph.
I informally revisit the relevant definitions.
For a detailed discussion, see @glossary-graphs.

- A *undirected edge-labelled graph* $G$ has a set of vertices (denoted $\vertices[G]$, ranged over by $u$, $v$), a set of edges (denoted $\edges[G]$), a set of edge labels (denoted $\edgeLabels[G]$), and an edge-labeling function (denoted $\edgeLabelling[G]$) that assigns labels to edges. Edges are unordered pairs denoted by juxtaposition, i.e., $\edge{u}{v}\defeq\{u,v\}$. The set of edges may not contain loops $\edge{u}{u}$.  
  (It suffices to define $\vertices[G]$ and $\edgeLabelling[G]$, since $\edges[G]\defeq\dom(\edgeLabelling[G])$ and $\edgeLabels[G]\defeq\cod(\edgeLabelling[G])$.)
- Two vertices $u,v\in\vertices[G]$ are *adjacent* when there exists an edge $\edge{u}{v}\in\edges[G]$.
- A *walk* $w$ is a sequence of pairwise adjacent vertices.
- A *path* $p$ is a walk with no repeated vertices, except possibly the first and last.
- A *cycle* $c$ is a path that begins and ends at the same vertex.
- The *subgraph of* $G$ *induced by* $U$ (denoted by $G[U]$) is the graph formed by taking the subset of vertices $U$ and restricting the edges, edge labels, and edge-labelling function according to their correctness criteria, i.e., $\edges[G[U]]\defeq\edges[G]\cap\{\edge{u}{v}\vert{u},{v}\in{U}\land{u}\neq{v}\}$.
- A graph is *acyclic* when it does not contain a cycle.
- A graph is *connected* when there is a path between any two vertices.
- A *component* $C$ of a graph is a maximal connected subgraph.
- A *tree* $T$ is a graph that is connected and acyclic.
- A *forest* $F$ is a graph whose components are trees.

(The definition of the connection graph is unchanged from CP, except to account for the terminated process.)

Definition (Connection Graph) {#hcp-connection-graph}.
  ~ The *shallow connection graph* of a well-typed process $\hpP$, written $\connection(\hpP)$, is an undirected edge-labelled graph (see @glossary-graphs) where the vertices are threads, the edges are the channels that connect those threads, and the edges are labelled by unordered pairs of their endpoints.
    The process $\hpP\iotf\hpCC^n[\hpT_1,\hptm\dots,\hpT_n]$ (for some $n \geq 0$).
    The shallow connection graph $\connection(\hpP)$ is defined as:
    $$
      \begin{array}{l@{\;\defeq\;}l}
      \vertices[\connection(\hpP)]
      &
      \{\hpT_1,\dots,\hpT_n\}
      \\
      \edgeLabelling[\connection(\hpP)]
      &
      \{
        \edge{\hpT_i}{\hpT_j}
        \mapsto
        (\hpx,\hpx')
        \vert
        \hpT_i,\hpT_j\in\vertices[\connection(\hpP)],
        \{\hpx,\hpx'\}\in\dn(\hpCC),
        \hpx\in\hpT_i\land\hpx'\in\hpT_j
      \}
      \end{array}
    $$
    By @lemma:cp-separation, $\edges[\connection(\hpP)]$ contains no loops.
    By @proposition:cp-linearity, $\edgeLabelling[\connection(\hpP)]$ is a function.
    If $G$ is a subgraph of some connection graph, I write $\fn(G)$ for the free names in the vertices of $G$, i.e., $\fn(G)\defeq\bigcup_{\hpP\in\vertices[G]}\fn(\hpP)$.

In HCP, the connection graph of a process is always a forest.
However, that statement by itself is too weak to prove by induction.
Instead, we prove the stronger proposition that (1) the connection graph is a forest, and (2) that the components in the connection graph correspond one-to-one to the typing environments in the hyper-environment.
When specialised to CP, this property becomes the property that every connection graph is a tree, since every CP process is typed under exactly one typing environment, and its connection graph is always connected.

The proof does not differ significantly from CP. There is only the small additional burden of maintaining the isomorphism between component and typing environments.
The interesting case is the case for name restriction, which, as for CP, relies on the property that connecting two trees with a single edge yields another tree.

Proposition {#hcp-connection-forest}.
  ~ If $\hpP\hpSeq\hpHG$, then $\connection(\hpP)$ is a forest, and there is an isomorphism $f$ between the typing environments in $\hpHG$ and the trees of $\connection(\hpP)$ that preserves $\fn$, i.e., $\fn(\hpGG)=\fn(f(\hpGG))$.

```include
proofs/hcp-connection-forest.md
```

A process is in right-branching forest form when it is either $\hpZ$ or it  is the parallel composition of processes in right-branching tree form.

Definition (Right-branching Tree Form) {#hcp-right-branching-tree-form}.
  ~ A process $\hpP$ is in *right-branching tree form* if $\hpP$ is ready or if $\hpP$ is of the form (for some $n \geq 1$)
    $$
    \hpNew(\hpx_1\hpx'_1)(
      \hpT_1
      \hpPar
      \hptm\cdots
      \hpNew(\hpx_n\hpx'_n)(
        \hpT_n
        \hpPar
        \hpT_{n+1}
      )
      \hptm\cdots
    )
    $$

A process is in right-branching tree form is if is a right-branching list of CP cuts connecting threads.

(The definition of right-branching tree form is unchanged, except in name, from CP's definition of right-branching form.)

Definition (Right-branching Forest Form) {#hcp-right-branching-forest-form}.
  ~ A process $\hpP$ is in *right-branching forest form*
    if $\hpP$ is of the form $\hpZ$, or
    if $\hpP$ is of the form $\hpP_1\hpPar\hptm\cdots\hpPar\hpP_n$
    (for some $n \geq 1$)
    such that (for $1 \leq i \leq n$)
    each $\hpP_i$ is in right-branching tree form.

Any well-typed process can be rewritten to right-branching forest form.
The proof is given by induction on the structure of the hypersequent, and is decomposed into two lemmas, which correspond to the two cases of the induction:

- If $\hpP\hpSeq\hpHOne$, then $\hpP$ can be rewritten to the terminated process.
- If $\hpP\hpSeq\hpHG\hpHTens\hpGG$, then $\hpP$ can be rewritten to pull one process in right-branching tree form out to the top level, using a procedure similar to the one used for converting CP processes to right-branching form.

Lemma {#hcp-hyper-consistency}.
  ~ If $\hpP\hpSeq\hpHOne$, then $\hpP\hpEquivLPS\hpZ$.

```include
proofs/hcp-hyper-consistency.md
```

Lemma {#hcp-right-branching-tree-form}.
  ~ If $\hpP\hpSeq\hpHG\hpHTens\hpGG$,
    then there exist processes $\hpQ$ and $\hpR$
    such that $\hpQ\hpSeq\hpHG$,
    $\hpR\hpSeq\hpGG$,
    $\hpP\hpEquivLPS\hpQ\hpPar\hpR$,
    and $\hpR$ is in right-branching tree form.

```include
proofs/hcp-right-branching-tree-form.md
```

Proposition {#hcp-right-branching-forest-form}.
  ~ If $\hpP\hpSeq\hpHG$,
    then there exists a process $\hpQ$,
    such that $\hpP\hpEquivLPS\hpQ$,
    and $\hpQ$ is in right-branching forest form,
    and there is an isomorphism $f$ between the processes in right-branching tree form in $\hpQ$ and the typing environments in $\hpHG$ that preserves $\fn$, i.e., $\fn(\hpGG)=\fn(f(\hpGG))$.

```include
proofs/hcp-right-branching-forest-form.md
```

Connection graphs are an alternative representation for processes, with the interesting property that they represent the maximum configuration context of a process without any spurious ambiguity. Connection graphs correspond to shallow proof nets for HCLL.
(For a more detailed discussion of the correspondence between connection graphs and proof nets, see @cp-connection-and-right-branching-form.)

Proposition {#hcp-connection-graph-equiv-lps}.
  ~ If $\hpP$ is well-typed,
    then $\hpP\hpEquivLPS\hpQ\iff\connection(\hpP)=\connection(\hpQ)$.

```include
proofs/hcp-connection-graph-equiv-lps.md
```

An HCP process is disentangled when it is the terminated process, or the parallel composition of a sequence of CP-like processes.
The formal definition does not make explicit reference to CP syntax, and I defer the proof disentangled HCP processes correspond to CP processes to @hcp-fission-fusion-and-disentanglement.

Definition (Disentangled) {#hcp-disentangled}.
  ~ A process $\hpP$ is *disentangled* when every terminated process matches the form of a CP close, and every parallel composition matches the form of a CP cut or CP send, or is at the top-level.

    Formally, $\hpP$ is *disentangled* when the following conditions hold:

    1.  If $\hpP$ is of the form $\hpCQ[\hpP_1\hpPar\hpP_2]$,
        then one of the following holds:

        a.  $\hpCQ$ is of the form $\hpCR[\hpNew(\hpx\hpx')\hpHole]$
            such that $\hpx\in\fn(\hpP_1)$ and $\hpx'\in\fn(\hpP_2)$.
        b.  $\hpCQ$ is of the form $\hpCR[\hpSend\hpx\hpy.\hpHole]$
            such that $\hpy\in\fn(\hpP_1)$ and $\hpx\in\fn(\hpP_2)$.
        c.  $\hpCQ$ is of the form $\hpEE$
            such that $\bn(\hpEE)=\emptyset$.
    2.  If $\hpP$ is of the form $\hpCQ[\hpZ]$,
        then one of the following holds:

        a.  $\hpCQ$ is of the form $\hpHole$.
        b.  $\hpCQ$ is of the form $\hpCR[\hpClose\hpx.\hpHole]$.

The conditions of disentangled form in @definition:hcp-disentangled are sufficient to guarantee that the process is CP-like.

Lemma {#hcp-disentangled}.
  ~ If $\hpP\hpSeq\hpHG$ and $\hpP$ is disentangled, then:

    $\!\!\quad%
    \begin{array}{
        l@{\text{.\ }}
        l@{\iotf}l
        @{\implies}
        l@{\iotf}l}
    \text{1}
    &\hpHG
    &\hpHOne
    &\hpP
    &\hpZ
    \\
    \text{2}
    &\hpHG
    &\hpHG\hpHTens\hpGG
    &\hpP
    &\hpQ\hpPar\hpR
    \\
    \text{3}
    &\hpP&
    \hpCQ[\hpNew(\hpx\hpx')\hpR]
    &\hpR
    &\hpR_1\hpParSplit\hpx{\hpx'}\hpR_2
    \\
    \text{4}
    &\hpP&
    \hpCQ[\hpSend\hpx\hpy.\hpR]
    &\hpR
    &\hpR_1\hpParSplit\hpy\hpx\hpR_2
    \\
    \text{5}
    &\hpP&
    \hpCQ[\hpClose\hpx.\hpR]
    &\hpR
    &\hpZ
    \end{array}$

```include
proofs/hcp-disentangled.md
```

Every HCP process can be disentangled.

Right-branching forest form is useful for disentangling processes, but not quite sufficient.
If we convert every sub-process to right-branching forest form, the resulting process is *nearly* disentangled.
Every terminated process matches the form of a CP close, and every parallel composition is at the top-level, matches a CP cut, or *nearly* matches a CP send.
The continuation of a send action must be the parallel composition that splits the corresponding endpoints, but the processes need not be in the correct order, i.e., we may have $\hpSend\hpx\hpy.\hpQ\hpPar\hpP$, where $\hpQ$ handles $\hpx$ and $\hpP$ handles $\hpy$.

To disentangle a process, we convert every sub-process to right-branching forest form, and take special care to correct the order in the continuation of send actions.

Proposition {#hcp-disentanglement}.
  ~ If $\hpP\hpSeq\hpHG$, then there exists some $\hpQ$ such that $\hpP\hpEquivLPS\hpQ$ and $\hpQ$ is disentangled.

```include
proofs/hcp-disentanglement.md
```

Disentanglement is the procedure defined by the proof of @proposition:hcp-disentanglement.
The procedure is non-deterministic and follows the outline in the introduction to this section.
(The non-determinism arises from the arbitrary choice of tree in @proposition:hcp-disentanglement and the arbitrary choice of leaf in @lemma:hcp-right-branching-tree-form.)

The result is a function that converts a process to a *set* of disentangled processes, all of which are equivalent to the original process and to each other by structural congruence.

Definition (Disentanglement) {#hcp-disentanglement}.
  ~ The *disentanglement* of $\hpP$, written $\hpBigDis(\hpP)$, is the set of processes obtained from $\hpP$ by @proposition:hcp-disentanglement.

    All elements of $\hpBigDis(\hpP)$ are equivalent to each other and to $\hpP$ under link-preserving structural congruence.
    I use $\hpBigDis$ as functional under structural congruence, and write $\hpBigDis(\hpP)\hpEquivLP\hpQ$ to mean $\hpQ$ is an arbitrary element of $\hpBigDis(\hpP)$.
    I extend $\hpBigDis$ to configuration and evaluation contexts by preserving holes and otherwise acting as on the corresponding process terms.

The disentanglement $\hpBigDis(\hpP)$ does not contain *all* disentangled processes equivalent to $\hpP$, only those which are in right-branching form.

Disentanglement distributes over maximal evaluation contexts.

Lemma {#hcp-disentanglement-distributes-over-maximal-evaluation-contexts}.
  ~ If $\hpEE[\hpT]\hpSeq\hpHG$,
    then $\hpBigDis(\hpEE[\hpT])=\{
      \hpEE'[\hpT']
      \mid
      \hpEE'\in\hpBigDis(\hpEE),
      \hpT'\in\hpBigDis(\hpT)
    \}$.

Disentanglement distributes over the maximum configuration context.

Lemma {#hcp-disentanglement-distributes-over-maximum-configuration-context}.
  ~ If $\hpCC[\hpT_1,\hptm\dots,\hpT_n]\hpSeq\hpHG$,
    then
    $$
    \hpBigDis(\hpCC[\hpT_1,\hptm\dots,\hpT_n])
    =
    \{
      \hpCC'[\hpT'_{ρ(1)},\hptm\dots,\hpT'_{ρ(n)}]
      \mid
      \exists{ρ}.
      \hpCC'\in\hpBigDis(\hpCC),
      \hpT'_1\in\hpBigDis(\hpT_1),
      \dots,
      \hpT'_n\in\hpBigDis(\hpT_n)
    \}
    $$
    where $ρ$ is a permutation on the indices $[1,n]$.

The set of right-branching forms of a process is closed under link-preserving shallow structural congruence, as link-preserving shallow structural congruence preserves the connection graph.
Likewise, the disentanglement is closed under any link-preserving structural congruence.

Lemma {#hcp-disentanglement-closed}.
  ~ If $\hpP\hpSeq\hpHG$ and $\hpP\hpEquivLP\hpQ$,
    then $\hpBigDis(\hpP)=\hpBigDis(\hpQ)$.

More importantly, disentanglement is closed under CP's structural congruence, as we will see in @hcp-fission-fusion-and-disentanglement.
First, however, we must pause our discussion of disentanglement to introduce Multiset CP, the calculus of multisets of CP processes.
