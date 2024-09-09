## Week 1 ([Reading](#reading) | [Slides](#slides) | [Exercises](#exercises))

### Reading

- [What you always wanted to know about Datalog (and never dared to ask)](https://dl.acm.org/doi/abs/10.1109/69.43410) 
  - (Section I, Section II: A-D, Section VI: A-C)
- [Datalog and Logic Databases](https://link.springer.com/book/10.1007/978-3-031-01854-1)
  - (Chapter 1, Chapter 2, Chapter 3, Chapter 4.1-4.3)

### Slides

<a href="./week1.pdf">
    <img src="./week1-02.png" alt="Download Slides" width="800" height="450"/>
</a>

### Exercises

**Exercise 01.00**: Follow the [Get Started with Flix](https://doc.flix.dev/getting-started.html) tutorial.

**Exercise 01.01**: Given the Datalog program:

```datalog
Father(child, dad) :- Parent(child, dad), Male(dad).
Mother(child, mum) :- Parent(child, mum), Female(mum).
```

- (a) Describe, in your own words, what the program computes.
- (b) Add some `Parent`, `Male`, and `Female` facts to the program.
- (c) Extend the program to compute brothers and sisters. 
- (d) Extend the program to compute uncles and aunts.

**Hint**: You may use your own family tree or [The
Simpsons](https://www.pinterest.com/pin/631348441484389501/) family tree.

**Hint**: The `Brother` and `Sister` relations should have two arguments.

**Exercise 01.02**: Describe the difference between the two Datalog programs:

```datalog
Happy(person) :- Rich(person), Famous(person).
```

and

```datalog
Happy(person) :- Rich(person).
Happy(person) :- Famous(person).     
```

**Exercise 01.03**: Identify the [syntactic
categories](https://en.wikipedia.org/wiki/Syntactic_category) of the Datalog
program:

```datalog
Rich("Tom Hanks").
Famous("Tom Hanks").
Happy(person) :- Rich(person), Famous(person).
```

**Hint**: The syntactic categories are _programs_, _constraints_, _facts_,
_rules_, _head/body atoms_, _predicate symbols_, _terms_, _variables_, and
_constants_. Here is a template to get you started:

- `"Tom Hanks"` is a ... which is a ...
- `Rich` is a ...
- `Rich("Tom Hanks")` is a ...
- `Rich("Tom Hanks").` is a ... which is a ...
- ...

**Exercise 01.04**: Given the following facts about roads, bridges, and flights:

```
Road("Aarhus", "Vejle").
Road("Aarhus", "Aalborg").
Road("Aalborg", "Skagen").
Road("Billund", "Vejle").
Road("Odense", "Vejle").
Road("Odense", "Nyborg").
Road("Helsingør", "København").
Road("Helsingborg", "Malmø").
Road("Korsør", "Nyborg").
Road("Korsør", "Roskilde").
Road("København", "Roskilde").
Road("Rønne", "Nexø").

Bridge("Storebælt", "Korsør", "Nyborg").
Bridge("Øresund", "København", "Malmø").
Bridge("Nivå", "Helsingborg", "Helsingør").

Flight("Aalborg", "København").
Flight("Aarhus", "København").
Flight("Billund", "København").
Flight("København", "Rønne").
```

Assume all roads, bridges, and flights are bi-directional. For example, if there
is a flight from `Aalborg` to `København` then there is also a flight from
`København` to `Aalborg`. 

- (a) Compute a relation `Drivable(src, dst)` which captures every city where
  one can drive from `src` and reach `dst` using only roads (i.e. without using
  bridges or taking flights). 
- (b) Use `Drivable` to determine every city one can drive to from `Odense`.
- (c) Compute a relation `DrivableWithBridges(src, dst)` which allows using
  roads and bridges. 
- (d) Use `DrivableWithBridges` to compute every city one can drive to from
  `Skagen`.
- (e) Compute a relation `Reachable(src, dst)` which captures every city which
  one can reach by driving (via roads and bridges) and then taking a flight. But
  importantly, after taking a flight, one cannot drive further (since a car will
  not fit in the overhead bin). 
- (f) Use `Reachable` to determine if it is possible to travel from `Nexø` to
  `Aalborg`? And what about the other direction, from `Aalborg` to `Nexø`? 

**Hint:** Lillebælt is beneath our notice.

**Hint:** You must ensure that roads, bridges, and flights are bi-directional.

**Exercise 01.05**: For each constraint, determine whether it is *ground*:

```datalog
Father("Luke Skywalker", "Darth Vader").
Fruit("Apple", color).
Fruit("Apple", "Red").
Tasty(food) :- Flavor(food, "sweet").
```

**Exercise 01.06**: For each constraint, determine whether it is *safe* or *unsafe*:

```datalog
Vegetable("Potato", color).
Sage(person) :- Wise(person), Old(person).
Imperium(person) :- Consul(person, year).
Manager(boss, employee) :- Worker(employee).
```

**Exercise 01.07**: Given the Datalog program:

```datalog
Fruit("Apple", "Green").
Fruit("Banana", "Yellow").
Fruit("Strawberry", "Red").
Vegetable("Tomato", "Red").
```

What is its *Herbrand Universe* and the *Herbrand Base*?

**Hint:** The Herbrand Base will be large. You may want to write them up in a table.

**Note**: You do not have to submit the complete table. An excerpt is sufficient.

**Exercise 01.08**: Given the Datalog program:

```datalog
Loves("Rose", "Jack").
Loves("Jack", "Rose").
Loves("Caledon", "Rose").
Happy(x) :- Loves(x, y), Loves(y, x).
```

What are all the possible the interpretations?

**Hint**: There are many. You may want to write them up in a table. 

**Note**: You do not have to submit the complete table. An excerpt is sufficient.

**Exercise 01.09**: Given the Datalog program above with the interpretation:

```datalog
I = { Loves("Rose", "Jack"), Loves("Caledon", "Caledon"), Happy("Rose") }
```

which of the following ground atoms and ground rules are true under the interpretation:

```datalog
Happy("Rose")?
Happy("Jack")?
Happy("Caledon")?
Loves("Rose", "Jack")?
Loves("Jack", "Caledon")?
Happy("Rose") :- Loves("Rose", "Jack"), Loves("Jack", "Rose")?
Happy("Jack") :- Loves("Rose", "Jack"), Loves("Caledon", "Caledon")?
Happy("Caledon") :- Loves("Caledon", "Caledon"), Loves("Caledon", "Caledon")?
```

**Exercise 01.10**: Given the Datalog program above which of these
interpretations are *models*?

```
I1 = { Loves("Rose", "Jack") }

I2 = { Loves("Rose", "Jack"), Loves("Jack", "Rose"), Loves("Caledon", "Rose") }

I3 = { Loves("Rose", "Jack"), Loves("Jack", "Rose"), Loves("Caledon", "Rose"),
       Happy("Rose")}

I4 = { Loves("Rose", "Jack"), Loves("Jack", "Rose"), Loves("Caledon", "Rose"),
       Happy("Rose"), Happy("Jack") }

I5 = { Loves("Rose", "Jack"), Loves("Jack", "Rose"), Loves("Caledon", "Rose"),
       Happy("Rose"), Happy("Jack"), Happy("Caledon") }
```

and which model is minimal?

**Exercise 01.11**: Given the Datalog program:

```
God("Odin").
Son("Odin", "Thor").
Son("Odin", "Baldr").
Son("Thor", "Mothi").
Son("Thor", "Magni").
DemiGod(x) :- Son(y, x), God(y).
Mortal(x) :- Son(y, x), DemiGod(y).
```

- Compute its minimal model using the immediate consequence operator Tp.
- Show the facts inferred in each iteration.

**Exercise 01.12**: It is said that [all roads lead to
Rome](https://en.wiktionary.org/wiki/all_roads_lead_to_Rome). But what about
roads on islands? 

Given the following road facts (which should again be understood as
bi-directional):

```datalog
Road("Brundisium", "Capua").
Road("Brundisium", "Tarentum").
Road("Capua", "Tarentum").
Road("Capua", "Rome").
Road("Genua", "Massilia").
Road("Genua", "Pisae").
Road("Genua", "Parma").
Road("Messana", "Syracuse").
Road("Ostia", "Rome").
Road("Parma", "Ravenna").
Road("Pisae", "Ravenna").
Road("Pisae", "Rome").
```

Compute all pairs of cities `(s, t)` which are connected by a road that *passes
through* `Rome`.

**Hint:** If your solution includes `Messana` or `Syracuse` it is wrong!

**Exercise 01.13**: Given the following facts about compilers and interpreters:

```datalog
/// Available hardware.
Machine("x86").
Machine("x64").

// Available interpreters (JITs).
Interpreter("JavaScript", "C++").  // A JavaScript interpreter written in C++.
Interpreter("JVM", "C++").
Interpreter("WASM", "C++").

// Modern compilers.
Compiler("C", "x86", "C").
Compiler("C", "x64", "C").
Compiler("C++", "x86", "C").       // A compiler from C++ to x86 written in C.
Compiler("C++", "x64", "C").
Compiler("Flix", "JVM", "Scala").
Compiler("Java", "JVM", "Java").
Compiler("Rust", "x64", "Rust").
Compiler("Rust", "x86", "Rust").
Compiler("Rust", "WASM", "Rust").
Compiler("Scala", "JVM", "Scala").
Compiler("Scala", "JavaScript", "Scala").

// Bootstrap compilers.
Compiler("C", "x86", "x86").
Compiler("OCaml", "x86", "C").
Compiler("Java", "JVM", "C").
Compiler("Scala", "JVM", "Pizza").
Compiler("Pizza", "JVM", "Java").
Compiler("Rust", "x86", "OCaml").
```

- (a) What languages can we run (i.e. using any combination of compilers and interpreters)?
- (b) What source language(s) can compile to what target language(s)?
- (c) Can we run the `Flix` compiler on the web (i.e. on `JavaScript` or `WASM`)?
- (d) Can we run `Flix` programs on the web (i.e. on `JavaScript` or `WASM`)?

**Hint:** Remember that you can compile compilers!

**Exercise 01.14** A student was asked to write a Datalog program to compute
orphans and wrote: 

```datalog
Orphan(c) :- Person(c), Person(p), not Parent(c, p). 
```

Initially, the program seemed to work fine, but later, when the student added
additional facts the program started to give wrong answers.

- (a) Give a collection of facts that show the program is broken.
- (b) Describe why the program is incorrect.
- (c) Fix the program such that it correctly computes orphans.

**Exercise 01.15**: Determine if the Datalog program:

```datalog
Undead(x)  :- Ghost(x).
Undead(x)  :- Vampire(x).
Alive(x)   :- Human(x), not Undead(x).
Mortal(x)  :- Human(x), Alive(x).
Ghost(x)   :- Human(x), not Alive(x), not Vampire(x).
Vampire(x) :- Human(x), Bitten(x, y), Vampire(y), not Ghost(x).
```
is stratified. If so, compute its stratification.

**Exercise 01.16**: Determine if the Datalog program:

```datalog
A(x) :- B(x), C(x), D(x), E(x).
B(x) :- C(x).
C(x) :- A(x), E(x).
E(x) :- D(x), not D(x).
D(x) :- A(x).
```

is stratified. If so, compute its stratification.

**Exercise 01.17**: Given the movie facts:

```datalog
Movie("Reservoir Dogs", "Action").
Movie("Pulp Fiction", "Action").
Movie("Apocalypse Now", "War").
Movie("The Godfather", "Crime").

StarringIn("Reservoir Dogs", "Steve Buscemi").
StarringIn("Reservoir Dogs", "Michael Madsen").
StarringIn("Reservoir Dogs", "Harvey Keitel").
StarringIn("Reservoir Dogs", "Quentin Tarantino").

StarringIn("Pulp Fiction", "John Travolta").
StarringIn("Pulp Fiction", "Samuel L. Jackson").
StarringIn("Pulp Fiction", "Uma Thurman").
StarringIn("Pulp Fiction", "Bruce Willis").
StarringIn("Pulp Fiction", "Quentin Tarantino").

StarringIn("Apocalypse Now", "Martin Sheen").
StarringIn("Apocalypse Now", "Marlon Brando").
StarringIn("Apocalypse Now", "Francis Ford Coppola").

StarringIn("The Godfather", "Al Pacino").
StarringIn("The Godfather", "Marlon Brando").
StarringIn("The Godfather", "Robert de Niro").

DirectedBy("Reservoir Dogs", "Quentin Tarantino").
DirectedBy("Pulp Fiction", "Quentin Tarantino").
DirectedBy("Apocalypse Now", "Francis Ford Coppola").
DirectedBy("The Godfather", "Francis Ford Coppola").
```

Write Datalog programs to compute:

- (a) All movies where the director appears in the movie.
- (b) All movies where the director does not appear in the movie.
- (c) All directors that appear in every movie they have made.


**Hint:** Use negation.

**Hint:** For (c), find directors that have directed movies in which they do not appear.

**Exercise 01.18** (The Drinkers Problem): Given the relations:

```datalog
Drinks(person, beer).
Frequents(person, bar).
Serves(bar, beer).
```

Write Datalog programs to compute:

- (a) All persons that frequents some bar that serve a beer they like.
- (b) All persons that frequents some bar that serve some beer they don’t like.
- (c) All persons that frequents some bar that serve only beer they don’t like.
- (d) Add some facts about your favorite bars and beverages to test your programs.

**Hint:** Use negation.

**Hint:** Use more negation.
