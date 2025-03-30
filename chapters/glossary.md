# Glossary

## Graph Theory {#glossary-graphs}

In this section, I introduce various graph theoretic notions that are used throughout the thesis.
I need undirected labelled graphs when discussing connection graphs in @cp-connection-and-right-branching-form and @hcp-connection-and-disentanglement, mixed graphs when discussing dependency graphs and priority graphs in @cp-duality-dependency-and-deadlock, @hcp-duality-dependency-and-deadlock, and @pcp-priority-inference, and undirected multigraphs when discussing abstract process structure in \hyperlink{paper:separating-sessions-smoothly.8}{I.3.1}.

Commonly, graphs are introduced as tuples of their components.
However, since I require undirected, directed, and mixed graphs, I intend to save some ink by defining graphs in terms of their projections.

In the following, if some projection is undefined, it is the empty set, e.g., for an undirected graph, the set of directed arcs is empty, and, consequently, directed reachability is the empty relation.

- A *graph* (ranged over by $G$) has a set of vertices, denoted by $\vertices[G]$ (ranged over by $u$, $v$).

- In an abuse of notation, I write $u$ for the singleton graph consisting of the single vertex $u$, i.e., $\vertices[u]\defeq\{u\}$.

- Two graphs $G_1$ and $G_2$ are *disjoint* if and only if their sets of vertices are disjoint, i.e., $\vertices[G_1]\cap\vertices[G_2]=\emptyset$.

- An *edge* (ranged over by $e$) is an unordered pair of vertices, denoted by juxtaposition, i.e., $\edge{u}{v}\defeq\{u,v\}$.

- An *edge-loop* or *loop* is an edge $\edge{u}{u}$ that connects a vertex to itself.

- In an abuse of notation, I write $\edge{u}{v}$ for the graph consisting of the single edge $\edge{u}{v}$, i.e., $\vertices[\edge{u}{v}]\defeq\{u,v\}$ and $\edges[\edge{u}{v}]\defeq\{\edge{u}{v}\}$.

- An *undirected graph* $G$ is a graph with a set of undirected edges with no edge-loops, denoted by $\edges[G]$, i.e., $\edges[G]\subseteq\{\edge{u}{v} \vert u,v\in\vertices[G] \land u \neq v\}$.

- An *arc* (ranged over by $a$) is an ordered pair of vertices, denoted by juxtaposition overset with an arrow to indicate the direction, i.e., $\arc{u}{v}\defeq(u,v)$.

- An *arc-loop* or *loop* is an arc $\arc{u}{u}$ that connects a vertex to itself.

- In an abuse of notation, I write $\arc{u}{v}$ for the graph consisting of the single arc $\arc{u}{v}$, i.e., $\vertices[\arc{u}{v}]\defeq\{u,v\}$ and $\arcs[\arc{u}{v}]\defeq\{\arc{u}{v}\}$.

- A *directed graph* $G$ is a graph with a set of directed arcs with no arc-loops, denoted by $\arcs[G]$, i.e., $\arcs[G]\subseteq\{\arc{u}{v} \vert u,v\in\vertices[G] \land u \neq v\}$.

- A *mixed graph* $G$ is a graph with a set of undirected edges with no edge-loops, as above, and a set of directed arcs with no arc-loops, as above.

- An *edge-labelled graph* $G$ is a graph with a set of edges, as above, a set of edge labels, denoted by $\edgeLabels[G]$, and an edge-labelling function, denoted by $\edgeLabelling[G]$, where $\edgeLabelling[G]:\edges[G]\to\edgeLabels[G]$.
  The definitions for $\edges[G]$ and $\edgeLabels[G]$ may be omitted, since $\edges[G]\defeq\dom(\edgeLabelling[G])$ and $\edgeLabels[G]\defeq\cod(\edgeLabelling[G])$.

