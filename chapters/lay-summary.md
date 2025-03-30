# Lay Summary {#lay-summary}

In recent decades, programming languages have widely adopted *data type checking*, which are a mechanism that helps programmers write safe and secure programs by ruling out data errors.
An example of a *data error* would be if the program that manages bank accounts handled the account balance as text rather than as a number.
If my balance is £50 and I deposit £20, I would expect my balance to become £70, not the text '5020'.

When a programming language is designed with care, it is possible to automatically determine if a program is free from data errors by checking the types of ways in which some data is handled (data types) against each other (e.g., the account balance is handled as a number here but as text there) or against the programmer's stated intention (e.g., the account balance is handled as text, but the programmer stated that it should always be handled as a number).

With the rise of the internet and the end of Moore's Law, *concurrent programs* are becoming increasingly important.
A concurrent program consists of multiple processes that run at the same time and may share resources or communicate by passing messages.
Examples include your browser communicating with a server, an ATM communicating with a bank, and the thousands of graphics processors involved in rendering your favourite game.

Concurrent programs are vulnerable to erroneous behaviours that cannot be prevented by data types.
For an example of such an error, let us consider what would happen if the program that manages bank accounts handled each deposit or withdrawal in three steps: (1) read the current balance, (2) calculate the updated balance by adding the amount deposited or subtracting the amount withdrawn, and (3) write the updated account balance.
If the account balance for the joint account that I share with my partner is £100, I use one ATM to deposit £60, and my partner uses another ATM to withdraw £50, then we would expect our balance to become £110.
If the two interactions happen in sequence, this is what happens. However, each ATM reads and writes the account balance separately, and these reads and writes may be interleaved in any order:

- If my ATM reads the initial balance of £100, then my partner withdraws £50, and then my ATM writes the updated balance of £100 plus the deposited £60, the final balance becomes £160.
- If my partner's ATM reads the initial balance of £100, then I deposit £60, and then my partner's ATM writes the updated balance of £100 minus the withdrawn £50, the final balance becomes £50.

This kind of error is known as a *race condition*.
Race conditions are difficult to diagnose since, while the program is fundamentally incorrect, the erroneous behaviour might not happen most of the time. After all, how often do my partner and I use our joint account at exactly the same time?
So if I, unaware of my partner's simultaneous withdrawal, call my bank to complain that "I deposited £60, but my balance went down!", an engineer might test the bank's program by depositing £60, see the account balance go up, and conclude that everything is working as intended.

*Behavioural type checking* is a mechanism which aims to rule out race conditions and other such erroneous behaviours.
Whereas data types describe the way that a program must always handle some data (e.g., the account balance must always be handled as a number),
behavioural types describe the evolving way a program must interact with its environment over time (e.g., usually, the bank's program should accept any request for a transaction, but while a transaction is ongoing, it should not accept requests for other transactions on the same account).

Most mainstream programming languages do not support behavioural types and, as such, it is not generally possible to automatically determine if a program is free from behavioural errors.
In practice, writing correct concurrent programs comes down to the programmer correctly reasoning about how multiple processes might interact and correctly diagnosing and repairing errors, both of which are incredibly difficult tasks.

One reason that behavioural types have not yet seen widespread mainstream adoption is that the mathematical foundation underlying them is several decades younger and less well understood than the mathematical foundation underlying data types.

In this thesis, I investigate several proposed theories that could become the mathematical foundation underlying behavioural types for message-passing communication in concurrent programs.
I identify several shortcomings in the proposed theories and, on the basis of my findings, propose a new mathematical foundation for behavioural types.
I develop the theory necessary to integrate the proposed behavioural types into existing programming languages and describe a proof of concept implementation.
