#let project(
  title: "",
  subtitle: "",
  abstract: [],
  keywords: [],
  acknowledgments: none,
  declaration-of-originality: none,
  affiliation: (),
  authors: (),
  candidate: (),
  supervisor: "",
  cosupervisor: "",
  date: none,
  logo: none,
  paper-size: "us-letter",
  bibliography-file: none,
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set text(font: "New Computer Modern", lang: "en", size: 10pt)
  set page(
    paper: paper-size,
    margin: (right: 3cm, left: 3.5cm, top: 3.5cm, bottom: 3.5cm),
  )
  
  // Outline customization
  show outline.entry.where(level: 1): it => {
    if it.body != [References] {
    v(12pt, weak: true)
    link(it.element.location(), strong({
      it.body
      h(1fr)
      it.page
    }))}
    else {
      text(size: 1em, it)
    }
  }
  show outline.entry.where(level: 3): it => {
    text(size: 0.8em, it)
  }
  
  // Configure equation numbering and spacing.
  show math.equation: set block(spacing: 0.65em)
  
  // Configure raw text/code blocks
  show raw.where(block: true): set text(size: 0.8em, font: "FiraCode Nerd Font")
  show raw.where(block: true): set par(justify: false)
  set raw(syntaxes: (
    "../resources/syntaxes/smol.sublime-syntax",
    "../resources/syntaxes/sparql.sublime-syntax",
    "../resources/syntaxes/turtle.sublime-syntax",
  ))
  show raw.where(block: true): block.with(
    fill: gradient.linear(luma(240), luma(245), angle: 270deg),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )
  show raw.where(block: false): box.with(
    fill: gradient.linear(luma(240), luma(245), angle: 270deg),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  
  // Figures
  show figure.caption: set text(size: 0.8em)
  
  // Configure lists and enumerations.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt, marker: ([•], [--]))
  
  // Configure headings.
  set heading(numbering: "1.a.I")
  show heading.where(level: 1): it => {
    if it.body != [References] {
      block(width: 100%, height: 20%)[
        #set align(center + horizon)
        #set text(1.3em, weight: "bold")
        #smallcaps(it)
      ]
    } else {
      block(width: 100%, height: 10%)[
        #set align(center + horizon)
        #set text(1.1em, weight: "bold")
        #smallcaps(it)
      ]
    
    }
  }
  show heading.where(level: 2): it => block(width: 100%)[
    #set align(center)
    #set text(1.1em, weight: "bold")
    #smallcaps(it)
  ]
  show heading.where(level: 3): it => block(width: 100%)[
    #set align(left)
    #set text(1em, weight: "bold")
    #smallcaps(it)
  ]
  
  // Title page
  set align(center)
  [
    #text(1.5em, weight: "bold", affiliation.university) \
    #text(1.2em, spacing: 182%, affiliation.school) \
    #text(1.2em, spacing: 213%, affiliation.degree)
  ]
  
  v(30pt)
  image(logo, width: 40%)
  v(30pt)
  
  text(1.5em, subtitle)
  v(1em, weak: true)
  text(2em, weight: 700, title)
  v(40pt)
  
  grid(columns: 2, gutter: 14em, [
    #set align(left)
    
    #smallcaps("supervisor") \
    *#supervisor* \ \
    
    #smallcaps("co-supervisors") \
    *#cosupervisor*
  ], [
    #set align(left)
    \ \ \
    
    #smallcaps("candidate") \
    *#candidate.name* \
    #candidate.id
  ])
  
  v(53pt)
  text(1.2em, date)
  
  set par(justify: true, first-line-indent: 1em)
  pagebreak()
  pagebreak()
  
  set align(center + horizon)
  
  // Declaration of originality
  heading(
    level: 2,
    numbering: none,
    outlined: false,
    "Declaration of Originality",
  )
  text(style: "italic", [
    “#declaration-of-originality”
  ])
  
  pagebreak()
  
  // acknowledgments
  heading(level: 2, numbering: none, outlined: false, "Acknowledgments")
  acknowledgments
  
  pagebreak()
  
  // Abstract
  counter(page).update(0)
  heading(level: 2, numbering: none, "Abstract")
  abstract
  heading(level: 2, numbering: none, outlined: false, "Keywords")
  keywords
  
  pagebreak()
  pagebreak()
  
  // Table of contents.
  outline(depth: 3, indent: true)
  pagebreak()
  pagebreak()
  
  // Main body
  set page(numbering: "1")
  set align(top + left)
  body
  
  pagebreak()
  
  // Bibliography
  if bibliography-file != none {
    heading(level: 1, numbering: none, "References")
    show bibliography: set text(0.9em)
    bibliography(bibliography-file, title: none)
  }
}