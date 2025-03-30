# Priority Inference {#pcp-priority-inference}

```{=latex}
\shset0%
\ppset1%
\ptset2%
```

In this section, I introduce priority inference for PCP.
Usually, a type inference system is presented as an algorithmic variant of the type system, whose derivations take terms as input and produce types as output.
Such type inference derivations are compositional, and produce locally correct information.

Deadlock freedom is a global property.
While CP and HCP guarantee deadlock freedom locally and compositionally, they do so by enforcing a much stronger and more restrictive invariant: the tree and forest structure of the connection graph.
In essence, PCP guarantees global deadlock freedom simply by checking it, *globally*.
Consequently, PCP's typing derivations are not meaningfully compositional.
Priorities witness global deadlock freedom, and, as such, capture global information.
Morally, if you connect two PCP processes, you must re-check if they are deadlock free.
(Practically, you can connect two PCP processes if and only if you already chose their priorities to witness the global deadlock freedom of the resulting process.)
As typing derivations are not compositional, there is little hope for a local, compositional priority inference system for PCP.
Instead, I structure priority inference as a two-stage process, which factors out the local, compositional portion into the first stage, and defers the global check to the second stage.

Priority inference is structured as follows:

1.  I define pre-processes and pre-types, which replace priorities with priority metavariables, and pre-typing, which ensures communication safety, but not deadlock freedom.
    Crucially, pre-typing is local and compositional.
2.  I prove that a pre-process is a process only if it is deadlock-free.

In this section, processes, types, and priorities are printed in $\tmprimaryname$, $\typrimaryname$, and $\prprimaryname$, respectively, and all three are rendered in a sans-serif font, whereas pre-processes, pre-types, and priority metavariables are printed in $\tmsecondaryname$, $\tysecondaryname$, and $\prsecondaryname$, respectively, and all three are rendered in an italicised font with serif.
The pre-typing sequent is marked by a subscript "$\ptabbrev$".

*Priority metavariables* are names, whereas priorities are natural numbers.
Let $\pto$, $\ptp$, and $\ptq$ range over priority metavariables.
Priority metavariables should be unique, i.e., no priority metavariable should occur more than once in a pre-process, pre-type, pre-typing environment, or pre-typing derivation.
I use Barendregt's convention for priority metavariables, and assume this uniqueness, rather than explicitly renaming duplicate priority metavariables.

*Pre-processes* are the same as processes, but annotated by pre-types rather than types.
Let $\ptx$, $\pty$, $\ptz$, and $\ptw$ range over endpoint names, and let $\ptP$, $\ptQ$, and $\ptR$ range over pre-processes.
Binding for pre-processes is the same as binding for processes.

*Pre-types* are the same as types, but annotated by priority metavariables rather than priorities. Pre-types are well-formed if and only if each connective is annotated with a distinct priority metavariable.
Let $\ptA$, $\ptB$, $\ptC$, and $\ptD$ as well as $\ptA'$, $\ptB'$, $\ptC'$, and $\ptD'$ range over pre-types.
Following our convention for endpoints, I write $\ptA$ and $\ptA'$ to imply that the types associated with these pre-types are dual, which I define shortly.
The set of priority metavariables in a pre-type $\ptA$, written $\fp(\ptA)$, is the set of all priority metavariables that occur in the pre-type $\ptA$.
Two pre-types are *equivalent*, written $\ptA\pttyEquiv\ptB$, if they are equal up to priority metavariables.
$$
\begin{array}{l@{\;\pttyEquiv\;}l@{\;\iff\;}l@{\qquad}l@{\;\pttyEquiv\;}l}
    \ptA_1\ptTens^\ptp\ptA_2
  & \ptB_1\ptTens^\ptq\ptB_2
  & \ptA_1\pttyEquiv\ptB_1\land\ptA_2\pttyEquiv\ptB_2
  &
    \ptOne^\ptp
  & \ptOne^\ptq
\\
    \ptA_1\ptParr^\ptp\ptA_2
  & \ptB_1\ptParr^\ptq\ptB_2
  & \ptA_1\pttyEquiv\ptB_1\land\ptA_2\pttyEquiv\ptB_2
  &
    \ptBot^\ptp
  & \ptBot^\ptq
