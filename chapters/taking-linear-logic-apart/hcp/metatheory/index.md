# Metatheory {#hcp-metatheory}

In this section, I introduce the metatheory for Hypersequent Classical Processes.
The principal developments are as follows:

- In @hcp-preliminaries, I give several preliminary definitions that are used throughout the discussion of the metatheory.

- In @hcp-preservation, I prove preservation (@proposition:hcp-preservation).

- In @hcp-progress, I define canonical form [@definition:hcp-canonical-form] and prove progress [@proposition:hcp-progress].
  The proof of progress is adapted from the proof for CP (@proposition:cp-progress) and first appeared in @KokkeMP19:hcp.

- In @hcp-duality-dependency-and-deadlock, I define dependency graphs for HCP processes [@definition:hcp-dependency-graph].
  I prove that HCP is deadlock-free, as its dependency graphs are always acyclic [@corollary:hcp-deadlock-free], and I prove that my definition of canonical form is adequate [@corollary:hcp-canonical-implies-blocking-free].

- In @hcp-connection-and-disentanglement, I define connection graphs for HCP processes [@definition:cp-connection-graph] and prove that HCP's connection graphs are always forests [@proposition:hcp-connection-forest].
  The validity of right-branching forest form for HCP follows as a corollary.

- In @hcp-multiset-cp, I define Multiset CP, a process calculus whose processes are multisets of parallel CP processes. The principal use of Multiset CP is to clarify the correspondence between HCP and CP.

- In @hcp-fission-fusion-and-disentanglement, I define fission, the translation from Multiset CP into HCP, and its inverse, disentanglement-and-fusion, the translation from HCP into Multiset CP, and prove that these translations preserve types, structural congruence, and reduction.

```include
preliminaries/index.md
preservation.md
progress.md
duality-dependency-and-deadlock.md
connection-and-disentanglement.md
```

```{=latex}
\cpset2%
\mpset2%
```

```include
multiset-cp.md
fission-fusion-and-disentanglement.md
```

```include
lts-and-harmony.md
```
