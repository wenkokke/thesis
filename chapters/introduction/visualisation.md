$$
  \begin{tikzpicture}
    % Classical Linear Logic
    \node
    (LL)
    [draw,rectangle,rounded corners,fill=tysecondarycolor,minimum width=12em,minimum height=2em]
    {Classical Linear Logic};
    % Classical Processes and Good Variation
    \node
    (CP)
    [below=3em of LL,draw,rectangle,rounded corners,fill=tmsecondarycolor,minimum width=12em,minimum height=2em]
    {Classical Processes};
    \node
    (GV)
    [below=3em of CP,draw,rectangle,rounded corners,fill=tmsecondarycolor,minimum width=12em,minimum height=2em]
    {Good Variation};
    \draw
    [double distance=1pt]
    (LL)
    --
    (CP);
    \path
    (CP)
    --
    node[midway]
    {$\!\!\begin{array}{c}\text{operational}\\\text{correspondence}\end{array}$}
    (GV);
    \draw[dashed,gray]
    (GV)
    edge[->,bend left=45,transform canvas={xshift=-3em}]
    node[midway,left]
      {$\llbracket\cdot\rrbracket_x$}
    (CP);
    \draw[dashed,gray]
    (CP)
    edge[->,bend left=45,transform canvas={xshift=+3em}]
    node[midway,right]
      {$\llparenthesis\cdot\rrparenthesis$}
    (GV);
    % Hypersequent CP and Hypersequent GV
    \node
    (HCP)
    [right=9em of CP,draw,rectangle,rounded corners,fill=prsecondarycolor,minimum width=12em,minimum height=2em]
    {Hypersequent CP};
    \node
    (HGV)
    [right=9em of GV,draw,rectangle,rounded corners,fill=prsecondarycolor,minimum width=12em,minimum height=2em]
    {Hypersequent GV};
    \path
    (HCP)
    --
    node[midway]
    {$\!\!\begin{array}{c}\text{operational}\\\text{correspondence}\end{array}$}
    (HGV);
    \draw
    (HGV)
    edge[->,bend left=45,transform canvas={xshift=-3em}]
    node[midway,left]
      {$\llbracket\cdot\rrbracket_x$}
    (HCP);
    \draw[dashed,gray]
    (HCP)
    edge[->,bend left=45,transform canvas={xshift=+3em}]
    node[midway,right]
      {$\llparenthesis\cdot\rrparenthesis$}
    (HGV);
    % Classical Processes and Hypersequent CP
    \draw
    (CP)
    edge
    node[pos=0.555,above] (CP2HCPC) {conservative}
    node[pos=0.555,below] (CP2HCPE) {extension}
    (HCP);
    % Good Variation and Hypersequent GV
    \draw
    (GV)
    edge
    node[pos=0.555,above] (GV2HGVC) {conservative}
    node[pos=0.555,below] (GV2HGVE) {extension}
    (HGV);
    % Priority CP and Priority GV
    \node
    (PCP)
    [below=3em of HGV,draw,rectangle,rounded corners,fill=tmsecondarycolor,minimum width=12em,minimum height=2em]
    {Priority CP};
    \node
    (PGV)
    [below=3em of PCP,draw,rectangle,rounded corners,fill=prsecondarycolor,minimum width=12em,minimum height=2em]
    {Priority GV};
    \path
    (PCP)
    --
    node[midway]
    {$\!\!\begin{array}{c}\text{operational}\\\text{correspondence}\end{array}$}
    (PGV);
    \draw[dashed,gray]
    (PGV)
    edge[->,bend left=45,transform canvas={xshift=-3em}]
    node[midway,left]
      {$\llbracket\cdot\rrbracket_x$}
    (PCP);
    \draw
    (PCP)
    edge[->,bend left=45,transform canvas={xshift=+3em}]
    node[midway,right]
      {$\llparenthesis\cdot\rrparenthesis$}
    (PGV);
    % Classical Processes and Priority CP
    \path[draw]
    (PCP)
    edge
    node[pos=0.444,above]
    {non-extension}
    ([xshift=-9em]PCP.west)
    edge[densely dotted]
    ([xshift=-9em-6pt]PCP.west)
    edge[dotted]
    ([xshift=-9em-12pt]PCP.west);
    % Good Variation and Priority GV
    \path[draw]
    (PGV)
    edge
    node[pos=0.444,above]
    {non-extension}
    ([xshift=-9em]PGV.west)
    edge[densely dotted]
    ([xshift=-9em-6pt]PGV.west)
    edge[dotted]
    ([xshift=-9em-12pt]PGV.west);
    % Part I
    \begin{scope}
      \clip
      ([xshift=-1em,yshift=+1em]CP.north west)
      rectangle
      ([xshift=+1em]$(CP.east)!0.5!(GV.east)$);
      \draw[dashed,thick,rounded corners]
      ([xshift=-0.5em,yshift=+0.5em]CP.north west)
      rectangle
      ([xshift=+0.5em,yshift=-0.5em]GV.south east);
    \end{scope}
    \begin{scope}
      \clip
      ([xshift=+1em]$(CP.east)!0.5!(GV.east)$)
      rectangle
      ([xshift=-1em,yshift=-1em]GV.south west);
      \draw[dashed,thick,gray,rounded corners]
      ([xshift=-0.5em,yshift=+0.5em]CP.north west)
      rectangle
      ([xshift=+0.5em,yshift=-0.5em]GV.south east);
    \end{scope}
    \node
    (P1)
    [above right=0pt of CP.north west,yshift=+0.5em]
    {\Cref{part:classical-processes-revisited}};
    % Part II
    \draw[dashed,thick,rounded corners]
    ([xshift=-8em,yshift=+0.5em]HCP.north west)
    rectangle
    ([xshift=+0.5em,yshift=-0.5em]HGV.south east);
    \node
    (P2)
    [above right=0pt of HCP.north west,xshift=-8em,yshift=+0.5em]
    {\Cref{part:taking-linear-logic-apart}};
    % Part III
    \draw[dashed,thick,rounded corners]
    ([xshift=-8em,yshift=+0.5em]PCP.north west)
    rectangle
    ([xshift=+0.5em,yshift=-0.5em]PGV.south east);
    \node
    (P3)
    [above right=0pt of PCP.north west,xshift=-8em,yshift=+0.5em]
    {\Cref{part:prioritise-the-best-variation}};
    % Legend
    \path let
      \p1 = ([xshift=-0.5em]GV.west),
      \p2 = ([yshift=-0.5em]PGV.south),
    in coordinate (LEGEND) at ({\x1},{\y2});
    \matrix [draw,above right] at (LEGEND.north east) {
      \node [
        shape=circle,
        label=right:{\footnotesize Legend}] {}; \\
      \node [
        shape=circle,
        fill=tysecondarycolor,
        label=right:{\footnotesize No Contribution}] {}; \\
      \node [
        shape=circle,
        fill=tmsecondarycolor,
        label=right:{\footnotesize Partial Contribution}] {}; \\
      \node [
        shape=circle,
        fill=prsecondarycolor,
        label=right:{\footnotesize Full Contribution}] {}; \\
    };
  \end{tikzpicture}
