#let _block(text) = block(fill: luma(230), inset: 8pt, radius: 4pt, text)

#let _content(text) = {
  v(0.5cm)
  block(
    columns(2)[
      #text
    ]
  )
  pagebreak()
}