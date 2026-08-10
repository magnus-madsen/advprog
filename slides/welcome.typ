// Compile with:
//
//   $ typst compile welcome.typ
//
// The Touying manual is here:
// https://touying-typ.github.io/

#import "@preview/touying:0.7.4": *
#import themes.metropolis: *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Advanced Topics in Programming Language Theory],
    author: [Magnus Madsen, Daniel Gratzer, and Jean Pichon-Pharabod],
    institution: [Aarhus University],
    date: none,
  ),
)

#title-slide()

// Highlight: bold blue. Uses `text` rather than `strong`, since touying routes
// `strong` through its `alert` method and would recolor it to the theme accent.
#let friendly-blue = rgb("#1f6feb")
#let hlblue(body) = text(weight: "bold", fill: friendly-blue, body)

// Bold, in the default text color (see the note on `strong` above).
#let topic(body) = text(weight: "bold", body)

// Subdued grey, for asides and secondary detail.
#let grey = luma(110)
#let aside(body) = text(fill: grey, body)

// Lecturer name with their email underneath, in small grey type.
#let lecturer(name, email) = {
  set par(leading: 10pt)
  name
  linebreak()
  text(size: .55em, fill: grey, email)
}

#slide(title: [Course Overview])[
  #set text(size: 1.1em)
  #table(
    columns: (auto, auto, 1fr),
    align: (center + horizon, horizon, horizon),
    stroke: none,
    inset: (x: 0.6em, y: 0.35em),
    table.hline(stroke: .05em),
    table.header(hlblue[Weeks], hlblue[Lecturer], hlblue[Module]),
    table.hline(stroke: .05em),
    [1--3], lecturer([Magnus Madsen], "magnusm@cs.au.dk"),
    topic[Logic Programming: Datalog & Prolog],

    [4], lecturer([Troels Henriksen], "athas@di.ku.dk"),
    [#topic[Futhark] #aside[(guest lecture)]],

    [5--7], lecturer([Jean Pichon-Pharabod], "jean.pichon@cs.au.dk"),
    topic[TBD],

    [8--14], lecturer([Daniel Gratzer], "gratzer@cs.au.dk"),
    topic[TBD],
  )

  #v(.8em)

  #align(center, text(size: .85em)[
    🚨 The guest lecture takes place on Wed Sept. 16
    from 09 to 12 AM in Nygaard 5335-091
  ])
]

#slide(title: [Homework])[
  #set text(size: 1.2em)
  - #topic[Logic Programming]: A collection of programming exercises.
  - #topic[TBD]: TBD
  - #topic[TBD]: TBD
]

#slide(title: [Exam])[
  #set text(size: 1.2em)
  - An #topic[individual 30 minute oral exam], without preparation:
    - Draw a random topic (roughly one per week of the course).
    - Present the topic for 10 minutes.
    - Answer questions for 15 minutes.
  - Graded on the #topic[Danish 7-point scale].
  - #topic[Prerequisite]: Mandatory homework must be approved.
]
