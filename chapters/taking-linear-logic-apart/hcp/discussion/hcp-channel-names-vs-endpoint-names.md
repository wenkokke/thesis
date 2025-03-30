# Channel Or Endpoint Names? {#hcp-channel-names-vs-endpoint-names}

Should names refer to communication channels or to their endpoints? I already revealed my hand in @cp, where CP's names refer to channel endpoints. However, for CP, the choice is not hugely significant. Case in point, names refer to channels in Wadler's CP.

Under the restrictive view, channel names are a natural choice.
Endpoint names are incompatible with the restrictive view, as there is no mechanism to tell us which endpoints are connected to the same channel.
We could introduce such a mechanism.
We could use co-names, where the endpoint name for sending is computed from the endpoint name for receiving by the overbar function, e.g., if $\piexp2{\pix}$ is the endpoint for receiving, then $\piexp2{\bar{\pix}}$ is the endpoint for sending.
We could generalise, and compute the endpoints for any number of participants in a multiparty session from one special endpoint name.
However, such a mechanism invariably requires one special endpoint name from which to compute the others, and is there really any difference between such a special endpoint name and a channel name?

Under the creative view, we have a legitimate choice between channel and endpoint names. Let us consider our options with a few questions.

## How To Connect Two Unconnected Parallel Processes?

Consider the following example:
$$
\piexp2{%
  \piUSend\pia\pic.\piP
  \piPar
  \piRecv\pib\piy.\piQ
}
$$
With channel names, we must rename one of the channels so that their names coincide, then use a name restriction to bind that name---e.g., rename $\piexp2{\pib}$ to $\piexp2{\pia}$, then use the name restriction $\piexp2{\piNew(\pia)}$.
$$
\piexp2{%
  \piUSend\pia\pic.\piP
  \piPar
  \piRecv\pib\piy.\piQ
  \quad\text{to}\quad
  \piUSend\pia\pic.\piP
  \piPar
  \piRecv\pia\piy.\piQ
  \quad\text{to}\quad
  \piNew(\pia)(
    \piUSend\pia\pic.\piP
    \piPar
    \piRecv\pia\piy.\piQ
  )
}
$$
With endpoint names, we only need to use the name restriction $\piexp2{\piNew(\pia\pib)}$.
$$
\piexp2{%
  \piUSend\pia\pic.\piP
  \piPar
  \piRecv\pib\piy.\piQ
  \quad\text{to}\quad
  \piNew(\pia\pib)(
    \piUSend\pia\pic.\piP
    \piPar
    \piRecv\pib\piy.\piQ
  )
}
$$
With channel names, we need renaming to connect the two processes---an operation in the meta-language, which mutates the process to boot---but with endpoint names, name restriction internalises the operation of connection into the object language.

## What Is In A Name?

With channel names, some form of role annotation is necessary to ensure that the various uses of a channel name are coherent.

As discussed, Lπ annotates session types with their role---whether the corresponding channel is used to send, receive, neither, or both.
The typing rule for parallel composition checks that the various roles are coherent---i.e., at most one send and one receive.
The typing rule for name restriction checks that all roles are fulfilled---i.e., there is exactly one send and one receive.

In @LindleyM15:gv's GV, similar role annotations are used.
The typing rule for parallel composition checks that the various roles for *one* channel are coherent, and requires all other channels names are unique. It combines one positive and one negative use of one channel name into one locked use of that channel---i.e., for exactly one channel name $\gvexp2{\gvx}$, $\gvexp2{\gvx:\gvS}$ and $\gvexp2{\gvx:\co\gvS}$ are combined into $\gvexp2{\gvx:\gvtyLock{\gvS}}$.
The typing rule for name restriction checks that all roles are fulfilled---i.e., that the channel is locked.

An early version of HCP [@KokkeMP19:hcp, with errata] used channel names and did not require an explicit role annotation.
However, the typing rule for name restriction does require that each name occur at most twice and with dual types.

With endpoint names, such role annotations are unnecessary, as each endpoint name is associated with a unique role.
The type system checks that all endpoints are used with a coherent set of roles when checking the corresponding ν-binder.