- An *undirected multigraph* $G$ is a graph with a set of edge names, denoted by $\edgeNames[G]$, and an edge-connection function, denoted by $\edgeConnections[G]$, where $\edgeConnections[G]:\edgeNames[G]\to\{\edge{u}{v} \vert u,v\in\vertices[G]\}$.
  The set of edges $\edges[G]$ is defined as the union of all edges, i.e., $\edges[G]\defeq\bigcup_{e\in\edgeNames[G]}\edgeConnections[G](e)$.
  An undirected multigraph is similar to an undirected edge-labelled graph but differs in that it permits edge-loops and permits multiple edges between any two vertices.

- The *empty graph* with vertices $V$, written $\emptyGraphOf{V}$, is the graph consisting of vertices $V$ with no edges or arcs, i.e, $\vertices[\emptyGraphOf{V}]\defeq{V}$, $\edges[\emptyGraphOf{V}]\defeq\emptyset$, and $\arcs[\emptyGraphOf{V}]\defeq\emptyset$.

- The *graph union* of $G_1$ and $G_2$, denoted by $G_1 \cup G_2$, is defined by, for each projection, taking the union of the projection of $G_1$ and $G_2$, e.g., $\vertices[G_1 \cup G_2]\defeq\vertices[G_1]\cup\vertices[G_2]$, and $\edges[G_1 \cup G_2]\defeq\edges[G_1]\cup\edges[G_2]$, etc.

- The *directed rooting* of $G$ in $v$, written $v \rooting G$, is the graph formed by adding the vertex $v$ and adding an arc from $v$ to every other vertex of $G$, i.e., $\vertices[{v}\rooting{G}]\defeq\{v\}\cup\vertices[G]$ and $\arcs[{v}\rooting{G}]\defeq\{\arc{v}{u}\vert{u}\in\vertices[G]\}\cup\arcs[G]$.
  Directed rooting preserves the remaining projections, e.g., $\edges[{v}\rooting{G}]\defeq\edges[G]$.

- For any graph $G$ with vertices $u,v\in\vertices[G]$, $u$ is *adjacent* to $v$ if and only if there exists some edge $\edge{u}{v}\in\edges[G]$ or some arc $\arc{u}{v}\in\arcs[G]$.

- For any graph $G$, a *walk* (ranged over by $w$) is a sequence of pairwise adjacent vertices.
  Equivalently, a walk is a sequence of edges and arcs that join a sequence of vertices, where all arcs have the same direction.

- A walk $w$ *visits* a vertex $v$ if and only if $v$ occurs in the walk, i.e., if and only if $w_i=v$ for some $i\in\mathbb{N}$.

- A walk is *closed* if and only if its first and last vertex are the same.

- A walk is *undirected* if and only if it contains only edges.

- A walk is *directed* if and only if it contains only arcs.

- A walk is *essentially directed* if and only if it contains at least one arc.

- A *path* (ranged over by $p$) is a walk without repeated vertices.

- A *cycle* (ranged over by $c$) is a closed path.

- A graph is *acyclic* if and only if the undirected graph formed by replacing all arcs in with edges contains no cycles.

- A graph is *essentially acyclic* if and only if it contains no essentially directed cycles.

- A graph is *strongly connected* if and only if there exists a path between any two distinct vertices.

- A graph is *connected* if and only if the undirected graph formed by replacing all arcs in with edges is strongly connected.
  (Commonly, connected is also referred to as *weakly connected*.)

- For any graph $G$, the *subgraph* of $G$ induced by $U$, denoted by $G[U]$, where $U\subseteq\vertices[G]$, is the graph constructed by taking the subset of vertices $U$ and restricting $G$'s projections to vertices in $U$.
<!-- according to their correctness criteria, e.g., $\edges[G[U]]$ is $\edges[G]\cap\{\edge{u}{v}\in\vert{u},{v}\in{U}\land{u}\neq{v}\}$. -->

- For any graph $G$, a *strongly connected component* of $G$ (ranged over by $C$) is a maximal strongly connected subgraph of $G$.

