#let _block(title: "", text: []) = box(
  fill: gradient.linear(luma(240), luma(245), angle: 270deg),
  stroke: 2pt + gradient.linear(luma(240), luma(245), angle: 270deg),
  radius: 4pt,
)[
  #block(
    fill: luma(255),
    inset: 10pt,
    radius: (top-left: 4pt, bottom-right: 4pt),
  )[
    #emph(title)
  ]
  #block(
    fill: gradient.linear(luma(240), luma(245), angle: 270deg),
    inset: (x: 10pt, bottom: 10pt),
    text,
  )
]

#let _content(text) = {
  v(0.5cm)
  block(columns(2)[
    #text
  ])
  pagebreak()
}
