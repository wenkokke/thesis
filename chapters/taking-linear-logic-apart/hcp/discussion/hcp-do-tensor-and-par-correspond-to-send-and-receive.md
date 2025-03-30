## Do Tensor And Par Correspond To Send And Receive? {#hcp-do-tensor-and-par-correspond-to-send-and-receive}

Reader familiar with CP may be confused at the assertion that tensor captures some notion of *disjointness*, rather than sending.
@Wadler12:cpgv interprets tensor and par as sending and receiving, respectively.
$$
  \cpexp2{\cpSEND*\cpx\cpy\cpP\cpQ\cpGG\cpGD\cpA\cpB\DP}
  \qquad
  \cpexp2{\cpRECV*\cpx\cpy\cpP\cpGG\cpA\cpB\DP}
$$
@CarboneLMSW16:mcp [p. 4-5, *May one invert output and input?*] argue that the inverse interpretation, where tensor is interpreted as receive and par is interpreted as send, is nonsense.
The argument is that a process should change its behaviour based on the information it receives, not the information it sends.
That is a fair argument, but it misses a crucial aspect of @Wadler12:cpgv's interpretations for tensor and par.
The send and receive actions, $\cpexp2{\cpSend\cpx\cpy}$ and $\cpexp2{\cpRecv\cpx\cpy}$, implement a restricted form of delegation, but do not transmit information.
They are about plumbing, not what is in the pipes.[^quote-atkey]
Hence, the argument does not apply.

The crucial part of the interpretation of tensor/par is not the send/receive actions, but the *disjointness* of $\cpexp2{\cpP\cpPar\cpQ}$ and the *jointness* of $\cpexp2{\cpP}$.
Given a channel with endpoints $\cpexp2{\cpx:\cpA\cpTens\cpB}$ and $\cpexp2{\cpx':\cpA\cpParr\cpB}$, the process that holds $\cpexp2{\cpx'}$ determines the order in which the sub-sessions $\cpexp2{\cpA}$ and $\cpexp2{\cpB}$ are resolved.
The process that holds $\cpexp2{\cpx}$ must guarantee that either order works, and the manner in which CP guarantees this is by forcing the sub-sessions to be handled by entirely disjoint processes.

[^quote-atkey]: I'm paraphrasing Robert Atkey, who frequently refers to the function of multiplicative as plumbing or throat-clearing. For a proper quote: "Multiplicatives correspond to matters of communication topology, while the additives will correspond to actual data transfer" [@Atkey17:obs-cp].
