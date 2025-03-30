# Introduction

The foundations of functional programming are built on the λ-calculus, a powerful Model of Computation whose canonicity is affirmed by its correspondence with intuitionistic logic.
The foundations of concurrent computation are built on less firm ground.
There is a wide variety of process calculi, but none enjoy the same canonicity as the λ-calculus, nor an exact correspondence with logic.

Since its inception by @Girard87:ll, Classical Linear Logic (CLL) has been believed to have some relation to concurrent computation, which has spawned a wealth of research in both logic and programming language theory.

This thesis continues the work towards a foundation for concurrent computation, starting from the propositions-as-sessions correspondence proposed by @Wadler12:cpgv.

- Drawing on the work of @Abramsky94:proofs-as-processes, @BellinS94:pi-calculus, and @CairesP10:pidill, among others, Wadler proposed the process calculus Classical Processes (CP), which has an exact correspondence with Classical Linear Logic.
- Drawing on the work of @Honda93:session, @HondaVK98:session, and @GayV10:last, among others, Wadler proposed the session-typed functional language Good Variation (GV), which provides a practical foundation for session-typed concurrency in functional languages.
- Finally, Wadler connects GV and CP by means of an operational correspondence, and, thereby, connects practice of session-typed concurrency to Classical Linear Logic.

The names CP and GV are unstated homages to the authors of the work that inspired them:
Classical Processes was based on πDILL by @CairesP10:pidill [later @CairesPT16:pidill-ext]; and
Good Variation was based on LAST by @GayV10:last [the name LAST was given by @LindleyM15:gv].

Let us start by discussing @Wadler12:cpgv's propositions-as-sessions correspondence at a glance.
The paper contains two separate correspondences:

1.  CP demonstrates that the original and most well-known sequent calculus for full CLL, exactly as presented by @Girard87:ll [pp. 22 and 26-27], can be interpreted as something that syntactically resembles a process calculus. I intentionally avoid calling CP a process calculus---whether or not it *is* is debatable---but it can hardly be denied that CP *looks* like a process calculus.

2.  GV, together with the translations from GV to CP [@Wadler12:cpgv, § 3.1; @LindleyM15:gv, § 3.2] and from CP to GV [@LindleyM15:gv, § 3.1], demonstrates an operational correspondence between CLL and a session-typed concurrent λ-calculus.

Only the first---the correspondence between CLL and CP---is one that I would characterize as a Curry-Howard correspondence:

- It relates a logic and a typed Model of Computation.
- It is complete. Propositions correspond to types, proofs correspond to processes, and cut elimination corresponds to computation.[^cp-incomplete]
- It is exact. Going from the logic to the Model of Computation, and vice versa, requires no hard work. It is simply a change of notation.

The correspondence is not a *profound coincidence*.
CP was *intentionally constructed* to correspond to CLL.
Moreover, its inspiration, πDILL, was intentionally constructed to correspond to DILL.
A constructed correspondence undermines what is arguably the most important role of Curry-Howard correspondences.
It does nothing to reassure us that either system is profound, in the sense of a correspondence between two systems that were independently devised.

One could argue that these correspondences relate the π-calculus to linear logic---in which case they would be profound---but I believe CP and πDILL are too far removed from the π-calculus for this to be true.

Having rejected these correspondences as profound coincidences, let us take a different view:
CP *anticipates* a Curry-Howard correspondence.
The typed λ-calculus, the most popular typed Model of Computation, corresponds exactly to intuitionistic logic.
Linear logic has been said to be relevant to concurrent computation since its inception.
So why not cut out the middle-man of independent discovery and directly employ linear logic as a typed Model of Concurrent Computation (MoCC)?

To evaluate whether or not CP is successful under this particular view, we must examine what we want from a typed MoCC:

- What is the intended purpose for our typed MoCC?
- Do we want our typed MoCC to be as expressive as the π-calculus?
- What properties do we want our typed MoCC to have?

To me, the purpose of a type system is to rule out erroneous programs.
The price of a type system is *necessarily* a reduction in expressivity---for the silly reason that we can no longer express erroneous programs, and for the serious reason that the exact boundary between erroneous and non-erroneous is difficult to capture.

- I do not want to evaluate programs with data-type errors such as `"hello" + true`.
  The price paid is more difficulty with code reuse [see, e.g., @McBride10:ornaments; @Dagand14:transporting-across-ornaments; @Stump17:cedille]

- I do not want to evaluate programs that loop indefinitely, such as `x = x`.
  The price paid is more difficulty with recursive algorithms
  due to the undecidability of the halting problem [@Davis52:haltingproblem;@Kleene52:metamath; @Davis58:unsolvability].
- I do not want to evaluate programs that deadlock.
  The price paid is more difficulty with certain concurrent communication structures.

It seems unreasonable to expect our typed MoCC to be as expressive as, say, the π-calculus, simply because the π-calculus includes all of the above erroneous behaviors.
However, this raises an important question:
What behaviors are erroneous?

