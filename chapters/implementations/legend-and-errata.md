# Legend and Errata {#implementations-legend-and-errata}

The conventions and terminology in \Cref{paper:separating-sessions-smoothly} are different from those used in the rest of this thesis.

- The concurrency primitives, session types, and priorities in the Linear Haskell implementation as well as the terms, types, and priorities of Priority GV are printed in $\paperIIItmcolorname$, $\paperIIItycolorname$, and $\paperIIIprcolorname$, respectively, and are rendered in an italicised or bolded font with serif.

There are several other notable differences between HGV and PGV and their implementations in the library.

First, the library implements several extensions to GV.

- The library implements session cancellation, following Exceptional GV [EGV, @FowlerLMD19:egv].

  Strictly speaking, this means the implementation is *affine* rather than *linear*, in the sense that values can be left unused.
  This is important in any practical implementation of session types, regardless of what typing facilities are offered by the host language.
  We can design a session-typed language in the simplified setting where communication always succeeds and no process ever crashes, but this assumption is immediately shattered upon contact with reality.

  This extension *also* allows us to implement GV as a library in host languages whose type systems are affine rather than linear, such as the predecessor to the library, *Rusty Variation* by @Kokke19:sesh, which is implemented in Rust [@MatsakisK14:rust].
- The library has polymorphic and recursive session types, simply by virtue of being implemented in Haskell.
  The recursive sessions in the library do not provide any termination guarantees. This is unsurprising, since Haskell does not offer any termination guarantees.
  Hence, the recursive sessions in the library do not correspond to the recursive sessions in @LindleyM16:recgv's µGV, but they may correspond to the variant that identifies the greatest and least fixed points [@LindleyM16:recgv, § 2.3, under "Nontermination"].

Second, the library makes several simplifications that are common in practical variants of GV, which relax the correspondence with CLL.

- The $\gvLink$ primitive is omitted from both the implementation of session-typed channels (in § \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.3}{III.2.2}) and the implementation of priority-based session-typed channels (in § \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.5}{III.2.4}).
  This is common in implementations of GV, or variants of GV which do not aim to prove a correspondence with a variant of CP.
- The type system conflates $\gvtyEnd!$ and $\gvtyEnd?$ into $\paperIIItycolor{\mathit{End}}$. This is equivalent to postulating \Rule{CLL-Mix} and \Rule{CLL-Mix0} in CLL, i.e., it preserves deadlock-freedom, but relaxes the structure of the connection graph from a tree to a forest. Consequently, processes may become disconnected.
  Consequently, exceptions raised in disconnected child processes are not propagated to the main process.
  This is not a serious problem, as it cannot affect the outcome of the main computation, and does not justify the added complexity of separating $\gvtyEnd!$ and $\gvtyEnd?$.  
  (If the library's concurrency primitives are used together with other forms of inter-process communication, exceptions raised in disconnected child processes can affect the outcome of the main computation, but such uses already lose the guarantee of deadlock-freedom.)

Finally, the library makes several changes that are required to correctly embed HGV and PGV into Linear Haskell.

- The library relies on Linear Haskell to provide linearity checking.
  However, Linear Haskell and GV have different notions of linearity.
  In GV, linearity is a property of *values*.
  If a value is linear, it must be used exactly once.
  In Linear Haskell, linearity is a property of *functions*.
  If a function is linear, it must use its argument exactly once.
  To accommodate this difference, it is important that session-typed endpoints, which must be used linearly, are only ever obtained as the arguments of linear functions.

  In HGV's implementation, the concurrency primitive $\gvFork$ is replaced with the equivalent concurrency primitive $\gvConnect$ from @Wadler12:cpgv's GV (see § \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.5}{III.2.3}).
  Whereas $\gvFork$ returns the dual endpoint, $\gvConnect$ passes it to another continuation.
  As endpoints can only be created by $\gvConnect$, this guarantees they are used linearly.
  $$
  \begin{array}{c@{\qquad}c}
  \gvFork:
    \gvty\lparen\gvS\gvtyFun\gvtyEnd!\gvty\rparen
    \gvtyFun
    \co{\gvS}
  &
  \gvConnect:
    \gvty\lparen\gvS\gvtyFun\gvtyEnd!\gvty\rparen
    \gvtyFun
    \gvty\lparen\co{\gvS}\gvtyFun\gvT\gvty\rparen
    \gvtyFun
    \gvT
  \end{array}
  $$
  (The type of "$\paperIIItmcolor{\mathit{connect}}$" in the library differs from the type of $\gvConnect$ presented above. We shall discuss this shortly.)

  In PGV's implementation, the concurrency primitives are lifted into a linear graded monad (see "$\paperIIItycolor{\mathit{Sesh}}$", in § \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.5}{III.2.4}, under \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.6}{"The Communication Monad"}).
  As the bind operation for this monad is linear, this guarantees that endpoints are used linearly.
