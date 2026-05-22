#let oth-title-page(
  professor: "",
  second-professor: "",
  advisors: (),
  name: "",
  student-id: "",
  title: "",
  translation: "",
  study-program: "",
  date: none,
  type: "",
  accent-color: rgb("#164194"),
  university-logo: "oth-logo.png",
  university-logo-width: 6.5cm,
  company-logo: none,
  labels: (:),
) = {
  assert(type in ("Bachelor", "Master", ""), message: "type must be 'Bachelor' or 'Master'")

  let (thesis-kind, degree, abbreviation) = if type == "Master" {
    (labels.at("master-thesis-kind"), labels.at("master-degree"), labels.at("master-abbreviation"))
  } else {
    (labels.at("bachelor-thesis-kind"), labels.at("bachelor-degree"), labels.at("bachelor-abbreviation"))
  }

  // Title page
  page(footer: [])[
    #let logo-grid = grid(
      columns: (1fr, 1fr),
      rows: (80pt,),
      grid.cell(image(university-logo, width: university-logo-width, alt: "OTH Regensburg logo")),
      grid.cell(align(right, if company-logo != none {
        company-logo
      })),
    )

    #let body-content = {
      align(center, block({
        line(length: 100%, stroke: 0.75pt + accent-color)
        v(-0.4cm)
        text(2em, weight: "bold", title)
        v(-0.4cm)
        if translation != "" {
          v(0.2cm)
          text(1.5em, translation)
          v(-0.1cm)
        }
        line(length: 100%, stroke: 0.75pt + accent-color)
      }))

      align(center, text(1.6em, weight: "bold", thesis-kind))

      v(0.2em)
      align(center, labels.at("thesis-purpose"))

      align(center, block({
        text(1.5em, block({
          degree
          linebreak()
          text(style: "italic", "(" + abbreviation + ")")
        }))
      }))

      align(center, block({
        labels.at("study-program-label") + " "
        text(1.1em, study-program)
        linebreak()
        labels.at("submitted-on-suffix") + " "
        text(1.1em, labels.at("faculty"))
        linebreak()
        labels.at("faculty-suffix") + " "
        text(1.1em, labels.at("university"))
      }))

      v(1em)
      align(center, labels.at("submitted-by"))

      align(center, block({
        text(1.3em, weight: "bold", name)
        if student-id != "" {
          linebreak()
          labels.at("student-id-label") + ": " + student-id
        }
      }))

      v(1em)
      align(center, date)

      v(3em)
      align(center, grid(
        columns: (1fr, 1.8fr),
        rows: (18pt, 18pt),
        grid.cell(align(left, text(weight: "bold", labels.at("examiner")))),
        grid.cell(align(left, professor)),
        ..if second-professor != "" {
          (
            grid.cell(align(left, text(weight: "bold", labels.at("second-examiner")))),
            grid.cell(align(left, second-professor)),
          )
        },
        grid.cell(align(left, text(weight: "bold", if advisors.len() > 1 { labels.at("advisors") } else { labels.at("advisor") }))),
        grid.cell(align(left, advisors.join([\ ]))),
      ))
    }

    #layout(avail => context {
      let logo-h = measure(logo-grid, width: avail.width).height
      let h = measure(body-content, width: avail.width).height
      let spacing = avail.height - logo-h - h - 8mm
      logo-grid
      v(if spacing < 0pt { 0pt } else if spacing > 1.5cm { 1.5cm } else { spacing })
      body-content
    })
  ]
}
