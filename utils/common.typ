#let _block(title: "", text: []) = box(
  fill: gradient.linear(luma(240), luma(245)),
  stroke: 2pt + gradient.linear(luma(240), luma(245)),
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
    fill: gradient.linear(luma(240), luma(245)),
    inset: (x: 10pt, bottom: 10pt),
    text
  )
]

#let _content(text) = {
  v(0.5cm)
  block(columns(2)[
    #text
  ])
  pagebreak()
}

// cannot be used everywhere because it bugs when used in conjunction with raw boxes
#let _balanced_content(cols: 2, body) = layout(
  size => style(
    style => {
      let blocksize = measure(block(width: size.width, columns(cols, body)), style)
      block(height: blocksize.height / cols, columns(cols, body))
    },
  ),
)