- For any graph $G$, a *component* of $G$ (ranged over by $C$) is a maximal connected subgraph of $G$.

- A *tree* (ranged over by $T$) is a graph that is connected and acyclic.

- A *forest* (ranged over by $F$) is a graph whose components are trees.

- For any graph $G$, *undirected reachability*, denoted by $\dual[G]$, is the equivalence closure over $\edges[G]$, i.e., $u \dual[G] v$ holds if $u = v$ or there exists an undirected path from $u$ to $v$.
  (If $\edges[G]$ is undefined, undirected reachability is the smallest reflexive relation over $\vertices[G]$.)

- For any graph $G$, *essentially directed reachability*, denoted by $\reaches[G]$, is the transitive closure over $\arcs[G]$ quotiented by $\dual[G]$, i.e., $u \reaches[G] v$ holds if and only if there exists an essentially directed path from $u$ to $v$.
  (If $\arcs[G]$ is undefined, essentially directed reachability is the empty relation.)

- For any graph $G$, *reachability*, denoted by $\reacheseq[G]$, is the union of undirected and essentially directed reachability, i.e., $u \reacheseq[G] v$ holds if and only if there exists an undirected or essentially directed path from $u$ to $v$.

- For any graph $G$, its *sources* and *sinks*, written $\sources(G)$ and $\sinks(G)$, respectively, are the sets of minimals and maximals of essentially directed reachability, respectively, i.e., $\sources(G)\defeq\{u\in\vertices[G]\vert\nexists{v}.v\reaches[G]u\}$ and $\sinks(G)\defeq\{u\in\vertices[G]\vert\nexists{v}.u\reaches[G]v\}$.

