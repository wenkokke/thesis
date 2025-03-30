<!-- markdownlint-disable MD041 -->
In previous chapters, I have made the claim that GV's session-typed communication is easy to implement as a library, especially when the host language already supports linear types.
To evidence this claim, this chapter presents an implementation of both HGV and PGV's session-typed concurrency primitives as a library, named `priority-sesh`, implemented in Linear Haskell [@MarlowEtAl10:haskell;@BernardyB18:linear-haskell].

The library only implements HGV and PGV's concurrency primitives.
This is a double-edged sword.
Only implementing the concurrency primitives makes GV easy to implement, but also easy to implement incorrectly, since this makes a number of assumptions about the host language that are difficult to prove.

- It relies on the host language to provide the basic ingredients of a functional language---e.g., functions, pairs, sums, etc.---and basic concurrency primitives---i.e., threads and channels.
- It assumes that the host language and GV agree on their evaluation strategy, or that GV's correctness guarantees are invariant under the choice of evaluation strategy.
  (For Haskell, we can say with confidence that the first option does not hold, since GV's semantics are call-by-value, whereas Haskell's semantics are call-by-need.)
- It assumes that the host language and GV agree on the semantics for threads and channels.

The bulk of the chapter consists of the paper *Deadlock-Free Session Types in Linear Haskell* by @KokkeD21:priority-sesh, hereafter referred to as \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.1}{Paper~III}.
References made from the main body of this thesis into \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.1}{Paper~III} will be prefixed by an "III", e.g., "Theorem \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.8}{III.3.1}".
This chapter proceeds as follows:

- In @implementations-legend-and-errata, I provide a legend and an errata for \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.1}{Paper~III}.
- In @deadlock-free-session-types-in-linear-haskell, we present an implementation of both HGV and PGV's session-typed communication as a library in Linear Haskell.
  This section consists entirely of \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.1}{Paper~III}, and proceeds as follows:

  - In § \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.2}{III.2.1}, we implement one-shot channels.
  - In § \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.3}{III.2.2}, we implement session-typed channels.
  - In § \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.5}{III.2.3}, we show that a restriction of the interface defined in § \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.3}{III.2.2} corresponds to HGV's communication primitives.
  - In § \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.5}{III.2.4}, we implement priority-based channels.
  - In § \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.7}{III.3}, we show that the interface defined in § \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.5}{III.2.4} is the monadic reflection of PGV's communication primitives.
  - In § \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.9}{III.4}, we discuss the related work. Notably, we compare a variety of session types in Haskell, extending the analysis provided by @OrchardY17:st.
  - In § \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.11}{III.5}, we discuss our experience using Linear Haskell as well as potential directions for future work.
