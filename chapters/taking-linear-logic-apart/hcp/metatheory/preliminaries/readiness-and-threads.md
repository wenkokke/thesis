# Ready Processes and Threads {#hcp-readiness-and-threads}

A process is ready if it is ready to perform some communication action, i.e., if it is a link or it is prefixed by an action.
(The definition of ready remains essentially unchanged from CP, though, of course, the forms of send and close actions has changed.)

Definition (Ready) {#hcp-ready}.
  ~ A process $\hpP$ is *ready to act on* $\hpx$, written $\readyOn\hpP\hpx$, if it is of one of the forms:
    $$
    \!\!
    \begin{array}{lllll}
    \hpLink\hpx\hpy
    &
    \hpSend\hpx\hpy.\hpP
    &
    \hpClose\hpx.\hpP
    &
    \hpSelect\hpx<1.\hpP
    &
    \hpOffer\hpx(\hpInl: \hpP; \hpInr: \hpQ)
    \\
    \hpLink\hpy\hpx
    &
    \hpRecv\hpx\hpy.\hpP
    &
    \hpWait\hpx.\hpP
    &
    \hpSelect\hpx<2.\hpP
    &
    \hpAbsurdZap\hpx\hpNN
    \end{array}
    $$
    A process is *ready* if it ready to act on some endpoint.

In particular, that links $\hpLink\hpx\hpy$ are considered ready to act on both $\hpx$ and $\hpy$, and absurd $\hpAbsurdZap\hpx\hpNN$ is *not* considered ready to act on the channels $\hpy\in\hpNN$.

A process can be decomposed into a prefix of its cuts, and a series of threads connected by those cuts. Such a prefix is the *maximum* configuration context, in the sense that no further cuts can be added.
(The definition of maximal configuration contexts is adjusted to permit configuration contexts with zero holes, i.e., the maximum configuration contexts for terminated processes, but otherwise unchanged.)

Definition (Maximum Configuration Context) {#hcp-maximum-configuration-context}.
  ~ The *maximum configuration context* $\hpCC^n$ of a process $\hpP$ is the configuration context such that $\hpP=\hpCC^n[\hpP_1,\hptm\dots,\hpP_n]$ (for some $n \geq 0$) and (for $1 \leq i \leq n$) each $\hpP_i$ is ready.
    The processes $\hpP_i$ are the *threads* of $\hpP$.
    Every process has a unique maximum configuration context.

Likewise, evaluation contexts are maximal if no further cuts can be added.
Informally, maximal evaluation contexts are paths to the threads contained within some process, so each maximum configuration context $\hpCC^n$ gives us $n$ distinct maximal evaluation contexts.
(The definition of maximal evaluation contexts is unchanged from CP.)

Definition (Maximal Evaluation Context) {#hcp-maximal-evaluation-context}.
  ~ A *maximal evaluation context* $\hpEE$ of a process $\hpP$ is an evaluation context such that $\hpP=\hpEE[\hpQ]$ and $\hpQ$ is ready.
    If $\hpCC$ is the maximum configuration context of $\hpP$, then
    $\hpCC[\hpP_1,\hptm\dots,\hpHole_i,\hptm\dots,\hpP_n]$
    is a maximal evaluation context of $\hpP$.

Finally, we refer to the top-level ready processes as *threads*. A significant portion of HCP's metatheory deals with threads. Let the metavariable $\hpT$ range over threads.

Definition (Thread) {#hcp-thread}.
  ~ A process $\hpP$ is a *thread of* $\hpQ$ if there exists some evaluation context $\hpEE$ of $\hpQ$ such that $\hpQ=\hpEE[\hpP]$ and $\hpP$ is ready.
    We say that $\hpQ$ *contains the thread* $\hpP$ to mean that $\hpP$ is a thread of $\hpQ$.
    We say $\hpP$ is a *thread* when the process $\hpQ$ that $\hpP$ is a thread of can be inferred from context.
    Let $\hpT$ range over threads.

The use of the thread metavariable allows us to succinctly decompose any process $\hpP$ into its maximum configuration context and its threads, by stating "$\hpP\iotf\hpCC[\hpT_1,\hptm\dots,\hpT_n]$", as the notation implies that each thread $\hpT_i$ is a ready process, and therefore that $\hpCC$ is the maximum configuration context.
