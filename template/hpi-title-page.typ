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
      #line(length: 100%, stroke: 0.75pt + rgb("#4f5358"))\
      #text(2em, weight: "bold", title) \ \
      #text(1.5em, translation) \ \
      #line(length: 100%, stroke: 0.75pt + rgb("#4f5358"))
    ])

    #align(center, text(1.5em, weight: "bold", name))

    #align(center, block[
      #thesis-kind\
      zur Erlangung des akademischen Grades
    ])

    #align(center, text(1.5em, block[
      #degree \
      #text(style: "italic", "(" + abbreviation + ")")
    ]))

    #align(center, block[
      im Studiengang \
      #study-program
    ])

    #align(center, block[
      eingereicht am #date am \
      Fachgebiet #chair der \
      Digital-Engineering-Fakultät \
      der Universität Potsdam
    ])

    #v(1cm)
    #align(center, grid(
      columns: (1fr, 1.8fr),
      rows: (18pt, 18pt),
      grid.cell(align(left, text(weight: "bold", "Gutachter"))),
      grid.cell(align(left, professor)),
      grid.cell(align(left, text(weight: "bold", "Betreuer"))),
      grid.cell(align(left, advisors.join(", "))),
    ))
  ]
}
