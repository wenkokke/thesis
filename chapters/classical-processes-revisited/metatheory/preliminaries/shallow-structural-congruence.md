# Shallow Structural Congruence {#cp-shallow-structural-congruence}

Reduction is closed under evaluation contexts, not under arbitrary process contexts, and only acts on the topmost actions. As such, reduction only needs a structural congruence that is similarly closed under evaluation contexts---a *shallow* structural congruence.
Therefore, it is useful to distinguish different kinds of structural congruence, based on which portions of the process they are permitted to rewrite.

Definition (Shallow Structural Congruence) {#cp-equiv-s}.
  ~ *Shallow structural congruence*, written $\cpEquivS$, is the smallest symmetric relation over processes that satisfies the rules in @figure:cp-equiv ($\text{p.\ \pageref{figure:cp-equiv}}$) and is closed under evaluation contexts, as per the following rule:
    $$
      \begin{RuleWithLabel}{C}{SC-Cong}
        \AXC{$\cpP \cpEquivS \cpP'$}
        \UIC{$\cpEE[\cpP] \cpEquivS \cpEE[\cpP']$}
        \DP
      \end{RuleWithLabel}
    $$

Most rules of the structural congruence target name restriction and parallel composition. The odd one out is \Rule{C-SC-LinkComm}, which rewrites a link action. It will be useful to single out the portions of a structural congruence that rewrite links.

Definition (Link-Preserving Structural Congruence) {#cp-equiv-lp}.
  ~ *Link-preserving structural congruence*, written $\cpEquivLP$, is the congruence closure over processes that satisfies the rules in @figure:cp-equiv except for \Rule{C-SC-LinkComm}.

Finally, it will be useful to have variants which combine these restrictions.
In practice, I only need link-preserving shallow structural congruence and deep structural congruence.

Definition (Link-Preserving Shallow Structural Congruence) {#cp-equiv-lps}.
  ~ *Link-preserving shallow structural congruence*, written $\cpEquivLPS$, is the intersection of link-preserving and shallow structural congruence.

Definition (Deep Structural Congruence) {#cp-equiv-sp}.
  ~ *Deep structural congruence*, written $\cpEquivD$, is the equivalence closure of the complement of $\cpEquivLPS$ with respect to $\cpEquiv$.

Any structural congruence can be decomposed into its link-preserving shallow and deep structural components.

Lemma {#cp-equiv-decompose}.
  ~ If $\cpP\cpEquiv\cpQ$,
    then there exists some $\cpR$
    such that $\cpP\cpEquivLPS\cpR$ and $\cpR\cpEquivD\cpQ$.