- In HGV's implementation, the type of "$\paperIIItmcolor{\mathit{connect}}$" differs from the type of @Wadler12:cpgv's $\gvConnect$, as presented above.
  $$
  \paperIIItmcolor{\mathit{connect}}
  \dblcolon
  \paperIIItycolor{\mathit{Session}}\:s\Rightarrow
  (s \multimap \mathit{IO}\:())
  \multimap
  (\paperIIItycolor{\mathit{Dual}}\:s \multimap \mathit{IO}\:a)
  \multimap
  \mathit{IO}\:a
  $$
  The function corresponding to the child thread has type $s \multimap \mathit{IO}\:()$ instead of $\gvS\gvtyFun\gvtyEnd!$, which means it returns the unit, rather than an endpoint of type $\gvtyEnd!$.

  The change of type is due to two relaxations of GV's typing.
  The first is the conflation of $\gvtyEnd!$ and $\gvtyEnd?$ into $\paperIIItycolor{\mathit{End}}$, discussed above.
  The second is the switch from the synchronous $\paperIIItycolor{\mathit{End}}$ to the asynchronous unit, which lets child processes terminate asynchronously, without synchronising with their parents.
- In PGV's implementation, the concurrency connectives are lifted into the graded linear monad ${\paperIIItycolor{\mathit{Sesh}}}_{\paperIIIprcolor{p}}^{\paperIIIprcolor{q}}$, which permits us to encode PGV's constraints in Haskell's type system as type-level constraints.

There are minor errors in \Cref{paper:deadlock-free-session-types-in-linear-haskell}:

- A phrase in the first paragraph on Page \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.6}{III.6} reads "For instance, for *totallyFine* we can assign the number 0 to $\gvSend\gvApp(ch_{s1})$ and $\gvRecv\gvApp(ch_{r2})$, and 1 to $\gvSend\gvApp(ch_{s2})$ and $\gvRecv\gvApp(ch_{r1})$", but should read "For instance, for *totallyFine* we can assign the number 0 to $\gvSend\gvApp(ch_{s1})$ and $\gvRecv\gvApp(\underline{ch_{r1}})$, and 1 to $\gvSend\gvApp(ch_{s2})$ and $\gvRecv\gvApp(\underline{ch_{r2}})$".

<!--
- There is a bug in the implementation of one-shot channels (see "$\paperIIItycolor{\mathit{Send_1}}$" and "$\paperIIItycolor{\mathit{Recv_1}}$", in § \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.2}{III.2.1}, under \hyperlink{paper:deadlock-free-session-types-in-linear-haskell.2}{"Channels"}).
  $$
  \begin{array}{l@{\:}l@{\:}l@{\;=\;}l@{\:}l}
  \mathbf{newtype}
  & \paperIIItycolor{\mathit{Send_1}}
  & a
  & \paperIIItmcolor{\mathit{Send_1}}
  & (\mathit{Weak}\:(\mathit{MVar}\:a))
  \\
  \mathbf{newtype}
  & \paperIIItycolor{\mathit{Recv_1}}
  & a
  & \paperIIItmcolor{\mathit{Recv_1}}
  & (\mathit{Weak}\:(\mathit{MVar}\:a))
  \end{array}
  $$
-->
