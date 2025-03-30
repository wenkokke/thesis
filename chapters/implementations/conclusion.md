# Conclusion {#implementations-conclusion}

In this chapter, we introduced a library in Linear Haskell which implements session-typed channels based on GV and Priority GV.
We defined the monadic reflection of PGV's type system into a graded linear monad, to permit an easy embedding of PGV's priority typing into Linear Haskell's type system.
Finally, we compared our Haskell library to existing Haskell libraries for session-typed channels.

In the future, it would be interesting to implement a variant of the library that uses type-level programming for priority inference, as the current design requires the user to manually annotate actions with their priorities.
Furthermore, it would be interesting to describe the relation between the library and GV more formally, and formalise the correspondence using a proof-assistant.
Finally, it would be useful to extend the library with the link primitive, both from a practical standpoint, and to more closely align the implementation with the formal calculus.
