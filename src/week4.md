# Week 4

## Reading

is for nerds

## Slides

<a href="../futhark.pdf">

## Exercises

For the following exercises, you can play around on
[repl.futhark-lang.org](https://repl.futhark-lang.org/), but you will have a
better experience if you [install Futhark on your own
system](https://futhark.readthedocs.io/en/stable/installation.html). You do not
have to run any of your code on a GPU, and it is discouraged unless it works
immediately, as configuring a GPU development environment is in many cases
nontrivial. In fact, you can just stick to using `futhark repl` and ignore the
questions that ask you to perform benchmarking.

If you use Windows, use WSL. To run compiled code, you must have a C compiler
available in your shell environment.

**Exercise 04.01**:

Create a Futhark function `process : []i32 -> []i32 -> i32` that takes as
arguments two one-dimensional `i32` arrays (signals) of the same length and
computes the maximum absolute difference (pointwise) between the signals (you
should not use Futhark's `loop` construct). The function should return the value
0 if two empty signals are passed to the function.

Consider the following two signals:

```Futhark
def s1 = [23,45,-23,44,23,54,23,12,34,54,7,2, 4,67]
def s2 = [-2, 3,  4,57,34, 2, 5,56,56, 3,3,5,77,89]
```

* What is the result of calling your function on `s1` and `s2`?

**Exercise 04.02**:

We can use `futhark bench` to benchmark Futhark programs. Change the definition
of your `process` function to use `entry` instead of `def` and add the following
stanza to your program:

```
-- ==
-- entry: process
-- random input { [1000000]i32 [1000000]i32 }
```

Then use `futhark bench process.fut` to benchmark your program. You can have
multiple `random input` lines.

* How does your program scale for different inputs? Does it scale as expected,
  even for very small or very large inputs?

**Exercise 04.03**:

Create a version of `process`, called `process_idx : []i32 -> []i32 ->
(i32,i64)`, that also returns the index of the source signals for which the
largest absolute difference is found.

* What is the result of calling your function on `s1` and `s2`?

**Exercise 04.04**:

Inspired by the implementation of `filter` shown in the slides, finish this
implementation of `partition`:

```Futhark
def partition [n] 'a (p: a -> bool) (as: [n]a) : ([]a, []a) =
  ???
```

The intent is that `partition` separates those elements that satisfy a predicate
from those that do not. Example:

```
> partition (\x -> x%2==0) [0,1,2,3,4,5,6,7]
([0, 2, 4, 6],
 [1, 3, 5, 7])
```

While you can implement this as two `filter`s, it can also be done more
efficiently, by being clever about the indexes.

* What is the work and span of your implementation? Is it work-efficient?

</a>

**Exercise 04.05**:

The slides describe how to implement a segmented scan. A similar operation is a
segmented reduction. Finish the following implementation of segmented reduction:

```Futhark
def segreduce [n] 't (op: t -> t -> t) (ne: t)
                     (fs: [n]bool) (vs: [n]t): []t =
  ???
```

* What is the work and span of your implementation? Is it work-efficient?

**Exercise 04.06**:

Implement a function for computing *histograms*:

```Futhark
def histogram [n] (k: i64) (xs: [n]u32) : [k]i64 =
  ???
```

If `H = histogram k xs`, then `H[i]` counts how many occurrences of `i` are
present in `xs`. Any number `x` in `xs` that is not in the range `[0,k-1]` is
ignored.

**Hint:** use a sort followed by a segmented reduction - you will also need to
compute an appropriate flag vector.

**Hint:** use `i64.u32` to convert a `u32` number to `i64`.

**Hint:** Remember that not all buckets of the histogram may be occupied.

* What is the work and span of your implementation? Is is work-efficient?
