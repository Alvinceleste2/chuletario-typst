#let conf(
  title: none,
  author: none,
  course: none,
  watermark: none,
  doc,
) = {

set document(
  title: title,
  author: author,
  date: auto,
)

set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 3cm),
)

set heading(
  numbering: "1.",
)

set par(
  justify: true,
  leading: 0.75em,
  spacing: 1.8em,
)

set text(
  lang: "es",
  size: 12pt,
)

show heading: set block(below: 1.2em)

align(center)[
  #text(size:20pt)[
    #upper[
    *#title*
    ]
  ]

  #text(size:13pt)[
    *#author*
  ]

  #v(-10pt)

  #text(size:12pt)[
    *#course*
  ]
]

// Permite generar apartados sin numeración en el índice.
show outline.entry: it => {
  if it.element.at("label", default: none) == <unnumbered> {
    // style this as you wish
    return [#it.body() #box(width: 1fr, repeat(gap: 0.15em)[.]) #it.page() \ ]
  }
  it
}

outline()

show heading.where(level: 1): it => {
  pagebreak()
  set text(hyphenate: false)
  set par(justify: false)
  set align(center)

  if it.at("label", default: none) != <unnumbered> {
    // style this as you wish
    text("TEMA") 
    counter(heading).display()
  }
  upper[#it.body]
}

show heading.where(level: 2): it => [
  #set text(hyphenate: false)
  #set par(justify: false)
  #set align(center)
  #counter(heading).display() #upper[#it.body]
]

set page(
  header: [
    #align(center, title)
    #line(length: 100%)],
    numbering: "1",
    foreground: rotate(-55deg)[#text(100pt, fill: black.transparentize(80%))[#watermark]],
)

counter(page).update(1)

doc
}