\\
    \ptA_1\ptPlus^\ptp\ptA_2
  & \ptB_1\ptPlus^\ptq\ptB_2
  & \ptA_1\pttyEquiv\ptB_1\land\ptA_2\pttyEquiv\ptB_2
  &
    \ptNil^\ptp
  & \ptNil^\ptq
\\
    \ptA_1\ptWith^\ptp\ptA_2
  & \ptB_1\ptWith^\ptq\ptB_2
  & \ptA_1\pttyEquiv\ptB_1\land\ptA_2\pttyEquiv\ptB_2
  &
    \ptTop^\ptp
  & \ptTop^\ptq
\end{array}
$$
Two pre-types are dual, written $\ptA\pttyDual\ptA'$, if they are dual up to priority metavariables.
$$
\begin{array}{l@{\;\pttyDual\;}l@{\;\iff\;}l@{\qquad}l@{\;\pttyDual\;}l}
    \ptA_1\ptTens^\ptp\ptA_2
  & \ptA'_1\ptParr^\ptq\ptA'_2
  & \ptA_1\pttyDual\ptA'_1\land\ptA_2\pttyDual\ptA'_2
  &
    \ptOne^\ptp
  & \ptBot^\ptq
\\
    \ptA_1\ptParr^\ptp\ptA_2
  & \ptA'_1\ptTens^\ptq\ptA'_2
  & \ptA_1\pttyDual\ptA'_1\land\ptA_2\pttyDual\ptA'_2
  &
    \ptBot^\ptp
  & \ptOne^\ptq
\\
    \ptA_1\ptPlus^\ptp\ptA_2
  & \ptA'_1\ptWith^\ptq\ptA'_2
  & \ptA_1\pttyDual\ptA'_1\land\ptA_2\pttyDual\ptA'_2
  &
    \ptNil^\ptp
  & \ptTop^\ptq
\\
    \ptA_1\ptWith^\ptp\ptA_2
  & \ptA'_1\ptPlus^\ptq\ptA'_2
  & \ptA_1\pttyDual\ptA'_1\land\ptA_2\pttyDual\ptA'_2
  &
    \ptTop^\ptp
  & \ptNil^\ptq
\end{array}
$$

*Pre-typing environments* are the same as typing environments, but contain pre-type assignments, rather than type assignments.
Let $\ptGG$ and $\ptGD$ range over pre-typing environments.
Pre-typing environments are well-formed if and only if the priority metavariables in all pre-types are distinct.
The set of priority metavariables in a pre-typing environment $\ptGG$, written $\fp(\ptGG)$, is the set of priority metavariables that occur in all the pre-types in the pre-typing environment $\ptGG$.

*Priority graph* (ranged over by $\ptG$, $\ptH$) are mixed graphs whose vertices are priority metavariables.
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
- The *empty graph* with vertices $V$, written $\emptyGraphOf{V}$, is the graph consisting of vertices $V$, with no edges or arcs.
- The *graph union* of $G_1$ and $G_2$, denoted by $G_1 \cup G_2$, is defined by, for each projection, taking the union of the projection of $G_1$ and $G_2$, e.g., $\vertices[G_1 \cup G_2]\defeq\vertices[G_1]\cup\vertices[G_2]$, $\edges[G_1 \cup G_2]\defeq\edges[G_1]\cup\edges[G_2]$, etc.
- The *directed rooting* of $G$ in $v$, written $v \rooting G$, is the graph formed by adding the vertex $v$ and adding an arc from $v$ to every other vertex of $G$, i.e., $\vertices[{v}\rooting{G}]\defeq\{v\}\cup\vertices[G]$ and $\arcs[{v}\rooting{G}]\defeq\{\arc{v}{u}\vert{u}\in\vertices[G]\}\cup\arcs[G]$.
  Directed rooting preserves the remaining projections, e.g., $\edges[{v}\rooting{G}]\defeq\edges[G]$.