Let us consider @Mazza18:confusion-free, who paints a pessimistic picture of the "proofs as processes" program.
They argue that neither CLL nor DiLL[^DiLL-vs-DILL] [Differential Linear Logic, @EhrhardR06:din;@Ehrhard18:dll] can satisfactorily encode even an elementary process calculus, as neither can express *confusion*---a kind of non-local non-determinism in which two communications mutually exclude each other.
This raises an immediate question: *Do we want confusion?*
The question alone elicits an immediate and visceral "No!" from the audience, but once our gut reaction subsides, we should evaluate the question formally.

@Mazza18:confusion-free demonstrates that confusion is present in even the most elementary MoCCs, and that confusion is preserved by any encoding that preserves the degree of distribution---i.e. any encoding that is a homomorphism on parallel composition.
Therefore, there exists a class of processes for which we must choose (a) to allow confusion, or (b) to accept a reduction in the degree of distribution.
Networking algorithms commonly allow for confusion---e.g., *leader election* only requires that *some* leader is elected. Therefore, I do not feel comfortable rejecting confusion outright.
However, accepting confusion means rejecting strong normalization and the Church-Rosser property.
To me, those properties are synonymous with safety, and I cannot reject them outright either.

We may want to allow our programming languages to write programs with local non-determinism or confusion, but we should never allow the programmer to write such a program *by accident*.
This seems to require that we capture programs with these properties using some modality.
CLL captures non-linearity using the exponentials.
DiLL captures failure and local non-determinism using the co-exponentials.
I choose not to commit to the wholesale acceptance or rejection of non-determinism and confusion.
Rather, my stance is that all is not lost if our typed MoCC does not support confusion.
We have simply taken the first step on our journey of trying to claw back the steep price we paid for types.

[^DiLL-vs-DILL]: Note that DiLL refers to Differentiable Linear Logic, whereas DILL refers to Dual Intuitionist Linear Logic. The only difference in writing is the capitalization of the "i". Presumably, both are pronounced like the herb.

Dependently-typed λ-calculus recovers a lot of the expressivity of the λ-calculus by allowing output data to depend on input data.
For instance, it can express any recursive function whose termination can be proved within the type system of the calculus itself.
It stands to reason that a typed process calculus could likewise recover expressivity by allowing the present communication structure of a program to depend on the past communication structure.

I would argue that to build a dependently-typed process calculus, we need the solid foundation of a simply-typed process calculus.
I believe---and intend to convince you in this thesis---that the simply-typed fragment of CP is not yet the solid foundation we are looking for.

- The correspondence between CP and process calculus is lacking, because CP does not easily admit a behavioural theory, e.g., a labelled-transition system and a behavioural equivalence.
- The correspondence between CP and CLL is lacking, because the sequent calculus for CLL is not the canonical proof theory. Proof nets are the canonical representation of CLL proofs! This is an issue with CP as a typed MoCC, because the sequent calculus has a lower degree of distribution than the proof nets.
- CLL itself is lacking as a foundation for a typed MoCC. It does not describe non-determinism, unlike DiLL [@Ehrhard18:dll]. It describes parallelism as independence, and its dual as dependence, but cannot describe sequential dependence, unlike Pomset Logic [@Retore97:pomset] and BV [@Guglielmi07:sis].

The first assignment Philip Wadler gave me as my Ph.D. supervisor was to add support for non-determinism to CP. I did, albeit poorly [@Kokke17:msccpnd].
However, while doing so, I discovered more ways in which CP is lacking as a process calculus.
Since CP does not have a standalone process construct for parallel composition, the extension I introduced has *three different* process constructs that contain a parallel composition (two inherited from CP, and a third that permits non-determinism).
Parallel composition is the most crucial connective in a process calculus.
Not having it as a standalone process construct in CP is untenable.
Consequently, I pivoted to restructuring CP to include parallel composition as a standalone process construct and tighten its correspondence with the π-calculus, while retaining its tight correspondence with CLL.
This work is the principal focus of this thesis and is presented in @hcp and @hgv.
At times, I will allude to the second and third points, and arguably some of the work on priorities in @priorities applies to the third point. However, I consider them out of scope for this thesis, as I believe that each could correspond to several theses in their own right.

The result should, at least at its core, be a conservative extension of CP.
There are three main reasons for wanting this.

1.  It retains some correspondence with Classical Linear Logic, even if the correspondence is no longer as obvious as in @Wadler12:cpgv's case.
2.  It ensures that any previous work on CP, such as @Wadler12:cpgv's work on polymorphism and unrestricted usage and @LindleyM16:recgv's work on fixed points, carries over without too much trouble.
3.  It eases the future integration of the features offered by DiLL, Pomset Logic, and BV, since these logics are all extensions of CLL.

As I mentioned, my first assignment was to add support for non-determinism to CP, which I did, though in a manner I have always found unsatisfactory [@Kokke17:msccpnd].
Later, @Qian21:llnd found the exact structure I was looking for.
In hindsight, the answer was there all along, in logic!
DiLL extends CLL with co-exponentials, which make cut elimination non-deterministic [@Ehrhard05:fs;@Ehrhard18:dll].
@Qian21:llnd's work, which extends CP with DiLL's co-exponentials, uses the work on hypersequents presented in @hcp.

