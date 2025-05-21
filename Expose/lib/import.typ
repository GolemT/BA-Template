#import "/lib/acronym-lib.typ": *
#import "/lib/glossar-lib.typ": *
#import "@preview/codelst:2.0.2": sourcecode
#import "shared-lib.typ": *

// Diese Datei exisitiert, damit man die Funktions für das Glossar und Acronyme durch einen einzigen Import in jeder Datei nutzen kann

#let zitat(source, supplement: "") = {
  context {
    if supplement != "" {
      footnote[#cite(source, form: "author"), #cite(source, form:"year"), #text(supplement)]
    } else {
      footnote[#cite(source, form: "author"), #cite(source, form:"year")]
    } 
  }
}

#let todo(message) = {
  set text(white)
  rect(
    fill: red,
    radius: 4pt,
    [*TODO:* #message]
  )
  set text(black)
}

#let comment(message) = {
  set text(white)
  rect(
    fill: blue,
    radius: 4pt,
    [Kommentar: #message]
  )
}