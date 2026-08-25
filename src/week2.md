# Week 2

## Reading

- [Flix: A Design for Language-Integrated Datalog](https://dl.acm.org/doi/10.1145/3763126)

## Extra Reading (PhD Level)

- [Answer set programming at a glance](https://dl.acm.org/doi/10.1145/2043174.2043195) — Brewka et al.

## Slides

<a href="./week2.pdf">
    <img src="./week2-02.png" alt="Download Slides" width="800" height="450"/>
</a>

## Exercises

**Exercise 02.01**: Rewrite the following SQL query:

```sql
SELECT 
    C.CustomerName, O.OrderDate, P.ProductName 
FROM 
    Customers C 
JOIN 
    Orders O ON C.CustomerID = O.CustomerID 
JOIN 
    Products P ON O.OrderID = P.OrderID
WHERE 
    P.ProductPrice > 10;
```

as a Flix function that uses Datalog. 

- The function should use `inject` and `query`.
- The function should take the relevant tables as lists of tuples.
- The function should return a list of tuples.

**Exercise 02.02**: Rewrite the following SQL query as a Flix function:

```sql
SELECT
    S.StudentName,
    C.CourseName,
    MAX(G.Grade) AS HighestGrade
FROM
    Students S
JOIN
    Grades G ON S.StudentID = G.StudentID
JOIN
    Courses C ON G.CourseID = C.CourseID
GROUP BY
    S.StudentID, S.StudentName, C.CourseName
ORDER BY
    S.StudentName;
```

- Define a data type `Grade` which is one of: `-3, 00, 02, 4, 7, 10, 12`. 
- Introduce a lattice on `Grade` with `-3` as the smallest element. 

**Exercise 02.03**: The [Bacon number](https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers) of an actor or actress is the number of
degrees of separation they have from the actor Kevin Bacon. Per Wikipedia:

- Kevin Bacon himself has a Bacon number of `0`.
- Actors who have worked directly with Kevin Bacon have a Bacon number of `1`.
- If the lowest Bacon number of any actor with whom X has appeared in any movie
  is N, X's Bacon number is `N + 1`.

Assume we have a relation `StarsWith(Actor, Actor)`: 

- Write a Flix function to compute the Bacon number of every actor. 

**Exercise 02.04**: Given the Flix expressions:

```flix
let p1 = #{ A(x, y) :- B(x, x), C(y). };
let p2 = #{ C(x) :- F(x, y), G(y, x). };
```

- What are the row types of `p1` and `p2`?

**Exercise 02.05**: Implement Ullman's Algorithm with a Flix function that has
the signature: 

```flix
def ullman(g: List[(String, Bool, String)]): Map[String, Int32]
```

where `g` is the precedence graph represented as a list of edges and where the
Boolean indicates whether an edge is positive (`true`) or negative (`false`).
The function should return a map from each predicate symbol (`String`) to its
stratum. If the precedence graph cannot be stratified, the returned map should
map every predicate symbol to `-1`.

Ullman's Algorithm can be used to determine if a Datalog program is stratified,
and if so, to compute the stratum of each predicate symbol. The algorithm can be
described as follows: 

- If there is a positive edge `A <- B`, then the stratum of `A` must be at
  least the stratum of `B`.
- If there is a negative edge `A <- not B`, then the stratum of `A` must be at
  least the stratum of `B` plus one.
- If we ever encounter a stratum number higher than the number of predicate
  symbols in the program, then the program cannot be stratified.

**Hint:** Use lattice semantics.

**Exercise 02.06**: Rewrite the following SQL query as a Flix function:

```sql
SELECT
    E.EmployeeName,
    D.DepartmentName,
    S.Amount AS LatestSalary,
    S.DateReceived
FROM
    Employees E
JOIN
    Salaries S ON E.EmployeeID = S.EmployeeID
JOIN
    Departments D ON S.DepartmentID = D.DepartmentID
WHERE
    S.DateReceived = (
        SELECT MAX(S2.DateReceived)
        FROM Salaries S2
        WHERE E.EmployeeID = S2.EmployeeID AND S2.DepartmentID = D.DepartmentID
    );
```

**Hint:** Use lattice semantics.

**Hint:** Use `fix` to find the most recent salary per employee.

**Hint:** You will need more than one relation/lattice.

**Exercise 02.07**: Consider the Datalog program:

```flix
    Edge(1, 2). Edge(2, 4). Edge(1, 3). Edge(3, 5). Edge(5, 4).
R1: Path(x, y) :- Edge(x, y).
R2: Path(x, z) :- Path(x, y), Edge(y, z).
```

- Draw two distinct provenance trees for the fact `Path(1, 4)`. Label each
  internal node with the rule (`R1` or `R2`) used to derive it, and mark the
  EDB facts.
- For each of your two trees, write down the provenance path w.r.t. `{Edge}`.
- Flix guarantees that `pquery` computes a provenance tree of *minimal height*.
  Which of your two trees can `pquery pr select Path(1, 4) with {Edge}` return?

**Exercise 02.08**: You are a financial crime investigator tracing laundered
money. Money moves between accounts in three ways:

- `Wire("acme-holdings", "Cayman National Bank", "shellcorp-7", 100)` states
  that money was wired from account `acme-holdings` to account `shellcorp-7`
  through the bank `Cayman National Bank` at time `100`.
- `Cash("alpine-invest", "offshore-trust-x", 550)` states that cash was handed
  over from `alpine-invest` to `offshore-trust-x` at time `550`.
- `Crypto("shellcorp-7", "Binance", "shellcorp-12", 250)` states that money was
  swapped from `shellcorp-7` to `shellcorp-12` on the crypto exchange `Binance`
  at time `250`.

The last component of each fact is a timestamp (a Unix-style integer). You are
given the following transaction log:

```flix
Wire("acme-holdings", "Cayman National Bank", "shellcorp-7", 100).
Wire("shellcorp-7", "Banco General", "tropical-imports", 110).
Cash("tropical-imports", "shellcorp-7", 120).
Wire("nordic-ventures", "LGT Bank", "offshore-trust-x", 150).
Wire("pelican-trading", "Banco General", "shellcorp-12", 210).
Crypto("shellcorp-7", "Binance", "shellcorp-12", 250).
Wire("acme-holdings", "Danske Bank", "nordic-ventures", 300).
Crypto("shellcorp-12", "Kraken", "riviera-estates", 320).
Wire("nordic-ventures", "Danske Bank", "acme-holdings", 350).
Wire("riviera-estates", "HSBC", "luxe-yachts", 380).
Wire("shellcorp-12", "Julius Baer", "alpine-invest", 400).
Cash("alpine-invest", "offshore-trust-x", 550).
```

Write a Flix function:

```flix
def followTheMoney(src: String, dst: String): Vector[String]
```

which documents how money flowed from account `src` to account `dst`, as a
vector of human-readable strings, e.g.
`"acme-holdings wired money to shellcorp-7 via Cayman National Bank"`,
`"tropical-imports handed cash to shellcorp-7"`, or
`"shellcorp-7 swapped crypto to shellcorp-12 on Binance"`.

Your evidence must hold up in court: the transfers must form an unbroken chain
from `src` to `dst`, and money cannot leave an account before it has arrived,
i.e., the timestamps along the chain must be strictly increasing.

Test your function by tracing the money from `acme-holdings` to
`offshore-trust-x`.

**Exercise 02.09**: You are given a database of currency exchange rates, where
a fact `Rate("DKK", "EUR", 0.134)` states that 1 DKK buys 0.134 EUR:

```flix
Rate("DKK", "EUR", 0.134).
Rate("DKK", "SEK", 1.55).
Rate("SEK", "NOK", 0.98).
Rate("EUR", "USD", 1.08).
Rate("EUR", "GBP", 0.85).
Rate("GBP", "USD", 1.27).
Rate("USD", "JPY", 155.0).
Rate("USD", "CHF", 0.88).
Rate("CHF", "EUR", 1.06).
Rate("KRW", "USD", 0.00072).
```

Write a Flix function:

```flix
def convert(amount: Float64, src: String, dst: String): Option[Float64]
```

which converts `amount` from currency `src` to currency `dst`, possibly through
a chain of intermediate currencies, or returns `None` if no conversion chain
exists. The effective rate of a conversion chain is the *product* of the rates
along it.

Test your function by converting 1,000 DKK to USD and 1,000 DKK to KRW.

**(Hard, Optional)**: There are two ways to convert DKK to USD (via EUR, or
via EUR and GBP) with slightly different effective rates. Which one does your
function compute? How could you change the Datalog program such that the
provenance path is guaranteed to be the chain with the *best* effective rate?

**Exercise 02.10**: Given the Flix function signature:

```flix
def reachable(g: Set[(Int32, Int32)], src: Int32, dst: Int32): Bool
```

which takes a graph, represented as a set of edges, and returns `true` if there
is a path from `src` to `dst` in the graph, write three implementations:

- An implementation that uses first-class Datalog constraints.
- An implementation that uses functional programming.
- An implementation that uses imperative programming.

You must test your functions on a non-trivial graph that contains cycles.

**Hint:** You will need to use recursion.

**Hint:** You may want to use `MutSet` or `MutMap` for the imperative version.

**Exercise 02.11**: Reflect on Exercise 02.10:

- Which implementation was the fastest to write?
- Which implementation do you find the most elegant?
- How would you extend the functional and imperative versions with parallelism?

**Exercise 02.12**: Benchmark Exercise 02.10:

- Write a simple benchmark to compare the performance of the three implementations.
