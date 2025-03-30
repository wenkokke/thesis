# Observational Equivalence {#cp-observational-equivalence}

In this section, I provide the basis for a behavioural theory for CP, namely, definitions for an observability predicate and barbed congruence.
The purpose of this section is merely to show that these definitions can be given without the additional machinery introduced by @Atkey17:obs-cp.
Therefore, I will not delve too deeply into the details.
Access to an observability predicate also somewhat eases the discussion of commuting conversions in @cp-commuting-conversions.

The definition of observability predicates is non-standard, as it is not defined in terms of a label-transition system, but it is well-known, and follows @SangiorgiW03:pi [p. 56, Exercise 2.1.3].
The definition of the barbed congruence is standard, and follows @KokkeMP19:dhcp.

Definition (Observability predicates) {#cp-observability}.
  ~ The *observability predicate* $\cpOb\cpx\cpP$ holds
    if and only if $\cpP\iotf\cpEE[\cpQ]$
    such that $\readyOn\cpQ\cpx$
    and $\{\cpy\in\fn(\cpQ)\vert\readyOn\cpQ\cpy\}\cap\bn(\cpEE)=\emptyset$.

Definition (Barbed congruence) {#cp-barbed-congruence}.
  ~ *Barbed congruence*, written $\cpBarbedEquiv$, is the largest symmetric relation on well-typed processes that is:

    1. type preserving (i.e., if $\cpP\cpBarbedEquiv\cpQ$ and $\cpP\cpSeq\cpGG$ then $\cpQ\cpSeq\cpGG$)
    2. barb preserving (i.e., if $\cpP\cpBarbedEquiv\cpQ$ and $\cpOb\cpx\cpP$ then $\cpOb\cpx\cpQ$)
    3. context-closed (i.e., if $\cpP\cpBarbedEquiv\cpQ$ then $\cpCR[\cpP]\cpBarbedEquiv\cpCR[\cpQ]$ for any well-typed $\cpCR$)

For a coarser barbed congruence, which distinguishes, e.g., $\cpSelect\cpx<1.\cpP$ and $\cpSelect\cpx<2.\cpP$, index the observability predicates with coarser labels [@YoshidaHB02:lb;@Atkey17:obs-cp;@KokkeMP19:dhcp].
However, such considerations are outside of the scope of this section.
