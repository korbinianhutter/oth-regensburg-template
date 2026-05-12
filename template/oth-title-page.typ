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

  page(footer: [])[
    // Title page
    #grid(
      columns: (1fr, 1fr),
      rows: (80pt, 80pt),
      grid.cell(image(university-logo, width: university-logo-width, alt: "OTH Regensburg logo")),
      grid.cell(align(right, if company-logo != none {
        company-logo
      })),
    )

    #align(center, block[
      #line(length: 100%, stroke: 0.75pt + accent-color)\
      #text(2em, weight: "bold", title) \ \
      #if translation != "" [
        #text(1.5em, translation) \ \
      ]
      #line(length: 100%, stroke: 0.75pt + accent-color)
    ])
    
    #align(center, text(1.6em, weight: "bold", thesis-kind))

    #v(0.2em)
    #align(center, labels.at("thesis-purpose"))

    #align(center, block[
      #text(1.5em, block[
        #degree \
        #text(style: "italic", "(" + abbreviation + ")")
      ])
    ])

    #align(center, block[
      #text(labels.at("study-program-label"))
      #text(1.1em, study-program) \
      #text(labels.at("submitted-on-suffix"))
      #text(1.1em, labels.at("faculty")) \
      #text(labels.at("faculty-suffix"))
      #text(1.1em, labels.at("university"))
    ])

    #v(1em)
    #align(center, labels.at("submitted-by"))

    #align(center, block[
      #text(1.3em, weight: "bold", name)
      #if student-id != "" [ \
        #(labels.at("student-id-label") + ": " + student-id)
      ]
    ])

    #v(1em)
    #align(center, date)

    #v(3em)
    #align(center, grid(
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
  ]
}