<!-- Let us turn our attention to GV. -->

What role does GV play in the propositions-as-sessions correspondence?
CP demonstrates a correspondence between a process calculus and CLL---a correspondence so exact that it requires no proof---but CP is unsatisfactory as a foundation for a programming language for one simple reason:
CP does not have functions.
In CLL, everything is defined in terms of duality.
This matches well with session types and channel-based communication, where two processes act in dual ways, but does not match well with functions.
CLL's implication is *classical*, and does not lend itself to an interpretation as a function type.
A significant portion of programming language theory is built on the foundations of functions and the λ-calculus.
Hence, adopting CP as the foundation for concurrent programming means parting ways with a significant body of work.

In essence, GV extends CP with functions.
Extending CP with a function type requires extending CLL with an intuitionistic implication, which is more complicated than simply adding a connective, as CLL's sequents are fundamentally classical.
There are some approaches to mixing classical and intuitionistic connectives in the literature on logic, such as Display Logic [@Belnap82:dl].
However, none of these approaches have the widespread acceptance of CLL, nor are they easily amenable to a term calculus.
Instead, @Wadler12:cpgv approaches GV from the perspective of concurrent λ-calculus, and adapts @GayV10:last's LAST [@GayV10:last] to fit a correspondence with CP.
From a theoretical viewpoint, GV embeds an axiomatisation of CP into the linear λ-calculus using constants.
From a practical viewpoint, GV resembles the way in which concurrency is exposed to the user in real-world programming languages, such as the POSIX Threads API for the C programming language.
GV offers the user an API---a collection of constant functions which create threads and channels, send messages, etc---but concrete threads, parallel composition, and name restriction are not representable in the static language.
The user cannot write a program that *is* the parallel composition of two processes, only a program which creates that configuration.
This makes it very easy to implement GV's safe concurrency primitives as a library in existing programming languages, on top of the language's unsafe concurrency primitives, and doubly so if the languages already supports some form of linear types [see, e.g., @LindleyM16:esh;@Kokke19:sesh;@KokkeD21:priority-sesh].

To put it plainly, CP is a theoretical tool for studying foundational well-behaved concurrent systems, but GV is what you actually implement.

What role does the correspondence between CP and GV play?
@Wadler14:cpgv-ext [p. 385] writes that the correspondence formalises, for the first time, "a tight connection between a standard presentation of session types and linear logic", which formally confirms the previously assumed connection.
However, this leaves us with a question.
Now that the connection is formally confirmed, what is the purpose of continuing to maintain the correspondence as we make changes to CP and GV?
I am motivated to do so for two reasons.

Firstly, an exact correspondence, especially one that preserves parallel composition, reassures us that GV is correct, in that the communication primitives of GV capture the same communication structures as CP.
Unfortunately, constructing an exact correspondence requires some amount of tedium, as one must show that CP's communication channels can correctly emulate GV's functions and data structures. This is well-established and an area of GV significantly less likely to contain mistakes---or, at least, mistakes that are easily caught by a translation into process calculus.
Consequently, any part of GV that does not interact with concurrency should be omitted from the correspondence.[^gv-minimal]
To further simplify the correspondence, the translation from GV to CP is commonly factored into two translations: a translation from GV into fine-grain GV, which removes higher-order control flow; and a translation from fine-grain GV into CP.[^gv-decomposed-translation]

Secondly, the translations between CP and GV are helpful in guiding you to the correct typing and implementation of new concurrency primitives.
For instance, @Wadler14:cpgv-ext [p. 409] considers several alternative designs, but remarks that "these designs are difficult to translate into CP, which suggests they may suffer from deadlock." Indeed, the suggested alternatives *do* suffer from deadlock.
Hence, by following the translation, Wadler correctly chose to abandon alternative concurrency primitives, even though they appear more principled.

[^gv-ad-nauseam]: I assume that @Wadler12:cpgv did not intend for a name as cumbersome as Good Variation to be used in full, but I will choose to use it *ad nauseam*.
[^cp-incomplete]: The correspondence between CP and CLL is actually incomplete, in the sense that the structural congruence of CP does not correspond to anything in CLL. The equations of the structural congruence are merely valid rewrite rules for proofs. This is easily missed: λ-calculus does not have a structural congruence, and as such the list of correspondences for CP looks as complete as the list for the Curry-Howard correspondence.
[^gv-minimal]: @Wadler12:cpgv's GV only has the concurrency primitives, product types---which are used to type the receive primitive---and the unit type---which is used to type the primitive that closes a channel.
@LindleyM14:sap add polymorphism and replicated sessions to GV, which correspond to CP's polymorphism and exponentials.
@LindleyM15:gv add sum types to GV, which are used to replace the concurrency primitives for choice by simply sending and receiving a value of a sum type.
[^gv-decomposed-translation]: The clearest presentation of this decomposed translation can be found in @FowlerKDLM23:hgv-ext, which will be presented in @hgv, but its origins can be traced back all the way to @LindleyM14:sap, where fine-grain GV is referred to as HGVπ. (Note that the "H" in HGVπ stands for "Harmonious", not "Hypersequent" as in @hgv.).
