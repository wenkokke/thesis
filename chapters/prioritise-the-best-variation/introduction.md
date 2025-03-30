<!-- markdownlint-disable MD041 -->
This chapter presents both Priority CP (PCP) and Priority GV (PGV), variants of CP and GV that use priorities [@Kobayashi06:priorities;@Padovani14:priorites].
PCP is a session-typed process calculus, based on CP, which was introduced by @DardhaG18:pcp.
PGV is a session-typed functional language, based on GV, which was introduced by @KokkeD21:pgv.

Priorities are an extra-logical mechanism for guaranteeing deadlock freedom, which arose from research on typed π-calculus rather than logic.
In a system using priorities, each session type constructor---or, equivalently each communication action---is annotated with some priority, which the type system uses to ensure deadlock freedom.
Let us consider two intuitions for the mechanism by which priorities work.

Concretely, *priorities* are natural numbers that represent the time at which some communication happens, i.e., for the process $\ppSend\ppx\ppy.\ppRecv\ppz\ppw.\ppP$, we might assign the action $\ppSend\ppx\ppy$ priority $1$, because it happens at time $1$, and $\ppRecv\ppz\ppw$ priority $2$, since it necessarily happens at some later time.
Type checking requires that the priority assignment reflects this dependency, and that dual actions take place at the same time.
In a session-typed system, this suffices to rule out deadlocks, as there are no valid priority assignments for deadlocking processes.
For instance, for the process
$$
\ppNew(\ppx\ppx')\ppNew(\ppy\ppy')(
  \ppWait{\ppx}.\ppClose{\ppy}.\ppZ
  \ppPar
  \ppWait{\ppy'}.\ppClose{\ppx'}.\ppZ
)
$$
there exists no valid priority assignment, since, by duality, $\ppWait{\ppx}$ must happen at the same time as $\ppClose{\ppx'}$, and $\ppWait{\ppy}$ must happen at the same time as $\ppClose{\ppy'}$, but, by dependency, $\ppWait{\ppx}$ must happen before $\ppClose{\ppy}$, and $\ppWait{\ppy'}$ must happen before $\ppClose{\ppx'}$.
Represented visually, we can see that the these requirements are essentially cyclic:
$$
\begin{tikzpicture}
  \node (Wx) at (0,0)          {$\ppWait{\ppx}$};
  \node (Cy) [right=8em of Wx] {$\ppClose{\ppy}$};
  \node (Wy) [below=3em of Wx] {$\ppWait{\ppy'}$};
  \node (Cx) [right=8em of Wy] {$\ppClose{\ppx'}$};
  \path (Wx) -- node[near start,yshift=-2pt]
        (WxCx) {\rotatebox[origin=c]{-30}{$=$}} (Cx);
  \path (Wy) -- node[near start,yshift=-2pt]
        (WyCy) {\rotatebox[origin=c]{+30}{$=$}} (Cy);
  \draw (Wx) -- (WxCx); \draw (WxCx) -- (Cx);
  \draw (Wy) -- (WyCy); \draw (WyCy) -- (Cy);
  \path (Wx) -- node[midway] (WxCy) {$<$} (Cy);
  \path (Wy) -- node[midway] (WyCx) {$<$} (Cx);
  \draw (Wx) -- (WxCy); \draw[->] (WxCy) -- (Cy);
  \draw (Wy) -- (WyCx); \draw[->] (WyCx) -- (Cx);
  \node (CoordWx) at (Wx) [xshift=-1.5em] {};
  \node (CoordCy) at (Cy) [xshift=+1.5em] {};
  \node (CoordWy) at (Wy) [xshift=-1.5em] {};
  \node (CoordCx) at (Cx) [xshift=+1.5em] {};
  % \path[draw,ultra thick,red]
  %   (CoordWx.north) to[out=+45,in=+135]
  %   (CoordCy.north) to[out=-45,in=+45]
  %   (CoordCy.south) to[out=-135,in=+45]
  %   (CoordWy.north) to[out=-135,in=+135]
  %   (CoordWy.south) to[out=-45,in=-135]
  %   (CoordCx.south) to[out=+45,in=-45]
  %   (CoordCx.north) to[out=+135,in=-45]
  %   (CoordWx.south) to[out=+135,in=-135]
  %   (CoordWx.north);
\end{tikzpicture}
$$
Programs are annotated with a lower and and upper *priority bound*, which represent the time at which the program begins to communicate, and the time it finishes.
Each priority bound is either a concrete priority, or $\top$, or $\bot$, where the latter two are the supremum and infimum, respectively, i.e., $\top$ is greater than any priority, and $\bot$ is smaller than any priority.
The supremum and infimum are useful in a variety of circumstances.
For instance, a program that does not communicate is assigned the lower bound $\top$ and the upper bound $\bot$, i.e., it never begins communicating, and has already finished.
Alternatively, $\bot$ and $\top$ may be used as lower and upper bounds, respectively, to represent unknowns.
For instance, a program that loops might not have a concrete upper bound, and can be assigned upper bound $\top$, to mean that we do not know if or when it finishes communicating.

Abstractly, we can view priority metavariables as names for actions.
(Here, we say priority metavariables, rather than priorities, to emphasize that we are referring to the names, rather than the concrete numbers with which they will be instantiated.)
Type checking imposes equality and inequality constraints on priority metavariables, which define the deep dependency graph by analogy to the shallow dependency graph as defined for, e.g., HCP in @hcp-duality-dependency-and-deadlock.
For instance, the visual representation of constraints, shown above, is isomorphic to the dependency graph for the same process.
If the deep dependency graph is essentially acyclic, there exists a topological sort of the priority metavariables, which we can use to instantiate them with concrete priorities.
This is the mechanism behind priority inference, which we discuss in @pcp-priority-inference.

Generally, priority type systems place the priority annotations on session type connectives, rather than actions, since it makes it easier to integrate priorities into type checking.
(This is what the type systems for PCP and PGV, presented in @prioritise-the-best-variation, do as well.)
Explicitly tracking both the priority lower and upper bounds can be quite syntactically burdensome, but there are several tricks to ease this:

- In general, the lower bound can be under-approximated by taking the smallest priority of all endpoints in the typing environment, since a program cannot start communicating earlier than its endpoints permit.
- In systems such as the π-calculus, we do not need to track the upper bound.
  When composing two programs in sequence, we must check that the first program finishes communicating before the second program starts.
  However, the only kind of sequential composition in the π-calculus is prefixing a process with an action.
  In this case, we must check that the action finishes before the process starts. Hence, we only need to check that the priority of the action is smaller than the lower bound of the process.
- Finally, if we must track both the lower and the upper bound, we can slightly ease the burden of syntax by tracking pairs of lower and upper bounds instead.  Since pairs of priority bounds form a lattice, this lets us track both bounds while only manipulating a single value.

One of the benefits of GV is that it closely resembles the manner in which concurrency is exposed to the user in programming languages, which makes it easy to implement the deadlock-free session-typed communication offered by GV as a library, especially in a host language that supports linear types.
Less so for Priority GV, as presented in @prioritise-the-best-variation, since  priority typing requires more of the type system.
Fortunately, session-typed communication can be reflected into a monad, in the sense of the *monadic reflection* of an effect, following @Filinski94:monads, and priority typing can be reflected into a parametrised monad, parametrised by pairs of lower and upper priority bounds, following @Atkey09:imonad.
We explore the monadic reflection of priorities in @deadlock-free-session-types-in-linear-haskell.

The version of PCP introduced in this chapter is different from the version introduced by @DardhaG18:pcp.

- We drop the commuting conversions. Hence, it bears the same relation to Dardha and Gay's PCP as the version of CP in @cp does to @Wadler12:cpgv's CP.
  Notably, @DardhaG18:pcp's PCP is non-confluent for the same reason @Wadler12:cpgv's CP is non-confluent [see @cp-commuting-conversions].
- We simplify variant select and offer to binary select and offer, and reintroduce a separate construct for the absurd offer.
- We allow arbitrary process continuations in the close construct, rather than forcing the process to terminate.
- We restrict ourselves to studying the multiplicative additive core, and omit the exponentials, as is done in most of this thesis.
  (Neither publication includes the second order quantifiers.)
- We add the additive units, which are omitted in @DardhaG18:pcp, and use the 'inert' semantics for the absurd offer, as discussed in @cp-the-absurd-offer.
  (Since the priority constraints encode the blocking behaviour of actions, using the exceptional semantics, as discussed in @hcp-zap-exceptionally-absurd-offer, requires a different typing rule for the absurd offer.)

While @DardhaG18:pcp introduce PCP as an *extension* of CP, it does not formally extend CP, as there are CP processes that are not typeable in PCP.
We discuss the relation between CP and PCP in detail in @pcp-relation-to-cp.

The bulk of the chapter consists of the paper *Prioritise the Best Variation* by @KokkeD23:pgv-ext, hereafter referred to as \hyperlink{paper:prioritise-the-best-variation.1}{Paper~II}.
References made from the main body of this thesis into \hyperlink{paper:prioritise-the-best-variation.1}{Paper~II} will be prefixed by an "II", e.g., "Theorem \hyperlink{paper:prioritise-the-best-variation.24}{II.3.13}".
This chapter proceeds as follows:

- In @priorities-legend-and-errata, we provide a legend and an errata for \hyperlink{paper:prioritise-the-best-variation.1}{Paper~II}.
- In @prioritise-the-best-variation, we present Priority GV and Priority CP, their metatheories, and the correspondence between Priority GV and Priority CP.
  This section consists entirely of \hyperlink{paper:prioritise-the-best-variation.1}{Paper~II}, and proceeds as follows:

  - In § \hyperlink{paper:prioritise-the-best-variation.4}{II.2}, we introduce PGV.
  - In § \hyperlink{paper:prioritise-the-best-variation.15}{II.3}, we present the metatheory for PGV.

    Notably, we prove *preservation* (referred to as *subject reduction*, § \hyperlink{paper:prioritise-the-best-variation.15}{II.3.1}, Theorem \hyperlink{paper:prioritise-the-best-variation.20}{II.3.5}) and *global progress* (§ \hyperlink{paper:prioritise-the-best-variation.22}{II.3.2}, Theorem \hyperlink{paper:prioritise-the-best-variation.24}{II.3.14}).
  - In § \hyperlink{paper:prioritise-the-best-variation.25}{II.4}, we revisit PCP and its metatheory, and prove a sound and complete operational correspondence between PCP and PGV.

    The version of PCP presented in this section differs from @DardhaG18:pcp's PCP, as discussed previously, as it drops commuting conversions, allows arbitrary process continuations after a close action, and does not include the exponentials.
    Notably, we prove *progress* (§ \hyperlink{paper:prioritise-the-best-variation.29}{II.4.5}, Theorem \hyperlink{paper:prioritise-the-best-variation.29}{II.4.4}), define a translation from PCP into PGV (§ \hyperlink{paper:prioritise-the-best-variation.30}{II.4.6}), and prove that the translation preserves types (§ \hyperlink{paper:prioritise-the-best-variation.30}{II.4.6}, Theorem \hyperlink{paper:prioritise-the-best-variation.32}{II.4.6}), and gives rise to a complete (§ \hyperlink{paper:prioritise-the-best-variation.30}{II.4.6}, Theorem \hyperlink{paper:prioritise-the-best-variation.35}{II.4.7}) and sound (§ \hyperlink{paper:prioritise-the-best-variation.30}{II.4.6}, Theorem \hyperlink{paper:prioritise-the-best-variation.38}{II.4.10}) operational correspondence.
  - In § \hyperlink{paper:prioritise-the-best-variation.40}{II.5}, we discuss an example program.
  - In § \hyperlink{paper:prioritise-the-best-variation.41}{II.6}, we discuss related work.
- In @priorities-discussion, we discuss PCP in further detail:

  - In @pcp-relation-to-cp, we discuss the relation between PCP and CP.
  - In @pcp-priority-inference, we introduce priority inference for PCP.
