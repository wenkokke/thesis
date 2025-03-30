# Connection and Right-branching Form {#cp-connection-and-right-branching-form}

In this section, I formalise the notion of the *connection graph* of a process, and show that any CP process can be rewritten into right-branching form.

Definition (Right-branching Form) {#cp-right-branching-form}.
  ~ A process $\cpP$ is in *right-branching form* if $\cpP$ is ready or
    $%
    \cpP
    \iotf
    \cpNew(\cpx_1\cpx'_1)(
      \cpT_1
      \cpPar
      \cptm\cdots
      \cpNew(\cpx_n\cpx'_n)(
        \cpT_n
        \cpPar
        \cpT_{n+1}
      )
      \cptm\cdots
    )$
    for some $n \geq 1$.

As discussed earlier, right-branching form is often used in the literature, but my metatheory avoids it, since it does not generalise to variants of CP that relax its rigid connection structure.
So why am I talking about it?
Of course, it is nice to justify a piece of reasoning that is frequently used.
However, as it turns out, the theory I develop for converting processes to right-branching form will be important in the discussion of HCP.

Let us start by examining the connection graphs and right-branching forms of two simple example processes:
$$
\begin{array}{ll}
  (1)
  &
  \cpNew(\cpx\cpx')(\;%
    \cpClose\cpx.0\;%
    \cpPar\;%
    \cpNew(\cpy\cpy')(\;%
      \cpClose\cpy.0\;%
      \cpPar\;%
      \cpNew(\cpz\cpz')(\;%
        \cpClose\cpz.0\;%
        \cpPar\;%
        \cpWait{\cpx'}.\cpWait{\cpy'}.\cpWait{\cpz'}.\cpP\;%
      )\;%
    )\;%
  )
  \\[1.5em]
  (2)
  &
  \cpNew(\cpx\cpx')(\;%
    \cpNew(\cpy\cpy')(\;%
      \cpClose\cpy.0\;%
      \cpPar\;%
      \cpWait{\cpy'}.\cpClose\cpx.0\;%
    )\;%
    \cpPar\;%
    \cpNew(\cpz\cpz')(\;%
      \cpClose\cpz.0\;%
      \cpPar\;%
      \cpWait{\cpz'}.\cpWait{\cpx'}.\cpP\;%
    )\;%
  )
\end{array}
$$
The connection graph of a process is the graph formed of all ready sub-processes and the channels that connect them.
In the case of the example processes, each one consists of four ready sub-processes which are connected by three channels:
$$
\begin{array}{ll}
  (1)
  &
  \vcenter{\hbox{%
  \begin{tikzpicture}
    \node (P1) at (-3, 0) {$\cpClose\cpx.0$};
    \node (P2) at (-1, 0) {$\cpClose\cpy.0$};
    \node (P3) at ( 1, 0) {$\cpClose\cpz.0$};
    \node (P4) at ( 3, 0) {$\cpWait{\cpx'}.\cpWait{\cpy'}.\cpWait{\cpz'}.\cpP$};
    \draw (P1) to [out=-45,in= 225] node [below=10pt] {$(\cpx,\cpx')$} (P4);
    \draw (P2) to [out=-45,in= 225] node [below=10pt] {$(\cpy,\cpy')$} (P4);
    \draw (P3) to [out=-45,in= 225] node [below=10pt] {$(\cpz,\cpz')$} (P4);
  \end{tikzpicture}}}
  \\[3.5em]
  (2)
  &
  \vcenter{\hbox{%
  \begin{tikzpicture}
    \node (P1) at (-3, 0) {$\cpClose\cpy.0$};
    \node (P2) at (-1, 0) {$\cpWait{\cpy'}.\cpClose\cpx.0$};
    \node (P3) at ( 1, 0) {$\cpClose\cpz.0$};
    \node (P4) at ( 3, 0) {$\cpWait{\cpz'}.\cpWait{\cpx'}.\cpP$};
    \draw (P1) to [out=-45,in= 225] node [below] {$(\cpy,\cpy')$} (P2);
    \draw (P3) to [out=-45,in= 225] node [below] {$(\cpz,\cpz')$} (P4);
    \draw (P2) to [out= 45,in=-225] node [above] {$(\cpx,\cpx')$} (P4);
  \end{tikzpicture}}}
\end{array}
$$
Process (1) is already in right-branching form, though we could reorder the first three processes.
Process (2) is not yet in right-branching form, but we can use the connection graph to convert it to right-branching form.
The procedure picks a leaf from the connection graph, moves the corresponding cut and thread to the topmost, leftmost position, removes the leaf, and continues until all of the graph is empty.
The process below is one of numerous different right-branching forms:
$$
\begin{array}{ll}
  \cpNew(\cpy\cpy')(\;%
    \cpClose\cpy.0\;%
    \cpPar\;%
    \cpNew(\cpx\cpx')(\;%
      \cpWait{\cpy'}.\cpClose\cpx.0\;%
      \cpPar\;%
      \cpNew(\cpz\cpz')(\;%
        \cpClose\cpz.0\;%
        \cpPar\;%
        \cpWait{\cpz'}.\cpWait{\cpx'}.\cpP\;%
      )\;%
    )\;%
  )
\end{array}
$$
Our notion of connection graph is *shallow*, as opposed to deep, as we only account for the connections up to the maximum configuration context.
However, the shallow definition suffices for our purposes and, as we shall see in @hcp, can be used to reason about the deep connection graph of a process by reasoning about the collection of shallow connection graphs of all sub-processes.

The connection graph is a undirected edge-labelled graph.
I informally revisit the relevant definitions.
For a detailed discussion, see @glossary-graphs.

- A *undirected edge-labelled graph* $G$ has a set of vertices (denoted $\vertices[G]$, ranged over by $u$, $v$), a set of edges (denoted $\edges[G]$), a set of edge labels (denoted $\edgeLabels[G]$), and an edge-labeling function (denoted $\edgeLabelling[G]$) that assigns labels to edges. Edges are unordered pairs denoted by juxtaposition, i.e., $\edge{u}{v}\defeq\{u,v\}$. The set of edges may not contain loops $\edge{u}{u}$.  
  (It suffices to define $\vertices[G]$ and $\edgeLabelling[G]$, since $\edges[G]\defeq\dom(\edgeLabelling[G])$ and $\edgeLabels[G]\defeq\cod(\edgeLabelling[G])$.)
- Two vertices $u,v\in\vertices[G]$ are *adjacent* when there exists an edge $\edge{u}{v}\in\edges[G]$.
- A *walk* $w$ is a sequence of pairwise adjacent vertices.
- A *path* $p$ is a walk with no repeated vertices, except possibly the first and last.
- A *cycle* $c$ is a path that begins and ends at the same vertex.
- A graph is *acyclic* when it does not contain a cycle.
- A graph is *connected* when there is a path between any two vertices.
- A *tree* $T$ is a graph that is connected and acyclic.

Definition (Connection graph) {#cp-connection-graph}.
  ~ The *shallow connection graph* of a well-typed process $\cpP$, written $\connection(\cpP)$, is an undirected edge-labelled graph (see @glossary-graphs) where the vertices are threads, the edges are the channels that connect those threads, and the edges are labelled by unordered pairs of their endpoints.
    The process $\cpP\iotf\cpCC^n[\cpT_1\cptm,\cptm\dots\cptm,\cpT_n]$ (for some $n \geq 1$).
    The shallow connection graph $\connection(\cpP)$ is defined as:
    $$
      \begin{array}{l@{\;\defeq\;}l}
      \vertices[\connection(\cpP)]
      &
      \{\cpT_1,\dots,\cpT_n\}
      \\
      \edgeLabelling[\connection(\cpP)]
      &
      \{
        \edge{\cpT_i}{\cpT_j}
        \mapsto
        (\cpx,\cpx')
        \vert
        \cpT_i,\cpT_j\in\vertices[\connection(\cpP)]
        \land
        \{\cpx,\cpx'\}\in\dn(\cpCC)
        \land
        \cpx\in\cpT_i
        \land
        \cpx'\in\cpT_j
      \}
      \end{array}
    $$
    By @lemma:cp-separation, $\edges[\connection(\cpP)]$ contains no loops.

    By @proposition:cp-linearity, $\edgeLabelling[\connection(\cpP)]$ is a function.

    If $G$ is a subgraph of some connection graph, I write $\fn(G)$ for the free names in the vertices of $G$, i.e., $\fn(G)\defeq\bigcup_{\cpP\in\vertices[G]}\fn(\cpP)$.

In CP, the connection graph of a process is always a tree.

Proposition (Connection Tree) {#cp-connection-tree}.
  ~ If $\cpP$ is well-typed, $\connection(\cpP)$ is a tree.

```include
proofs/cp-connection-tree.md
```

The tree structure of the connection graph can be used to rewrite any process to right branching form.

Proposition (Right-branching Form) {#cp-right-branching-form}.
  ~ For any well-typed process $\cpP$,
    there exists a process $\cpQ$
    such that $\cpP\cpEquivLPS\cpQ$
    and $\cpQ$ is in right-branching form.

```include
proofs/cp-right-branching-form.md
```

The tree structure of the connection graph implies deadlock freedom.

Proposition {#cp-deadlock-free-via-connection}.
  ~ If $\connection(\cpP)$ is a tree,
    then $\neg\deadlock(\cpP)$.

Proof (Sketch).
  ~ Let us give the following definitions:

    - $\cpP\iotf\cpCC^n\cptm[\cpT_1\cptm,\cptm\dots\cptm,\cpT_n\cptm]$ (for some $n \geq 1$).
    - $T$ is the connection graph $\connection(\cpP)$.
    - $G$ is the dependency graph $\dependency(\cpP)$.
    - $\edges^C[G]$ are the cut-edges in $G$, i.e., $\{\edge{\cpx}{\cpx'}\vert\{\cpx,\cpx'\}\in\dn(\cpCC)\}$.
    - $\edges^L[G]$ are the link-edges in $G$, i.e., $\bigcup_{1 \leq i \leq n}\{\edge\cpx\cpy\vert\cpT_i=\cpLink\cpx\cpy\}$.
    - $G{/}_{\!\arcs[G]}$ is the quotient of $G$ by its arcs $\arcs[G]$.

    The result follows from the following facts:

    1.  Any essentially directed path $p$ in $G$ must alternate cut-edges with arcs or link-edges.
        (Cut-edges connect endpoints in different threads. Link-edges and arcs connect endpoints in the same thread. By definition, each ready link only generates a single link-edge, and every other thread only generates arcs out of the same vertex.)
    2.  There exists a surjective graph homomorphism from $G{/}_{\arcs[G]}$ to $T$, which preserves cut-edges and contracts the vertices connected by each link-edge, defined as:
        $$
          f
          \defeq
          \{
            \cptm{X}\mapsto\cpT_i
            \vert
            1 \leq i \leq n
            \land
            \cptm{X}\subseteq\fn(\cpT_i)
          \}
        $$

    Assume $\cpP$ is in deadlock, i.e., there exists an essential cycle $c$ in $G$.

    There are three cases:

    - If $c$ contains no cut-edges, then, by fact (1), $c$ must be a loop.  
      By definition, $G$ contains no loops.
    - If $c$ contains one cut-edge, then, by fact (1), $T$ must contain a loop.  
      By definition, $T$ contains no loops.
    - Otherwise, by fact (2), $T$ contains a cycle.  
      This contradicts our premise.

Connection graphs are not merely a tool for converting processes to right-branching form and proving deadlock freedom.
They are a full-fledged alternative representation for processes, with the interesting property that they represent the maximum configuration context of a process without any spurious ambiguity.
Processes with equivalent maximum configuration contexts have *equal* connection graphs.
Moreover, the correspondence works both ways!
Processes with equal connection graphs have equivalent maximum configuration contexts.

Proposition {#cp-connection-graph-equiv-lps}.
  ~ If $\cpP$ is well-typed,
    then $\cpP\cpEquivLPS\cpQ\iff\connection(\cpP)=\connection(\cpQ)$.

```include
proofs/cp-connection-graph-equiv-lps.md
```

In conclusion, connection graphs are a unique representation for maximum configuration contexts that exactly capture link-preserving shallow structural congruence.
That sounds awfully familiar.
The canonical representation for Classical Linear Logic is *proof nets* [see @Girard87:ll, p. 28]. Proof nets are a graphical representation of proofs described as "classical natural deduction" which equate proofs up to various commutations.
Connection graphs are *exactly* shallow proof nets that equate proofs up to the commutations \Rule{C-SC-CutComm} and \Rule{C-SC-CutAssoc}!

The translation from connection graphs to shallow proof nets is simple.
Consider the connection graph for example (2) as presented above:
$$
  \begin{tikzpicture}
    \node (P1) at (-3, 0) {$\cpClose\cpy.0$};
    \node (P2) at (-1, 0) {$\cpWait{\cpy'}.\cpClose\cpx.0$};
    \node (P3) at ( 1, 0) {$\cpClose\cpz.0$};
    \node (P4) at ( 3, 0) {$\cpWait{\cpz'}.\cpWait{\cpx'}.\cpP$};
    \draw (P1) to [out=-45,in= 225] node [below] {$(\cpy,\cpy')$} (P2);
    \draw (P3) to [out=-45,in= 225] node [below] {$(\cpz,\cpz')$} (P4);
    \draw (P2) to [out= 45,in=-225] node [above] {$(\cpx,\cpx')$} (P4);
  \end{tikzpicture}
$$
To create the corresponding shallow proof net, convert each process to its corresponding sequent calculus proof, convert each *edge* of the connection graph to a cut node, and connect each port of the cut node to the corresponding proposition in the sequent calculus proofs.
(The vertical dots are the sequent calculus proof corresponding to the process $\cpP$.)
$$
  \begin{tikzpicture}
    \node (Cy1)                {$\cpOne$};
    \node (Cy2) [right=of Cy1] {$\cpBot$};
    \node (Cx1) [right=of Cy2] {$\cpOne$};
    \node (Cx2) [right=of Cx1] {$\cpBot$};
    \node (Cz2) [right=of Cx2] {$\cpBot$};
    \node (Cz1) [right=of Cz2] {$\cpOne$};
    \draw (Cx1.south west) -- (Cx2.south east)
      node [midway,below] {\RuleName{Cut}};
    \draw (Cy1.south west) -- (Cy2.south east)
      node [midway,below] {\RuleName{Cut}};
    \draw (Cz2.south west) -- (Cz1.south east)
      node [midway,below] {\RuleName{Cut}};
    \node (Cy1A) [above=1em of Cy1] {$\cpy$};
    \node (Cy2A) [above=1em of Cy2] {$\cpy'$};
    \node (Cx1A) [above=1em of Cx1] {$\cpx$};
    \node (Cx2A) [above=1em of Cx2] {$\cpx'$};
    \node (Cz2A) [above=1em of Cz2] {$\cpz'$};
    \node (Cz1A) [above=1em of Cz1] {$\cpz$};
    \path (Cy2A) -- (Cx1A) node (Cy2AmCx1A) [midway] {};
    \path (Cx2A) -- (Cz2A) node (Cx2AmCz2A) [midway] {};
    \node (P1)
    [left=of Cy1A]
    {\ensuremath{\rotatebox{90}{
      \AXC{}
      \UIC{$\cpClose\cpy.\cpZ\cpSeq\cpy:\cpOne$}
      \DP
    }}};
    \node (P4)
    [right=of Cz1A]
    {\ensuremath{\rotatebox{-90}{
      \AXC{}
      \UIC{$\cpClose\cpz.\cpZ\cpSeq\cpz:\cpOne$}
      \DP
    }}};
    \node (P2)
    [above=of Cy2AmCx1A,xshift=-2.5em]
    {\ensuremath{
      \AXC{$\vphantom{\cpP\cpSeq\cpGG}$}
      \UIC{$\cpClose\cpx.0\cpSeq\cpx:\cpOne$}
      \UIC{$\cpWait{\cpy'}.\cpClose\cpx.0\cpSeq\cpy':\cpBot,\cpx:\cpOne$}
      \DP
    }};
    \node (P3)
    [above=of Cx2AmCz2A,xshift=2.5em,yshift=1pt]
    {\ensuremath{
      \AXC{$\vdots$}\noLine
      \UIC{$\cpP\cpSeq\cpGG$}
      \UIC{$\cpWait{\cpx'}.\cpP\cpSeq\cpGG,\cpx':\cpBot$}
      \UIC{$\cpWait{\cpz'}.\cpWait{\cpx'}.\cpP\cpSeq\cpGG,\cpz':\cpBot,\cpx':\cpBot$}
      \DP
    }};
    \draw (Cy1) -- (Cy1A) -- (P1);
    \draw (Cz1) -- (Cz1A) -- (P4);
    \draw (Cy2) -- (Cy2A) -- (P2);
    \draw (Cx1) -- (Cx1A) -- (P2);
    \draw (Cx2) -- (Cx2A) -- (P3);
    \draw (Cz2) -- (Cz2A) -- (P3);
    \draw (Cz1) -- (Cz1A) -- (P4);
  \end{tikzpicture}
$$
The correspondence between connection graphs is well-known, e.g., @HondaL10:pn discuss this relation between structural congruence and proof nets in the context of polarised linear logic.
For CP, this correspondence opens up several interesting avenues for research.
For instance, we could leverage the correspondence to construct a type-checking algorithm for CP's connection graphs, rather than its process terms, based on the various correctness criteria for proof nets, such as @Girard87:ll's long trip criterion [@Girard87:ll, p. 30], the Danos-Regnier criterion [@DanosR89:pn], or @Mellies04:ribbon's ribbon criterion [@Mellies04:ribbon].
Moreover, it would be interesting to examine the proof structures that correspond to stronger versions of structural congruence, such as the shallow or deep congruences defined in this chapter, or strong bisimulation with delayed actions, as defined, e.g., by @KokkeMP19:dhcp [DHCP], which I suspect has a much tighter correspondence to proof nets.
