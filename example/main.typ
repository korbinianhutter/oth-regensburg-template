// When using this template as a package, replace the import below with:
// #import "@preview/hpi-thesis:<version>": *
#import "../template/lib.typ": *

#let abstract = [
  This is a very good abstract.
]

#let abstract-de = [
  Die ist eine wirklich gute Zusammenfassung.
]

#let acknowledgements = [
  Thanks to ...
]

#show: project.with(
  // font: "STIX Two Text",  // Override the default font
  title: "My Very Long, Informative, Expressive, and Definitely Fancy Title",
  translation: "Eine adäquate Übersetzung meines Titels",
  name: "Max Mustermann",
  date: "17. Juli, 2025",
  study-program: "IT-Systems Engineering",
  chair: "Data-Intensive Internet Computing",
  professor: "Prof. Dr. Rosseforp Renttalp",
  advisors: ("This person", "Someone Else"),
  abstract: abstract,
  abstract-de: abstract-de,
  acknowledgements: acknowledgements,
  type: "Master",
  for-print: false,
  // Note: when using a local import, the bibliography path resolves relative to
  // template/lib.typ — use "../example/references.bib" instead.
  // With the @preview package import, "references.bib" works as expected.
  bibliography-file: "../example/references.bib",
  // lang: "de",                              // Switch all labels to German defaults
  // accent-color: rgb("#B1063A"),             // HPI red instead of default gray
  // margin: (left: 30mm, right: 30mm, top: 25mm, bottom: 25mm),
  // justify: false,                           // Ragged-right body text
  // toc-depth: 2,                             // Shallower table of contents
  // heading-sizes: (h1: 22pt, h2: 18pt, h3: 15pt, h4: 13pt, fallback: 12pt),
  // labels: (declaration-city: "Berlin"),      // Override individual labels
)

= Introduction
#lorem(80)

As shown by Doe and Smith @example2025, this approach is effective.

== In this paper
#lorem(20)

=== Contributions
#lorem(40)

==== Really Small Stuff
#lorem(20)

= Related Work
#lorem(500)
