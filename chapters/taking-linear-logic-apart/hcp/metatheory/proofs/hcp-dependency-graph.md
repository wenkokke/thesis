Proof.
  ~ @summary
    By induction on the derivation of $\hpP\hpSeq\hpHG$.
    The case where $\hpP$ is ready follows by @lemma:hcp-dependency-graph-ready.
    The case where $\hpP\iotf\hpZ$ follows vacuously.
    The case where $\hpP\iotf\hpP_1\hpPar\hpP_2$ follows by taking the union of the induction hypotheses.
    The case where $\hpP\iotf\hpNew(\hpx\hpx')\hpP'$, is the interesting case.
    By typing, $\hpx$ and $\hpx'$ are in distinct typing environments
    By $f$, these typing environments correspond to distinct components of the dependency graph.
    By @lemma:mixed-graph-connection, connecting distinct components with a single edge preserves acyclicity.

    (For the full proof, see @hcp-omitted-proofs.)
  ~ @omitted
    The process $\hpP\iotf\hpCC^n[\hpT_1,\hptm\dots,\hpT_n]$ (for some $n \geq 0$).
    By induction on $\hpCC$ and inversion $\hpP$ and the derivation of $\hpP\hpSeq\hpHG$.

    There are four cases:

    - Case $\hpCC$ is of the form $\hpHole$.

      Let $G$ be $\dependency(\hpP)$.
      As $\hpCC$ is maximal, $\hpP$ is ready.
      By @lemma:hcp-dependency-graph-ready, $G$ is essentially acyclic and connected.
      As $\hpP$ is ready, $\hpHG$ is of the form $\hpGG$.
      Let $f$ be the function $\{\hpGG \mapsto G\}$.
      By @proposition:hcp-linearity, $\fn(\hpGG)=\fn(\hpP)$.
      By definition, $\vertices[G]=\fn(\hpP)$.
      Hence, $\fn(\hpGG)=\fn(f(\hpGG))$.

    - Case $\hpCC$ is of the form $\hpZ$.

      By definition, $\dependency(\hpP)$ is the null graph.
      By inversion on the derivation $\hpP\hpSeq\hpHG$, $\hpHG$ is of the form $\hpHOne$, i.e., there are no typing environments in $\hpHG$.
      Let $f$ be the empty function $\emptyset$, which vacuously preserves $\fn$.

    - Case $\hpCC$ is of the form $\hpNew(\hpx\hpx')\hpCC'$.

      By inversion, $\hpP$ is of the form $\hpNew(\hpx\hpx')\hpP'$ such that $\hpNew(\hpx\hpx')\hpP'\hpSeq\hpHG'\hpHTens\hpGG,\hpGD$ and $\hpP'\hpSeq\hpHG'\hpHTens\hpGG,\hpx:\hpA\hpHTens\hpGD,\hpx':\co\hpA$.

      Let $G$ be $\dependency(\hpP)$ and $G'$ be $\dependency(\hpP')$.

      By definition, $\vertices[G]=\vertices[G']$, $\edges[G]=\edges[G']\cup\{\edge{\hpx}{\hpx'}\}$, and $\arcs[G]=\arcs[G']$.

      By induction, $G'$ is essentially acyclic, and there is an isomorphism $f'$ between the components of $G'$ and the typing environments in $\hpHG'\hpHTens\hpGG,\hpx:\hpA\hpHTens\hpGD,\hpx':\co\hpA$ that preserves $\fn$.

      Let $C_1$ be $f'(\hpGG,\hpx:\hpA)$ and $C_2$ be $f'(\hpGD,\hpx':\co\hpA)$.

      By definition, $C_1$ and $C_2$ are disjoint and essentially acyclic.

      Let $C$ be the graph formed by connecting $C_1$ and $C_2$ with the edge $\edge{\hpx}{\hpx'}$.

      By definition, $C$ is connected and a component of $G$.

      By @lemma:mixed-graph-connection, $C$ and $G$ are essentially acyclic.

      Let $f$ be the function $\{\hpGG,\hpGD \mapsto C\} \cup f' \domainminus \{\hpGG,\hpx:\hpA, \hpGD,\hpx':\co\hpA\}$ (where $\domainminus$ is domain subtraction, see @definition:domain-subtraction).

      The function $f$ is an isomorphism that preserves $\fn$, by definition (for $\hpGG,\hpGD$) and by induction (for the typing environments in $\hpHG'$).

    - Case $\hpCC$ is of the form $\hpCC_1\hpPar\hpCC_2$.

      By inversion, $\hpP$ is of the form $\hpP_1\hpPar\hpP_2$ such that $\hpP_1\hpPar\hpP_2\hpSeq\hpHG_1\hpHTens\hpHG_2$, $\hpP_1\hpSeq\hpHG_1$, and $\hpP_2\hpSeq\hpHG_2$.

      Let $G$ be $\dependency(\hpP)$, $G_1$ be $\dependency(\hpP_1)$, and $G_2$ be $\dependency(\hpP_2)$.

      By definition, $\vertices[G]=\vertices[G_1]\cup\vertices[G_2]$, $\edges[G]=\edges[G_1]\cup\edges[G_2]$, and $\arcs[G]=\arcs[G_1]\cup\arcs[G_2]$.

      By induction, $G_1$ and $G_2$ are essentially acyclic, and there are isomorphisms $f_1$ and $f_2$ between the typing environments in $\hpHG_1$ and $\hpHG_2$, respectively, the components of $G_1$ and $G_2$, respectively, that preserve $\fn$.

      By \Rule{H-T-Par}, $G_1$ and $G_2$ are disjoint.
      Hence, $G$ is essentially acyclic.

      Let $f$ be the function $f_1 \cup f_2$.

      As union preserves the relevant properties of $f_1$ and $f_2$, $f$ is an isomorphism between the components of $G$ and the typing environments in $\hpHG$ that preserves $\fn$.
