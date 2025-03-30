# Ready Processes and Threads {#cp-readiness-and-threads}

A process is ready if it is ready to perform some communication action, i.e., if it is a link or it is prefixed by an action.
The formal definition of *ready* processes is a bit verbose, since actions are not a syntactic sort in CP, so "prefixed by an action" is not well-defined.
To work around this, I enumerate the process constructors that contain an action.

Definition (Ready) {#cp-ready}.
  ~ A process $\cpP$ is *ready to act on* $\cpx$, written $\readyOn\cpP\cpx$, if it is of one of the forms:
    $$
    \!\!
    \begin{array}{lllll}
    \cpLink\cpx\cpy
    &
    \cpSend\cpx\cpy.(\cpP\cpPar\cpQ)
    &
    \cpClose\cpx.0
    &
    \cpSelect\cpx<1.\cpP
    &
    \cpOffer\cpx(\cpInl: \cpP; \cpInr: \cpQ)
    \\
    \cpLink\cpy\cpx
    &
    \cpRecv\cpx\cpy.\cpP
    &
    \cpWait\cpx.\cpP
    &
    \cpSelect\cpx<2.\cpP
    &
    \cpAbsurdZap\cpx\cpNN
    \end{array}
    $$
    A process is *ready* if it is ready to act on some endpoint.

In particular, links $\cpLink\cpx\cpy$ are considered ready to act on both $\cpx$ and $\cpy$, and absurd $\cpAbsurdZap\cpx\cpNN$ is *not* considered ready to act on the channels $\cpy\in\cpNN$.

A process can be decomposed into a prefix of its cuts, and a series of threads connected by those cuts. Such a prefix is the *maximum* configuration context, in the sense that no further cuts can be added.

Definition (Maximum Configuration Context) {#cp-maximum-configuration-context}.
  ~ The *maximum configuration context* $\cpCC^n$ of a process $\cpP$ is the configuration context such that $\cpP=\cpCC^n\cptm[\cpP_1,\cptm\dots,\cpP_n\cptm]$ (for some $n \geq 1$) and (for $1 \leq i \leq n$) each $\cpP_i$ is ready.
    The processes $\cpP_i$ are the *threads* of $\cpP$.
    Every process has a unique maximum configuration context.

Likewise, evaluation contexts are maximal if no further cuts can be added.
Informally, maximal evaluation contexts are paths to the threads contained within some process, so each maximum configuration context $\cpCC^n$ gives us $n$ distinct maximal evaluation contexts.

Definition (Maximal Evaluation Context) {#cp-maximal-evaluation-context}.
  ~ A *maximal evaluation context* $\cpEE$ of a process $\cpP$ is an evaluation context such that $\cpP=\cpEE[\cpQ]$ and $\cpQ$ is ready.
    If $\cpCC$ is the maximum configuration context of $\cpP$, then
    ${
      \cpCC\cptm[
        \cpP_1
        ,\cptm\dots,
        \cpHole_i
        ,\cptm\dots,
        \cpP_n
      \cptm]
    }$ is a maximal evaluation context of $\cpP$.

Finally, I refer to top-level ready processes as *threads*.
A significant portion of CP's metatheory deals with threads. Let the metavariable $\cpT$ range over threads.

Definition (Thread) {#cp-thread}.
  ~ A process $\cpP$ is a *thread of* $\cpQ$ if there exists some evaluation context $\cpEE$ of $\cpQ$ such that $\cpQ=\cpEE[\cpP]$ and $\cpP$ is ready.
    I say that $\cpQ$ *contains the thread* $\cpP$ to mean that $\cpP$ is a thread of $\cpQ$.
    I say $\cpP$ is a *thread* when the process $\cpQ$ of which $\cpP$ is a thread can be inferred from context.
    Let $\cpT$ range over threads.

The use of the thread metavariable allows us to succinctly decompose any process $\cpP$ into its maximum configuration context and its threads, by stating "$\cpP\iotf\cpCC[\cpT_1,\cptm\dots,\cpT_n]$", as the notation implies that each thread $\cpT_i$ is a ready process and therefore that $\cpCC$ is the maximum configuration context.

In CP, every thread is ready. Therefore, it is tempting to do away with the separate definition of threads and let $\cpT$ range over ready processes. However, the two definitions diverge for GV, since GV's threads have internal reduction behaviour and therefore not all threads are ready.
To keep my terminology consistent, I keep the definitions of ready processes and threads separate.
