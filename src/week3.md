## Week 3 ([Reading](#reading) | [Slides](#slides) | [Exercises](#exercises))

### Reading

- [An Introduction to Prolog Programming](https://staff.fnwi.uva.nl/u.endriss/teaching/prolog/prolog.pdf) - Ulle Endris
  - (Chapter 1, Chapter 2, Chapter 3)

### Slides

<a href="./week3.pdf">
    <img src="./week3-02.png" alt="Download Slides" width="800" height="450"/>
</a>

### Exercises

**Exercise 03.01**: Get the Wolf, Goat, and Cabbage program to run.

**Exercise 03.02**: Extend the Wolf, Goat, and Cabbage program with an Island
(`I`) where the farmer, wolf, goat, and cabbage can move to. Add relevant rules
for `move` and `safe`. Does it change the possible solutions to the problem? 

**Exercise 03.03**: Write a Prolog program that does not terminate.

**Exercise 03.04**: Write a Datalog program that does not terminate when run with Prolog.

_From now on, the Prolog programs you write should always terminate._

**Exercise 03.05**: The natural numbers are defined as:

```prolog
nat(z).
nat(s(X)) :- nat(X).
```
Implement the following relations on natural numbers: `+`, `-`, `*`, `<=` and `min`.

**Exercise 03.06**: In a functional programming language, we cannot define
subtraction in terms of addition. Describe how Prolog allows such a definition
and implement it. 

**Exercise 03.07**: Use Prolog to determine if the following equations have a solution:

- `x = 1 + 2`
- `x + 2 = 3`
- `x * x + 1 = 5`
- `x <= min(x, y)`

where `x` and `y` are natural numbers.

**Exercise 03.08**: Implement `odd(X)` and `even(X)` to determine if a number is
odd or even.

**Exercise 03.09**: Implement the Fibonacci function. 

**Exercise 03.10**: Implement `prefix(Xs, Ys)` and `suffix(Xs, Ys)` to determine
whether the list `Xs` is a prefix or suffix of `Ys`.

**Exercise 03.11**: Implement `prefix` and `suffix` in terms of `append`.

**Exercise 03.12**: Implement `memberOf` in terms of `append`.

**Exericse 03.13**: Implement two versions of `reverse`, one using `append` and
one using an accumulator. Draw the proof trees produced by each on a small list.

**Exercise 03.14**: Implement `substitute(A, B, Xs, Ys)` which relates `Xs` to
`Ys` such that every occurrence of `A` in `Xs` is replaced by `B` in `Ys`.

**Exercise 03.15**: A binary tree of natural numbers can be defined as:
```prolog
tree(leaf).
tree(node(X, N, Y)) :- nat(N), tree(X), tree(Y).
```
- Assume the tree is *unsorted*, compute if it contains a given number.
- Assume the tree is *sorted*, compute if it contains a given number.
- Compute the minimum and maximum height of a tree.
- Compute the sum of the elements of a tree.
- Translate a tree to a list using a pre-, in-, and post-order traversal.

**Exercise 03.16**: The following definition of `remove` for lists is incorrect.
Fix it:

```prolog
remove(x, [], []).
remove(x, [x | ys], rs) :- remove(x, ys, rs). 
remove(x, [y | ys], rs) :- remove(x, ys, rs).
```

**Exercise 03.17**: For each pair of terms, manually compute a unifying
substitution, or report if unification is impossible.

- `unify(42, 42)`
- `unify(21, 42)`
- `unify(X, 42)`
- `unify(42, X)`
- `unify(X, Y)`
- `unify(X, X)`
- `unify(leaf, leaf)`
- `unify(X, node(X, 21, X))`
- `unify(X, node(Y, 21, Z))`
- `unify(node(leaf, X, leaf), node(leaf, 42, leaf))`
- `unify(node(X, Y, leaf), node(leaf, Z, leaf))`
- `unify(node(X, Y, X), node(node(leaf, 42, leaf), 21, leaf))`
- `unify(node(X, Y, Z), node(node(leaf, 42, leaf), 21, Z))`
- `unify([X], [1, 2, 3])`
- `unify([X, Y, Z], [Z, X, Y])`
- `unify([[X], Y], [Y, [2, 3]])`
- `unify([X, Y], [1, [2, 3]])`
- `unify([X, Y], [1, [X, 3]])`
- `unify([X, [Y]], [1, [X, [Y]]])`

**Exercise 03.18**: Describe why the *occurs check* is is necessary in the
unification algorithm.   

**Exercise 03.19**: When would you use Datalog to solve a programming problem? And Prolog?
