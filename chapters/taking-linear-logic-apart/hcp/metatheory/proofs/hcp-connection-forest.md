Proof.
  ~ @summary
    By induction on the maximum configuration context of $\hpP$ and inversion on $\hpP$ and its typing derivation.
    The interesting case is for name restriction.
    The endpoints connected by the name restriction occur in different typing environment.
    Hence, by the isomorphism $f$, those endpoints occur in disjoint trees in the connection graph and, by @lemma:tree-connection, the connection graph for the result, formed by connecting those trees with the single edge arising from the name restriction, remains a forest.

    (For the full proof, see @hcp-omitted-proofs.)
  ~ @omitted
    The process $\hpP=\hpCC^n[\hpT_1,\hptm\dots,\hpT_n]$ (for some $n \geq 0$).

    By induction on $\hpCC$ and inversion $\hpP$ and the derivation of $\hpP\hpSeq\hpHG$.

    There are four cases:

    - Case $\hpCC$ is of the form $\hpHole$.

      Let $G$ be $\connection(\hpP)$.
      As $\hpCC$ is maximal, $\hpP$ is ready.
      By definition, $G$ is the singleton graph, which is a tree.
      As $\hpP$ is ready, $\hpHG$ is of the form $\hpGG$.
      Let $f$ be the function $\{\hpGG \mapsto G\}$.
      By @proposition:hcp-linearity, $\fn(\hpGG)=\fn(\hpP)$.
      By definition, $\vertices[G]=\{\hpP\}$.
      Hence, $\fn(\hpGG)=\fn(f(\hpGG))$.

    - Case $\hpCC$ is of the form $\hpZ$.

      By definition, $G$ is the null graph, which is a forest.
      By inversion on the derivation $\hpP\hpSeq\hpHG$, $\hpHG$ is of the form $\hpHOne$, i.e., there are no typing environments in $\hpHG$.
      Let $f$ be the empty function $\emptyset$, which vacuously preserves $\fn$.

    - Case $\hpCC$ is of the form $\hpNew(\hpx\hpx')\hpCC'$.

      By inversion, $\hpP$ is of the form $\hpNew(\hpx\hpx')\hpP'$ such that $\hpNew(\hpx\hpx')\hpP'\hpSeq\hpHG'\hpHTens\hpGG,\hpGD$ and $\hpP'\hpSeq\hpHG'\hpHTens\hpGG,\hpx:\hpA\hpHTens\hpGD,\hpx':\co\hpA$.

      Let $G$ be $\connection(\hpP)$ and $G'$ be $\connection(\hpP')$.

      By @proposition:hcp-linearity and @lemma:hcp-separation, there exist unique $\hpT_i,\hpT_j\in\vertices[G']$ such that $\hpx\in\fn(\hpT_i)$ and $\hpx'\in\fn(\hpT_j)$

      By definition, $\vertices[G]=\vertices[G']$ and $\edgeLabelling[G]=\edgeLabelling[G']\cup\{\edge{\hpT_i}{\hpT_j}\mapsto(\hpx,\hpx')\}$.

      By induction, $G'$ is a forest, and there is an isomorphism $f'$ between the components of $G'$ and the typing environments in $\hpHG'\hpHTens\hpGG,\hpx:\hpA\hpHTens\hpGD,\hpx':\co\hpA$ that preserves $\fn$.

      Let $T_1$ be $f'(\hpGG,\hpx:\hpA)$ and $T_2$ be $f'(\hpGD,\hpx':\co\hpA)$.

      By definition, $T_1$ and $T_2$ are disjoint trees.

      Let $T$ be the graph formed by connecting $T_1$ and $T_2$ with the edge $\edge{\hpP_i}{\hpP_j}$.
      By @lemma:tree-connection, $T$ is a tree.
      Hence, $G$ is a forest.

      Let $f$ be the function $\{\hpGG,\hpGD \mapsto C\} \cup f' \domainminus \{\hpGG,\hpx:\hpA, \hpGD,\hpx':\co\hpA\}$ (where $\domainminus$ is domain subtraction, see @definition:domain-subtraction).

      The function $f$ is an isomorphism that preserves $\fn$, by definition (for $\hpGG,\hpGD$) and by induction (for the typing environments in $\hpHG'$).

    - Case $\hpCC$ is of the form $\hpCC_1\hpPar\hpCC_2$.

      By inversion, $\hpP$ is of the form $\hpP_1\hpPar\hpP_2$ such that $\hpP_1\hpPar\hpP_2\hpSeq\hpHG_1\hpHTens\hpHG_2$, $\hpP_1\hpSeq\hpHG_1$, and $\hpP_2\hpSeq\hpHG_2$.

      Let $G$ be $\connection(\hpP)$, $G_1$ be $\connection(\hpP_1)$, and $G_2$ be $\connection(\hpP_2)$.

      By definition, $\vertices[G]=\vertices[G_1]\cup\vertices[G_2]$ and $\edgeLabelling[G]=\edgeLabelling[G_1]\cup\edgeLabelling[G_2]$.

      By induction, $G_1$ and $G_2$ are forests, and there are isomorphisms $f_1$ and $f_2$ between the typing environments in $\hpHG_1$ and $\hpHG_2$, respectively, the trees of $G_1$ and $G_2$, respectively, that preserve $\fn$.

      By \Rule{H-T-Par}, $G_1$ and $G_2$ are disjoint.
      Hence, $G$ is a forest.

      Let $f$ be the function $f_1 \cup f_2$.

      As union preserves the relevant properties of $f_1$ and $f_2$, $f$ is an isomorphism between the components of $G$ and the typing environments in $\hpHG$ that preserves $\fn$.