$$
The sole $\tysecondaryname$ box signifies that I do not claim to have made any serious contribution to Classical Linear Logic.
The $\tmsecondaryname$ boxes signify that, while Classical Processes, Good Variation, and Priority CP were not originally developed by me, I have since contributed to these theories in one way or another.
The $\prsecondaryname$ boxes signify that Hypersequent CP, Hypersequent GV, and Priority GV were developed by me and colleagues.

The arrows represent the translations and operational correspondences between the various systems.
The arrows are labelled by the conventional names of these translations.
By convention, any translation from a variant of GV to a variant of CP is denoted by double square brackets with an endpoint name as a subscript, i.e., $\llbracket\cdot\rrbracket_x$, and any translation from a variant of CP to a variant of GV is denoted by double parentheses, i.e., $\llparenthesis\cdot\rrparenthesis$.
The solid arrows---the translation from Hypersequent GV to Hypersequent CP and the translation from Priority CP to Priority GV---and were developed by me and colleagues.
The translations corresponding to the dashed and greyed-out arrows are not discussed in this thesis.

The solid lines represent the extension and non-extension results for the various systems with respect to CP and GV, and were developed by me and colleagues.

The dashed boxes---labelled \Cref{part:classical-processes-revisited}, \Cref{part:taking-linear-logic-apart}, and \Cref{part:prioritise-the-best-variation}---roughly group the systems by the part of this thesis in which they are discussed.
