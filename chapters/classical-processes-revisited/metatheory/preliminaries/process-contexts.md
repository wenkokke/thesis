# Process Contexts {#cp-process-contexts}

For the occasional convenience, I define full $n$-hole process contexts, which are arbitrary processes with any number of holes.
Process contexts may contain any process construct, and may contain holes in any position, including nested under actions. As such, process contexts generalise evaluation and configuration contexts.

Definition (Process Context) {#cp-process-context}.
  ~ *Process contexts* are defined by the grammar for processes, extended with the hole constructor, written $\cpHole$. A process context may have any number of holes.

    The names $\cpCP$, $\cpCQ$, and $\cpCR$ range over process contexts, where the trailing $\cptm[\cptm\cdot\cptm]$ is intended to help distinguish between processes and process contexts, and denotes the position of the arguments for plugging.
    I write $\cpCP^n$ to denote that the process context $\cpCP$ has $n$ holes.

    Plugging, written $\cpCP[\cpP_1,\cptm\dots,\cpP_n]$, is defined by replacing the $n$ holes in the process context $\cpCP$ with the processes $\cpP_1,\dots,\cpP_n$ in order from left to right.