<!-- - For pair of graphs $G$ and $G'$, $G'$ is a *prefix graph* of $G$, written if $G'$ is a subgraph of $G$, contains all of its sources, and contains all edges and arcs from the sources to the other vertices in $G'$, i.e., $\vertices[G']\subseteq\vertices[G]$, and $\sources(G)\subseteq\vertices[G']$, and $\{\edge{u}{v}\in\edges[G]\vert{u}\in\sources(G)\land{v}\in\vertices[G']\}\subseteq\edges[G']$, and $\{\arc{u}{v}\in\arcs[G]\vert{u}\in\sources(G)\land{v}\in\vertices[G']\}\subseteq\arcs[G']$. -->

Lemma {#tree-connection}.
  ~ If $T_1$ and $T_2$ are disjoint trees and $u$ and $v$ are vertices in $T_1$ and $T_2$, respectively, then the graph $G$ formed by connecting $T_1$ and $T_2$ with the edge $\edge{u}{v}$ is a tree.

Lemma {#mixed-graph-connection}.
  ~ If $G_1$ and $G_2$ are disjoint essentially acyclic mixed graphs, $(u_1, \dots, u_n)$ and $(v_1, \dots, v_n)$ are vertices in $G_1$ and $G_2$, respectively, such that $u_1 \reaches\dots\reaches u_n$ and $v_1 \reaches\dots\reaches v_n$, respectively, then the mixed graph $G$ formed by connecting $G_1$ and $G_2$ with the edges $\edge{u_1}{v_1}, \dots, \edge{u_n}{v_n}$ is essentially acyclic.

Proof.
  ~ By contradiction. Assume $c$ is an essentially directed cycle in $G$.

    - If $c$ visits no vertex in $G_2$, then $c$ is an essentially directed cycle in $G_1$.

    - If $c$ visits no vertex in $G_1$, then $c$ is an essentially directed cycle in $G_2$.

    - Otherwise, $c$ must visit some vertex $u$ in $G_1$ and some vertex $v$ in $G_2$.

      As $c$ is an essentially directed cycle, there must be distinct paths $p_{uv} = (u, \dots, v)$ and $p_{vu} = (v, \dots, u)$.
      At least one of $p_{uv}$ and $p_{vu}$ must be essentially directed.

      As $G_1$ and $G_2$ are disjoint, $p_{uv}$ and $p_{vu}$ must each contain at least one of the edges $\edge{u_1}{v_1}, \dots, \edge{u_n}{v_n}$. Hence, there must be paths $p_{u u_i} = (u, \dots, u_i)$, $p_{v_i v} = (v_i, \dots, v)$, $p_{v v_j} = (v, \dots, v_j)$, and $p_{u_j u} = (u_j, \dots, u)$ for some $1 \leq i,j \leq n$.
      At least one of $p_{u u_i}$, $p_{u_j u}$, $p_{v v_i}$, and $p_{v_j v}$ must be essentially directed.

      - If $i = j$, then either $c$ contains an arc in $G_1$ and $p_{u u_i}p_{u_j u}$ is an essentially directed cycle in $G_1$, or $c$ contains an arc in $G_2$ and $p_{v_i v}p_{v v_j}$ is an essentially directed cycle in $G_2$.

      - If $i < j$, then $u_i \reaches u_j$ and $v_i \reaches v_j$. There must be essentially directed paths $p_{u_i u_j} = (u_i, \dots, u_j)$ in $G_1$ and $p_{v_i v_j} = (v_i, \dots, v_j)$ in $G_2$, and $p_{u u_i} p_{u_i u_j} p_{u_j u}$ is an essentially directed cycle in $G_1$.

      - If $i > j$, then $u_j \reaches u_i$ and $v_j \reaches v_i$. There must be essentially directed paths $p_{u_j u_i} = (u_j, \dots, u_i)$ in $G_1$ and $p_{v_j v_i} = (v_j, \dots, v_i)$ in $G_2$, and $p_{v_i v} p_{v v_j} p_{v_j v_i}$ is an essentially directed cycle in $G_2$.

## Multisets

Definition (Multiset) {#multiset}.
  ~ A *multiset* is a variant of a set that allows multiple occurrences of each element.
    Formally, a multiset $\msX$ is a tuple $(X, \msm_X)$ where $X$ is the support set of the multiset, and $\msm_X$ is a function, giving each element its *multiplicity*, from $X$ to the class of nonzero cardinal numbers.
    I write multisets as lists of elements between "$\lbag$" and "$\rbag$", e.g., $\lbag a,b,b,b \rbag$.

    I define the following operations on multisets:
    $$
    \!\!
    \begin{array}{llrl}
    \text{Membership}
    & a \in^k \msX
    & \defeq
    & a \in X \land \msm_X(a) = k
    \\
    \text{Union}
    & \msX \cup \msY
    & \defeq
    & (X \cup Y, \max(\msm_X, \msm_Y))
    \\
    \text{Intersection}
    & \msX \cap \msY
    & \defeq
    & (X \cap Y, \min(\msm_X, \msm_Y))
    \\
    \text{Deletion}
    & \msX \setminus Y
    & \defeq
    & (X \setminus Y, \msm_X \domainminus Y)
    \\
    \text{Subtraction}
    & \msX - \msY
    & \defeq
    & (\{a \in X \cup Y \mid \msm_X(a) > \msm_Y(a)\}, \msm_X - \msm_Y)
    \\
    \text{Sum}
    & \msX + \msY
    & \defeq
    & (\msX \cup \msY, \msm_X + \msm_Y)
    \\
    \text{Product}
    & \msX \msY
    & \defeq
    & (\msX \cap \msY, \msm_X \msm_Y)
    \\
    \text{Symmetric Difference}
    & \msX \symdiff \msY
    & \defeq
    & (\msX - \msY) \cup (\msY - \msX)
    \end{array}
    $$

Definition (Domain Subtraction) {#domain-subtraction}.
  ~ *Domain subtraction*, $f \domainminus X$, is the operation that removes all elements in $X$ from the domain of the function $f$, i.e.,
  $f \domainminus X = a \mapsto f(a) \text{ if } a \notin X$.
