// For use in Typst Universe, replace the import below with:
// #import "@preview/oth-regensburg-thesis:0.1.0": *
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
  title: "My Very Long, Informative, Expressive, and Definitely Fancy Title",
  // translation: "Eine adäquate Übersetzung meines Titels",
  name: "Max Mustermann",
  student-id: "1234567",
  date: "July 17th, 2025",
  study-program: "Computer Science",
  professor: "Prof. Dr. Rosseforp Renttalp",
  second-professor: "Prof. Dr. Anothera Examinia",
  advisors: (
    "This person",  // Even for a single advisor, Typst requires the subsequent comma!
    // "Someone Else"  // Add as many advisors as you like
  ),
  abstract: abstract,
  abstract-de: abstract-de,
  acknowledgements: acknowledgements,
  type: "Master",
  bibliography: bibliography("references.bib"),
  // lang: "de",  // Switch all labels to German defaults
  // typography: (font: "STIX Two Text", body-text-size: 12pt),
  // layout: (for-print: true, toc-depth: 2),
  appearance: (
    // accent-color: rgb("#164194"),
    company-logo: "company-logo.svg",
  ),
  // labels: (declaration-city: "Regensburg"),
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
