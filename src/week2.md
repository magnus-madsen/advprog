## Week 2 ([Reading](#reading) | [Slides](#slides) | [Exercises](#exercises))

### Reading

- [Flix: A Meta Programming Language for Datalog](https://ceur-ws.org/Vol-3203/short8.pdf)
- [Fixpoints for the Masses: Programming with First-Class Datalog Constraints](https://dl.acm.org/doi/10.1145/3428193)
- [Datalog Programming in Flix](#)

### Slides

<a href="./week2.pdf">
    <img src="./week2-02.png" alt="Download Slides" width="800" height="450"/>
</a>

### Exercises

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
    P.ProductPrice > '10'.
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

**Exercise 02.03**: The [Bacon number]([https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers) of an actor or actress is the number of
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
let p2 = #{ C(x) :- F(x, y), G(y, x) }.;
let p3 = p1 <+> p2;
```

- What is the row type of `p1`, `p2`, and `p3`?

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

- If there is a positive edge `A <- B` then the stratum of `A` must be at least
  the stratum of `B`.
- If there is a negative edge `A <- not B` then the stratum of `A` must be at
  least the stratum of `B + 1`.
- If we every encounter a stratum number higher than the number of predicate
  symbols in the program then the program cannot be stratified.

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
        SELECT MAX(S.DateReceived)
        FROM Salaries S
        WHERE E.EmployeeID = S.EmployeeID AND S.DepartmentID = D.DepartmentID
    );
```

**Hint:** Use lattice semantics.

**Hint:** Use `fix` to find the most recent salary per employee.

**Hint:** You will need more than one relation/lattice.

**Exercise 02.07**: Given the Flix function signature:

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

**Exercise 02.08**: Reflect on (Exercise 02.07):

- Which implementation was the fastest to write?
- Which implementation do you find the most elegant?
- How would you extend the functional and imperative versions with parallelism?

**Exercise 02.09**: Benchmark (Exercise 02.07):

- Write a simple benchmark to compare the performance of the three implementations.

**Exercise 02.10**: Compute shortest paths using the rules from the slides
(Attempt III), and the following lattice (which does not cause performance
issues): 

```flix
enum P {
    case Bot
    case Path(Int32, List[Int32])
}
```

**Exercise 02.11**: Extend your solution in (Exercise 02.10) to support graphs
with negative edges (and hence potentially negative cycles).

**Exercise 02.12**: The way we compute shortest paths using lattice semantics
(Attempt II + Attempt III) is technically wrong. What's the problem? 

**Hint:** Does the declarative semantics still coincide with what we want to
compute? What happened?

<!-- Future Idea: Use rho abstraction to split a large program into smaller functions. -->
