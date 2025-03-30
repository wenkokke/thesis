# Shallow Structural Congruence {#hcp-shallow-structural-congruence}

Reduction is closed under evaluation contexts, not under arbitrary process contexts, and only acts on the topmost actions. As such, reduction only needs a structural congruence that is similarly closed under evaluation contexts---a *shallow* structural congruence.
Therefore, it is useful to distinguish different kinds of structural congruence, based on which portions of the process they are permitted to rewrite.

Definition (Shallow Structural Congruence) {#hcp-equiv-s}.
  ~ *Shallow structural congruence*, written $\hpEquivS$, is the smallest symmetric relation over processes that satisfies the rules in @figure:hcp-equiv and is closed under evaluation contexts, as per the following rule:
    $$
      \begin{RuleWithLabel}{H}{SC-Cong}
        \AXC{$\hpP \hpEquivS \hpP'$}
        \UIC{$\hpEE[\hpP] \hpEquivS \hpEE[\hpP']$}
        \DP
      \end{RuleWithLabel}
    $$

Most rules of the structural congruence target name restriction and parallel composition. The odd one out is \Rule{H-SC-LinkComm}, which rewrites a link action. It will be useful to single out the portions of a structural congruence that rewrite links.

Definition (Link-Preserving Structural Congruence) {#hcp-equiv-lp}.
  ~ *Link-preserving structural congruence*, written $\hpEquivLP$, is the congruence closure over processes that satisfies the rules in @figure:hcp-equiv except for \Rule{H-SC-LinkComm}.

Finally, it will be useful to have variants which combine these restrictions.
In practice, I only need link-preserving shallow structural congruence and deep structural congruence.

Definition (Link-Preserving Shallow Structural Congruence) {#hcp-equiv-lps}.
  ~ *Link-preserving shallow structural congruence*, written $\hpEquivLPS$, is the intersection of link-preserving and shallow structural congruence.

Definition (Deep Structural Congruence) {#hcp-equiv-sp}.
  ~ *Deep structural congruence*, written $\hpEquivD$, is the equivalence closure of the complement of $\hpEquivLPS$ with respect to $\hpEquiv$.

Any structural congruence can be decomposed into its link-preserving shallow and deep structural components.

Lemma {#hcp-equiv-decompose}.
  ~ If $\hpP\hpEquiv\hpQ$,
    then there exists some $\hpR$
    such that $\hpP\hpEquivLPS\hpR$ and $\hpR\hpEquivD\hpQ$.
