#let std-bibliography = bibliography

#import "oth-title-page.typ": oth-title-page

// Default label sets for English and German.
#let default-labels-en = (
  abstract: "Abstract",
  abstract-de: "Zusammenfassung",
  acknowledgements: "Acknowledgements",
  contents: "Contents",
  bibliography: "Bibliography",
  submitted-by: "submitted by",
  thesis-purpose: "in partial fulfillment of the requirements for the academic degree",
  study-program-label: "in the study program",
  submitted-on-suffix: "at the",
  student-id-label: "Student ID",
  faculty: "Faculty of Computer Science and Mathematics",
  faculty-suffix: "at the",
  university: "OTH Regensburg",
  examiner: "Examiner",
  second-examiner: "Second Examiner",
  advisor: "Advisor",
  advisors: "Advisors",
  bachelor-thesis-kind: "Bachelor's Thesis",
  bachelor-degree: "Bachelor of Science",
  bachelor-abbreviation: "B.Sc.",
  master-thesis-kind: "Master's Thesis",
  master-degree: "Master of Science",
  master-abbreviation: "M.Sc.",
)

#let default-labels-de = (
  abstract: "Zusammenfassung (Englisch)",
  abstract-de: "Zusammenfassung",
  acknowledgements: "Danksagung",
  contents: "Inhaltsverzeichnis",
  bibliography: "Literaturverzeichnis",
  submitted-by: "vorgelegt von",
  thesis-purpose: "als Teil der Anforderungen zur Erlangung des akademischen Grades",
  study-program-label: "im Studiengang",
  submitted-on-suffix: "an der",
  student-id-label: "Matr.-Nr.",
  faculty: "Fakultät Informatik und Mathematik",
  faculty-suffix: "der",
  university: "OTH Regensburg",
  examiner: "Prüfer",
  second-examiner: "Zweitprüfer",
  advisor: "Betreuer",
  advisors: "Betreuer",
  bachelor-thesis-kind: "Bachelorarbeit",
  bachelor-degree: "Bachelor of Science",
  bachelor-abbreviation: "B.Sc.",
  master-thesis-kind: "Masterarbeit",
  master-degree: "Master of Science",
  master-abbreviation: "M.Sc.",
)

// Default typography settings (font, sizes, spacing).
#let default-typography = (
  font: "Libertinus Serif",
  body-text-size: 12pt,
  line-spacing: 0.65em,
  justify: true,
  heading-sizes: (h1: 20pt, h2: 16pt, h3: 14pt, h4: 12pt, fallback: 12pt),
)

// Default layout settings (margins, print mode, ToC depth).
#let default-layout = (
  margin: (left: 35mm, right: 35mm, top: 30mm, bottom: 30mm),
  for-print: false,
  chapter-pagebreak: false,
  toc-depth: 4,
  show-header: true,
)

// Default appearance settings (colors, logos).
#let default-appearance = (
  accent-color: rgb("#000"),
  university-logo: "oth-logo.png",
  university-logo-width: 6.5cm,
  company-logo: none,
)

// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(
  // The title of the thesis
  title: "",
  // A shortened title for use in the page header
  short-title: "",
  // The translated title of the thesis
  translation: "",
  // The name of the student writing the thesis
  name: "",
  // The student ID
  student-id: "",
  // Date of handing in the thesis
  date: none,
  // "Bachelor" or "Master"
  type: "",
  // Study Program of the student
  study-program: "",
  // German name of the study program (used on the declaration page)
  study-program-de: "",
  // First advising professor
  professor: "",
  // Second examiner (optional)
  second-professor: "",
  // List of Advisors (e.g., ("Karla Musterfrau", "Max Mustermann"))
  advisors: (),
  // The abstract of the thesis
  abstract: "",
  // The German translation of the abstract
  // If not given, the page for German translation of abstract will not appear
  abstract-de: "",
  // The student may want to add acknowledgements
  // If not given, the page for acknowledgements will not appear
  acknowledgements: "",
  // Optional bibliography content (e.g., bibliography("references.bib")).
  // If provided, a bibliography section will be added at the end.
  bibliography: none,
  // Document language (e.g., "en", "de"). Affects label defaults.
  lang: "en",
  // Typography settings (font, sizes, spacing). Merged with defaults.
  typography: (:),
  // Layout settings (margins, print mode, ToC depth). Merged with defaults.
  layout: (:),
  // Appearance settings (colors, logos). Merged with defaults.
  appearance: (:),
  // Override any translatable string. Merged on top of the language defaults.
  labels: (:),
  body,
) = {
  // Merge group defaults with user overrides.
  let typo = default-typography + typography
  let typo = typo + (heading-sizes: default-typography.heading-sizes + typography.at("heading-sizes", default: (:)))
  let lay = default-layout + layout
  let app = default-appearance + appearance

  // Merge label defaults with user overrides.
  let base-labels = if lang == "de" { default-labels-de } else {
    default-labels-en
  }
  let valid-keys = base-labels.keys()
  for key in labels.keys() {
    assert(key in valid-keys, message: "Unknown label key: " + key)
  }
  let l = base-labels + labels

  // Set the document's basic properties.
  set document(author: name, title: title)
  set page(
    margin: lay.margin,
    numbering: "1",
    number-align: end,
  )
  set text(font: typo.font, size: typo.body-text-size, lang: lang)
  set par(leading: typo.line-spacing)
  set math.equation(numbering: "(1)")
  show math.equation: set text(weight: 400)

  oth-title-page(
    professor: professor,
    second-professor: second-professor,
    name: name,
    student-id: student-id,
    advisors: advisors,
    title: title,
    translation: translation,
    study-program: study-program,
    type: type,
    date: date,
    accent-color: app.accent-color,
    university-logo: app.university-logo,
    university-logo-width: app.university-logo-width,
    company-logo: app.company-logo,
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
    if lay.chapter-pagebreak { pagebreak(weak: true) }
    styled-heading(it, typo.heading-sizes.at("h1"), app.accent-color, 5%, 1.5em)
  }

  // Configure section headings (levels 2-4).
  show heading.where(level: 2): it => styled-heading(
    it,
    typo.heading-sizes.at("h2"),
    app.accent-color,
    2%,
    0.75em,
  )
  show heading.where(level: 3): it => styled-heading(
    it,
    typo.heading-sizes.at("h3"),
    app.accent-color,
    2%,
    0pt,
  )
  show heading.where(level: 4): it => styled-heading(
    it,
    typo.heading-sizes.at("h4"),
    app.accent-color,
    2%,
    0pt,
  )

  // Fallback for deeper heading levels.
  show heading: set text(typo.heading-sizes.at("fallback"), weight: 400)

  // Helper: insert a front matter section followed by a page break.
  let front-section(title-text, content) = {
    heading(level: 1, numbering: none, title-text)
    v(0.5cm)
    content
    pagebreak()
    if lay.for-print { pagebreak() }
  }

  // Front matter (unnumbered pages).
  set page(numbering: none)
  pagebreak()
  if lay.for-print { pagebreak() }

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
      #text(size: typo.heading-sizes.at("h1"), fill: app.accent-color, l.at("contents"))
    ],
    depth: lay.toc-depth,
  )
  pagebreak()
  if lay.for-print { pagebreak() }

  // Main body.
  set par(justify: typo.justify)

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
      if not lay.show-header { return }
      if is-page-empty() {
        return
      }

      // Calculate the body page number relative to the start of the main body.
      let body-start-page = query(<body-start>).first().location().page()
      let i = here().page() - body-start-page + 1

      // Find the heading of the section we are currently in.
      let before = query(selector(heading).before(here()))
      if before != () {
        set text(0.95em)
        let author = text(style: "italic", name)
        grid(
          columns: (1fr, 10fr, 1fr),
          align: (left, center, right),
          if calc.even(i) [#i],
          if calc.even(i) { author } else { if short-title != "" { short-title } else { title } },
          if calc.odd(i) [#i],
        )
      }
      align(center, line(length: 100%, stroke: 0.5pt + app.accent-color))
    },
  )
  set heading(numbering: "1.1.1.1")

  counter(page).update(1)
  body

  // Bibliography.
  if bibliography != none {
    pagebreak()
    set std-bibliography(title: l.at("bibliography"))
    bibliography
  }

  pagebreak()
  if lay.for-print { pagebreak() }

  // Declaration of Authorship.
  {
    let decl-thesis-word = if type == "Master" { l.at("master-thesis-kind") } else { l.at("bachelor-thesis-kind") }
    let name-parts = name.split(" ")
    let decl-last-name = name-parts.last()
    let decl-first-name = if name-parts.len() > 1 { name-parts.slice(0, -1).join(" ") } else { "" }

    page(header: none, numbering: none, footer: [
      #set text(font: "Arial", size: 10pt)
      #text(style: "italic")[Diese Erklärung ist mit der #decl-thesis-word (#underline[eingeheftet]) abzugeben.] \ \
      #text(fill: app.accent-color)[Stand: 21.09.2018/Abt. III]
    ])[
      #set text(font: "Arial")

      #image(app.university-logo, width: app.university-logo-width)

      #v(1.5cm)

      #align(center, text(weight: "bold", size: 1.3em)[
        ERKLÄRUNG \
        ZUR #upper(decl-thesis-word) VON
      ])

      #v(1cm)

      #grid(
        columns: (auto, 1fr),
        row-gutter: 0.4em,
        column-gutter: 0.5cm,
        text(weight: "bold")[Name:],
        [#decl-last-name],
        text(weight: "bold")[Vorname:],
        [#decl-first-name],
        text(weight: "bold")[Studiengang:],
        [#if study-program-de != "" { study-program-de } else { study-program }],
      )

      #v(0.8cm)

      #enum(
        [Mir ist bekannt, dass dieses Exemplar der #decl-thesis-word als Prüfungsleistung in das Eigentum der Ostbayerischen Technischen Hochschule Regensburg übergeht.],
        [Ich erkläre hiermit, dass ich diese #decl-thesis-word selbständig verfasst, noch nicht anderweitig für Prüfungszwecke vorgelegt, keine anderen als die angegebenen Quellen und Hilfsmittel benutzt sowie wörtliche und sinngemäße Zitate als solche gekennzeichnet habe.],
      )

      #v(3cm)

      Regensburg, den

      #v(1cm)

      ......................................................
      #linebreak()
      Unterschrift
    ]
  }
}