The *priority tree* of a pre-type, written $\prTree{\ptA}$, is the priority graph whose vertices are the priority metavariables in $\ptA$, with arcs flowing along the structure of the type.
$$
\begin{array}{l@{\;\defeq\;}l}
  \prTree{\ptA\ptTens^{\pto}\ptB},
  \prTree{\ptA\ptParr^{\pto}\ptB},
  \prTree{\ptA\ptPlus^{\pto}\ptB},
  \prTree{\ptA\ptWith^{\pto}\ptB}
  & \pto\rooting
    (
      \prTree{\ptA}
      \cup
      \prTree{\ptB}
    )
  \\
  \prTree{\ptOne^{\pto}},
  \prTree{\ptBot^{\pto}},
  \prTree{\ptNil^{\pto}},
  \prTree{\ptTop^{\pto}}
  & \pto
\end{array}
$$
The *priority link* of two pre-types, written $\ptBiPartite{\ptA}{\ptA'}$, is the bipartite priority graph with edges between the corresponding priority metavariables in $\ptA$ and $\ptA'$.
The priority link is defined if and only if $\ptA\pttyDual\ptA'$.
$$
\begin{array}{l@{\;\defeq\;}l}
  \ptBiPartite{\ptA\ptTens^{\ptp}\ptB}{\ptA'\ptParr^{\ptq}\ptB'},
  \ptBiPartite{\ptA\ptParr^{\ptp}\ptB}{\ptA'\ptTens^{\ptq}\ptB'},
  \ptBiPartite{\ptA\ptPlus^{\ptp}\ptB}{\ptA'\ptWith^{\ptq}\ptB'},
  \ptBiPartite{\ptA\ptWith^{\ptp}\ptB}{\ptA'\ptPlus^{\ptq}\ptB'}
  & \edge{\ptp}{\ptq}
    \cup
    \ptBiPartite{\ptA}{\ptA'}
    \cup
    \ptBiPartite{\ptB}{\ptB'}
  \\
  \ptBiPartite{\ptOne^{\ptp}}{\ptBot^{\ptq}},
  \ptBiPartite{\ptBot^{\ptp}}{\ptOne^{\ptq}},
  \ptBiPartite{\ptNil^{\ptp}}{\ptTop^{\ptq}},
  \ptBiPartite{\ptTop^{\ptp}}{\ptNil^{\ptq}}
  & \edge{\ptp}{\ptq}
\end{array}
$$
The *priority link-tree* of two pre-types, written $\ptLinkTree{\ptA}{\ptA'}$, is the union of the two priority trees for $\ptA$ and $\ptA'$ and the priority link for $\ptA$ and $\ptA'$.
$$
  \ptLinkTree{\ptA}{\ptA'}
  \defeq
  \prTree{\ptA}
  \cup
  \prTree{\ptA'}
  \cup
  \ptBiPartite{\ptA}{\ptA'}
$$
To illustrate these definitions, let us look at an example.
Let $\ptA$ and $\ptA'$ be the pre-types $\ptOne^{\ptp_1}\ptTens^{\pto_1}\ptOne^{\ptq_1}$ and $\ptBot^{\ptp_1}\ptParr^{\pto_2}\ptBot^{\ptq_2}$, respectively.
The priority tree $\prTree{\ptA}$, priority link $\ptBiPartite{\ptA}{\ptA'}$, and priority link-tree $\ptLinkTree{\ptA}{\ptA'}$ are as follows:
$$
\prTree{\ptA}=
\vcenter{\hbox{%
\begin{tikzpicture}
\node (o1) at (0,0) {$\pto_1$};
\node (q1) [above=1ex of o1,xshift=+1em] {$\ptq_1$};
\node (p1) [above=1ex of q1,xshift=-2em] {$\ptp_1$};
\draw [->] (o1) -- (p1);
\draw [->] (o1) -- (q1);
\end{tikzpicture}}}
\qquad
\ptBiPartite{\ptA}{\ptA'}=
\vcenter{\hbox{%
\begin{tikzpicture}
\node (o1) at (0,0) {$\pto_1$};
\node (q1) [above=1ex of o1,xshift=+1em] {$\ptq_1$};
\node (p1) [above=1ex of q1,xshift=-2em] {$\ptp_1$};
\node (o2) [right=3em of o1] {$\pto_2$};
\node (q2) [above=1ex of o2,xshift=+1em] {$\ptq_2$};
\node (p2) [above=1ex of q2,xshift=-2em] {$\ptp_2$};
\draw (o1) -- (o2);
\draw (p1) -- (p2);
\draw (q1) -- (q2);
\end{tikzpicture}}}
\qquad
\ptLinkTree{\ptA}{\ptA'}=
\vcenter{\hbox{%
\begin{tikzpicture}
\node (o1) at (0,0) {$\pto_1$};
\node (q1) [above=1ex of o1,xshift=+1em] {$\ptq_1$};
\node (p1) [above=1ex of q1,xshift=-2em] {$\ptp_1$};
\node (o2) [right=3em of o1] {$\pto_2$};
\node (q2) [above=1ex of o2,xshift=+1em] {$\ptq_2$};
\node (p2) [above=1ex of q2,xshift=-2em] {$\ptp_2$};
\draw [->] (o1) -- (p1);
\draw [->] (o1) -- (q1);
\draw [->] (o2) -- (p2);
\draw [->] (o2) -- (q2);
\draw (o1) -- (o2);
\draw (p1) -- (p2);
\draw (q1) -- (q2);
\end{tikzpicture}}}
$$
The pre-typing judgment $\ptP\ptSeq\ptGG\ptGives\ptG$ means that $\ptP$ is well-typed if, for each pre-type assignment $\ptx:\ptA$ in $\ptGG$, exactly one pre-process in $\ptP$ uses the endpoint $\ptx$ according to the session pre-type $\ptA$.
The priority graph $\ptG$ is an output of the pre-typing derivation.

Definition (Pre-Typing) {#pcp-pre-typing}.
  ~ A pre-process $\ptP$ is well-typed under some pre-typing environment $\ptGG$ if there exists a pre-typing derivation with conclusion $\ptP\ptSeq\ptGG\ptGives\ptG$ for some $\ptG$ that uses the pre-typing rules in @figure:pcp-pre-typing.

![Pre-Typing Rules for Priority CP](figures/pre-typing.tex?as=webp){#figure:pcp-pre-typing}

A *priority substitution* assigns a priority to each priority metavariable.
Let $\pts$ range over priority substitutions.
A priority substitution translates pre-processes to processes, pre-types to types, and pre-typing environments to typing environments, by pointwise applying the priority substitution to each priority metavariable.

Priority inference is *sound*.
If the priority graph produced by the pre-typing derivation is essentially acyclic, there exists some priority substitution such that the resulting process is typeable in PCP.

Proposition (Soundness) {#pcp-priority-inference-soundness}.
  ~ If $\ptP\ptSeq\ptGG\ptGives\ptG$ and $\ptG$ is essentially acyclic, then there exists some priority substitution $\pts$ such that $\pts(\ptP)\ppSeq\pts(\ptGG)$.

```include
proofs/pcp-priority-inference-soundness.md
```

Priority erasure replaces priority annotations with fresh priority metavariables, and translates processes to pre-processes, types to pre-types, and typing environments to pre-typing environments, by pointwise applying the priority erasure to each priority metavariable.

Definition (Priority Erasure) {#pcp-priority-erasure}.
  ~ *Priority erasure*, written $\PtoPI(\cdot)$, maps processes to pre-processes, types to pre-types, typing environments to pre-typing environments, and typing derivations to pre-typing derivations, by replacing all priorities with fresh priority metavariables.

Priority inference satisfies *completeness*.
If the process is well-typed in PCP, then the priority graph produced by the pre-typing derivation is essentially acyclic, and the order of the original priority assignment respects reachability in the priority graph.

Proposition (Completeness) {#pcp-priority-inference-completeness}.
  ~ If $\ppP\ppSeq\ppGG$, then $\PtoPI(\ppP)\ptSeq\PtoPI(\ppGG)\ptGives\ptG$ such that the produced priority graph $\ptG$ is essentially acyclic, and, if $\pts$ is the priority substitution such that $\pts(\ptP)=\ppP$ and $\pts(\ptGG)=\ppGG$, then $\ptp\reaches[\ptG]\ptq\implies\pts(\ptp)<\pts(\ptq)$.

```include
proofs/pcp-priority-inference-completeness.md
```
