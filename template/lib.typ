#import "hpi-title-page.typ": *

// Default label sets for English and German.
#let default-labels-en = (
  abstract: "Abstract",
  abstract-de: "Zusammenfassung",
  acknowledgements: "Acknowledgements",
  contents: "Contents",
  bibliography: "Bibliography",
  declaration-title: "Declaration of Authorship",
  declaration-text: [
    I hereby declare that this thesis is my own unaided work. All direct or
    indirect sources used are acknowledged as references.
  ],
  declaration-city: "Potsdam",
  thesis-purpose: "zur Erlangung des akademischen Grades",
  study-program-label: "im Studiengang",
  submitted-on: "eingereicht am",
  chair-label: "Fachgebiet",
  faculty: "Digital-Engineering-Fakultät",
  university: "der Universität Potsdam",
  examiner: "Gutachter",
  advisor: "Betreuer",
)

#let default-labels-de = (
  abstract: "Zusammenfassung (Englisch)",
  abstract-de: "Zusammenfassung",
  acknowledgements: "Danksagung",
  contents: "Inhaltsverzeichnis",
  bibliography: "Literaturverzeichnis",
  declaration-title: "Eigenständigkeitserklärung",
  declaration-text: [
    Ich erkläre hiermit, dass ich die vorliegende Arbeit selbstständig verfasst
    und keine anderen als die angegebenen Quellen und Hilfsmittel verwendet habe.
  ],
  declaration-city: "Potsdam",
  thesis-purpose: "zur Erlangung des akademischen Grades",
  study-program-label: "im Studiengang",
  submitted-on: "eingereicht am",
  chair-label: "Fachgebiet",
  faculty: "Digital-Engineering-Fakultät",
  university: "der Universität Potsdam",
  examiner: "Gutachter",
  advisor: "Betreuer",
)

// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(
  // The title of the thesis
  title: "",
  // The translated title of the thesis
  translation: "",
  // The name of the student writing the thesis
  name: "",
  // Date of handing in the thesis
  date: none,
  // "Bachelor" or "Master"
  type: "",
  // Study Program of the student
  study-program: "",
  // Chair where the thesis is written
  chair: "",
  // First advising professor
  professor: "",
  // List of Advisors (e.g., ("Karla Musterfrau", "Max Mustermann"))
  advisors: (),
  // The abstract of the thesis
  abstract: "",
  // The German translation of the abstract
  // If not given, the page for German translation of abstract will not appear
  abstract-de: "",
  // The student may want to add acknowledgements
  // If not giving, the page for acknowledgements will not appear
  acknowledgements: "",
  // Determines if the document is intended for print or electronic use.
  // If for_print: true is set, additional pages will be added.
  for-print: false,
  // Optional path to a bibliography file (e.g., "references.bib").
  // If provided, a bibliography section will be added at the end.
  bibliography-file: none,
  // Main document font. Defaults to Libertinus Serif (bundled with Typst).
  // Popular alternatives: "New Computer Modern", "STIX Two Text", "Noto Serif"
  font: "Libertinus Serif",
  // If true, each chapter (level 1 heading) starts on a new page.
  chapter-pagebreak: false,
  // Document language (e.g., "en", "de"). Affects label defaults.
  lang: "en",
  // Accent color used for headings, title page lines, and header separator.
  accent-color: rgb("#4f5358"),
  // Page margins.
  margin: (left: 35mm, right: 35mm, top: 30mm, bottom: 30mm),
  // Body text justification.
  justify: true,
  // Table of contents heading depth.
  toc-depth: 4,
  // Font sizes per heading level.
  heading-sizes: (h1: 20pt, h2: 16pt, h3: 14pt, h4: 12pt, fallback: 11pt),
  // Override any translatable string. Merged on top of the language defaults.
  labels: (:),
  body,
) = {
  // Merge label defaults with user overrides.
  let base-labels = if lang == "de" { default-labels-de } else { default-labels-en }
  let valid-keys = base-labels.keys()
  for key in labels.keys() {
    assert(key in valid-keys, message: "Unknown label key: " + key)
  }
  let l = base-labels + labels

  // Set the document's basic properties.
  set document(author: name, title: title)
  set page(
    margin: margin,
    numbering: "1",
    number-align: end,
  )
  set text(font: font, lang: lang)
  show math.equation: set text(weight: 400)

  hpi-title-page(
    professor: professor,
    name: name,
    advisors: advisors,
    title: title,
    translation: translation,
    study-program: study-program,
    chair: chair,
    type: type,
    date: date,
    accent-color: accent-color,
    labels: l,
  )

  // Helper to render a heading with its numbering.
  let styled-heading(
    it,
    size,
    fill,
    spacing-before,
    spacing-after,
    underline: false,
  ) = {
    let number = if it.numbering != none {
      counter(heading).display(it.numbering)
      h(7pt, weak: true)
    }

    v(spacing-before)
    text(size: size, fill: fill, weight: "bold", block([#number #it.body]))
    if underline { line(length: 100%, stroke: 2pt + fill) }
    v(spacing-after)
  }

  // Configure chapter headings (level 1).
  show heading.where(level: 1): it => {
    if chapter-pagebreak { pagebreak(weak: true) }
    styled-heading(it, heading-sizes.at("h1"), accent-color, 5%, 1.5em)
  }

  // Configure section headings (levels 2-4).
  show heading.where(level: 2): it => styled-heading(
    it,
    heading-sizes.at("h2"),
    accent-color,
    2%,
    0.75em,
  )
  show heading.where(level: 3): it => styled-heading(
    it,
    heading-sizes.at("h3"),
    accent-color,
    2%,
    0pt,
  )
  show heading.where(level: 4): it => styled-heading(
    it,
    heading-sizes.at("h4"),
    accent-color,
    2%,
    0pt,
  )

  // Fallback for deeper heading levels.
  show heading: set text(heading-sizes.at("fallback"), weight: 400)

  // Helper: insert a front matter section followed by a page break.
  let front-section(title-text, content) = {
    heading(level: 1, numbering: none, title-text)
    v(0.5cm)
    text(content)
    pagebreak()
    if for-print { pagebreak() }
  }

  // Front matter (unnumbered pages).
  set page(numbering: none)
  pagebreak()
  if for-print { pagebreak() }

  // Roman-numbered front matter.
  counter(page).update(1)
  set page(numbering: "i")

  front-section(l.at("abstract"), abstract)

  if abstract-de != "" {
    front-section(l.at("abstract-de"), abstract-de)
  }

  if acknowledgements != "" {
    front-section(l.at("acknowledgements"), acknowledgements)
  }

  // Table of contents.
  outline(
    title: [
      #text(size: heading-sizes.at("h1"), fill: accent-color, l.at("contents"))
    ],
    depth: toc-depth,
  )
  pagebreak()
  if for-print { pagebreak() }

  // Main body.
  set par(justify: justify)

  // Creates a pagebreak to the given parity where empty pages
  // can be detected via `is-page-empty`.
  let detectable-pagebreak(to: "odd") = {
    [#metadata(none) <empty-page-start>]
    pagebreak(to: to)
    [#metadata(none) <empty-page-end>]
  }

  // Workaround for https://github.com/typst/typst/issues/2722
  let is-page-empty() = {
    let page-num = here().page()
    query(<empty-page-start>)
      .zip(query(<empty-page-end>))
      .any(((start, end)) => {
        (
          start.location().page() < page-num
            and page-num < end.location().page()
        )
      })
  }

  // Mark the start of the main body for header page number calculation.
  [#metadata(none) <body-start>]

  // Configure page properties.
  set page(
    numbering: "1",
    header: context {
      if is-page-empty() {
        return
      }

      // Calculate the body page number relative to the start of the main body.
      let body-start-page = query(<body-start>).first().location().page()
      let i = here().page() - body-start-page + 1

      // Skip headers on pages that start a chapter heading.
      if query(heading).any(it => it.location().page() == here().page()) {
        return
      }

      // Find the heading of the section we are currently in.
      let before = query(selector(heading).before(here()))
      if before != () {
        set text(0.95em)
        let header = before.last().body
        let author = text(style: "italic", name)
        grid(
          columns: (1fr, 10fr, 1fr),
          align: (left, center, right),
          if calc.even(i) [#i],
          if calc.even(i) { author } else { title },
          if calc.odd(i) [#i],
        )
      }
      align(center, line(length: 100%, stroke: 0.5pt + accent-color))
    },
  )
  set heading(numbering: "1.1.1.1")

  counter(page).update(1)
  body

  // Bibliography.
  if bibliography-file != none {
    pagebreak()
    bibliography(bibliography-file, title: l.at("bibliography"))
  }

  pagebreak()
  heading(level: 1, numbering: none, l.at("declaration-title"))

  v(0.5cm)
  block(l.at("declaration-text"))

  v(1.5cm)
  [#l.at("declaration-city"), #date]
  v(1cm)
  grid(
    columns: (1fr, 1fr),
    [],
    [
      #line(length: 100%, stroke: 0.5pt)
      #align(center, name)
    ],
  )
}
