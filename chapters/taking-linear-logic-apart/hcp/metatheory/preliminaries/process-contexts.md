# Process Contexts {#hcp-process-contexts}

For the occasional convenience, I define full $n$-hole process contexts, which are arbitrary processes with any number of holes.
Process contexts may contain any process construct, and may contain holes in any position, including nested under actions. As such, process contexts generalise evaluation and configuration contexts.

Definition (Process Context) {#hcp-process-context}.
  ~ Process contexts are defined by the grammar for processes, extended with the hole constructor, written $\hpHole$. A process context may have any number of holes.

    The names $\hpCP$, $\hpCQ$, and $\hpCR$ range over process contexts, where the trailing $\hptm[\hptm\cdot\hptm]$ is intended to help distinguish between process and process context metavariables, and denotes the position of the arguments for plugging.
    We write $\hpCP^n$ to denote that the process context $\hpCP$ has $n$ holes.

    Plugging, written $\hpCP[\hpP_1,\hptm\dots,\hpP_n]$, is defined by replacing the $n$ holes in the process context $\hpCP$ with the processes $\hpP_1,\dots,\hpP_n$ in order from left to right.
