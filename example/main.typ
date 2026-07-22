// For use in Typst Universe, replace the import below with:
// #import "@preview/oth-regensburg-thesis:0.1.0": *
#import "../template/lib.typ": *

#let ai-statement = [
  This thesis was authored with the assistance of Artificial Intelligence (AI).
]

#let abstract = [
  This is a very good abstract.
]

#let acknowledgements = [
  Thanks to ...
]

#show: project.with(
  title: "My Very Long, Informative, Expressive, and Definitely Fancy Title",
  // translation: "Eine adäquate Übersetzung meines Titels",
  // short-title: "My Very Short but still Informative Title", // Optional, currently unused
  name: "Max Mustermann",
  student-id: "1234567",
  date: "July 17th, 2025",
  study-program: "Computer Science",
  degree: "Master",
  // field: "Engineering",  // "Science" (B.Sc./M.Sc.) (default), "Engineering" (B.Eng./M.Eng.), "Arts" (B.A./M.A.)
  professor: "Prof. Dr. Rosseforp Renttalp",
  second-professor: "Prof. Dr. Anothera Examinia",
  advisors: (
    "Alberta Zweistein, That One Company Ltd.",  // Even for a single advisor, Typst requires the subsequent comma!
    // "Someone Else"  // Add as many advisors as you like
  ),
  pre-toc: (  // Front-matter sections shown before the table of contents, each on its own page
    // (title: "Statement on the Use of AI Tools", body: ai-statement),
    (title: "Abstract", body: abstract),
    (title: "Acknowledgements", body: acknowledgements),
  ),
  // pre-body: [  // Optional content to be placed between the table of contents and the main body, e.g., glossary, list of figures, etc.
  //   #glossary()  // example for "glossy"-package
  // ],
  bibliography: bibliography("references.bib"),
  // lang: "de",  // Switch all labels to German defaults
  // typography: (font: "STIX Two Text", body-text-size: 12pt),
  layout: (
    // margin: (left: 35mm, right: 35mm, top: 30mm, bottom: 30mm),  // Page margins
    // chapter-pagebreak: false,  // Start new chapters on the same page
    for-print: true,  // Optimize for printing (blank pages on odd numbers)
    // toc-depth: 2,  // Limit table of contents depth
    // show-header: false,  // Hides the current chapter title in the page header (except on pages with new h1)
  ),
  appearance: (
    // accent-color: rgb("#164194"),
    company-logo: image("company-logo.svg", alt: "Logo of associated company or institution", width: 5cm),
    // oth-logo-width: 5cm,
  ),
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
