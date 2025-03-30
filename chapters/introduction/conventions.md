## Conventions

In this section, I introduce several conventions that I intend use throughout this thesis.

#### Barendregt's Convention

My proofs use @Barendregt85:lambda's Convention [-@Barendregt85:lambda]. If a term occurs in a proof, then all bound variables in that term are chosen to be different from each other and all the free variables.
This applies equally to variables in λ-calculus terms and endpoint names in process calculus processes.
In each case, the proofs can be made more formal by permitting and applying α-conversion where necessary, or by using a nameless term syntax such as deBruijn indices.

#### Pattern Matching

I use the phrase "is of the form" to imply pattern matching, where any unbound meta variable on the right hand side of that phrase is implicitly existentially quantified, and the entire phrase is converted into an equality, e.g., the phrase "$\piexp1{\piP}\iotf\piexp1{\piQ\piPar\piR}$" should be interpreted as "there exist some $\piexp1{\piQ}$ and $\piexp1{\piR}$ such that $\piexp1{\piP=\piQ\piPar\piR}$".

#### Syntax Highlighting

Except where noted, each chapter is focused primarily on one system.

The terms of that system are printed in $\tmprimaryname$, its types are printed in $\typrimaryname$, and its annotation---where applicable---are printed in $\prprimaryname$, and all three are rendered in a sans-serif font.

To save on accessible colour combinations, the terms, types, and annotations of *any other system* are printed in $\tmsecondaryname$, $\tysecondaryname$, and $\prsecondaryname$, respectively, and all three are rendered in an italicised font with serif.
The relations of other system, such as typing and reduction, are marked by a subscript.

Let us discuss CP's syntax highlighting as an example.
In @cp, which focuses on CP, its processes and types of are printed in $\tmprimaryname$ and $\typrimaryname$, respectively, and are rendered in a sans-serif font.
However, in @hcp, which focuses on HCP, CP's processes and types are rendered in $\tmsecondaryname$ and $\tysecondaryname$, respectively, and both are rendered in an italicised font with serif.
Furthermore, its relations, such as its typing relation, are marked by a subscript $\cpabbrev$, even when it was unmarked in @cp.

As a matter of personal preference, the metavariables for those syntactic categories that are collections of terms, types, and annotations, such as sets of names or typing environments, are typeset in the same color as the terms, types, and annotations of that system, respectively.
However, the constructors of these collections are not typeset in that color, e.g., $\cpexp1{\cpGG,\cpx:\cpA\cpSeq\cpP}$ and not $\cpexp1{\cpGG\mathpunct{\cpty{,}}\cpx\mathrel{\cpty{:}}\cpA\cpSeq\cpP}$.
(The comma and colon are printed in $\typrimaryname$ in the second statement.)
Likewise, functions that act on syntactic categories are not typeset in the corresponding colours, e.g., $\cpexp1{\co{\cpA}}$ and not $\cpexp1{\cpty{\co{\cpA}}}$.

#### Omitted Proof Sections

Some chapters end with a section titled "Omitted Proofs".
These sections contain proofs that were omitted from the main text of the chapter. Any proposition whose proof is omitted should provide a summary of the proof that references the relevant omitted proofs section. For lemmas, the proof is simply omitted, and only appears in the relevant omitted proofs section.

#### Embedded Papers and Pink Pages

This thesis contains three embedded papers.
The text in these papers was not composed exclusively by myself, and does not always respect the conventions set out in this section.
In an effort to signpost the beginning and end of these papers, they are preceded and followed by one pink page, in the following colour:
$$
\begin{tikzpicture}
\draw[color=white,fill=tmsecondarycolor] (0,0) rectangle (12,1);
\end{tikzpicture}
$$
The pink page preceding each paper summarises its publication history and my contributions, and the pink page following each paper is empty.

To ensure an easy transition into the text of these papers, the section prior to each paper provide a legend---which summarises the differences in its conventions, notations, and definitions---and an erratum---which clarifies any errors in the paper.
