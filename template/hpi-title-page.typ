#let hpi-title-page(
  professor: "",
  advisors: (),
  chair: "",
  name: "",
  title: "",
  translation: "",
  study-program: "",
  date: "",
  type: "Bachelor",
  accent-color: rgb("#4f5358"),
  labels: (:),
) = {
  let (thesis-kind, degree, abbreviation) = if type == "Master" {
    ("Universitätsmasterarbeit", "Master of Science", "M.Sc.")
  } else {
    ("Universitätsbachelorarbeit", "Bachelor of Science", "B.Sc.")
  }

  page(footer: [])[
    // Title page
    #grid(
      columns: (1fr, 1fr),
      rows: (80pt, 80pt),
      grid.cell(image("up-logo.svg", alt: "University of Potsdam logo")),
      grid.cell(align(right, image(
        "hpi-logo.svg",
        alt: "Hasso Plattner Institute logo",
      ))),
    )

    #align(center, block[
      #line(length: 100%, stroke: 0.75pt + accent-color)\
      #text(2em, weight: "bold", title) \ \
      #text(1.5em, translation) \ \
      #line(length: 100%, stroke: 0.75pt + accent-color)
    ])

    #align(center, text(1.5em, weight: "bold", name))

    #align(center, block[
      #thesis-kind\
      #labels.at("thesis-purpose")
    ])

    #align(center, text(1.5em, block[
      #degree \
      #text(style: "italic", "(" + abbreviation + ")")
    ]))

    #align(center, block[
      #labels.at("study-program-label") \
      #study-program
    ])

    #align(center, block[
      #labels.at("submitted-on") #date am \
      #labels.at("chair-label") #chair der \
      #labels.at("faculty") \
      #labels.at("university")
    ])

    #v(1cm)
    #align(center, grid(
      columns: (1fr, 1.8fr),
      rows: (18pt, 18pt),
      grid.cell(align(left, text(weight: "bold", labels.at("examiner")))),
      grid.cell(align(left, professor)),
      grid.cell(align(left, text(weight: "bold", labels.at("advisor")))),
      grid.cell(align(left, advisors.join(", "))),
    ))
  ]
}
