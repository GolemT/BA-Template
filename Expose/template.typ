#import "/lib/import.typ": *
#import "glossar.typ": Glossar
#import "acronyms.typ": Acronyms
#import "lib/shared-lib.typ": *

#let project(
  //Settings der Template
  title: "",
  author: "",
  studiengruppe: "",
  matrikelnummer: "",
  akademischerGutachter: "",
  betrieblicherGutachter: "",
  datumDesKolloquiums: "",
  abgabe: "",
  logo: image("images/BA_Logo.jpg", width: auto),
  sperrvermerk: false,
  vorwort: false,
  genderhinweis: true,
  abbildungsverzeichnis: true,
  tabellenverzeichnis: true,
  codeverzeichnis: true,
  abkürzungsverzeichnis: true,
  glossar: true,
  literaturverzeichnis: true,
  //Vorgeschriebene Texte
  sperrvermerkText: [Die vorliegende Seminararbeit beinhaltet interne vertrauliche Informationen der DB Systel GmbH. Die Weitergabe des Inhaltes dieser Arbeit und eventuell beiliegender Zeichnungen und Daten im Gesamten oder in Teilen ist grundsätzlich untersagt. Es dürfen keinerlei Kopien oder Abschriften, auch nicht in digitaler Form, gefertigt werden. Ausnahmen bedürfen der schriftlichen Genehmigung durch die DB Systel GmbH.],
  vorwortText: [],
  genderhinweisText: [Zur besseren Lesbarkeit wird in dieser Ausarbeitung auf die gleichzeitige Verwendung geschlechtsspezifischer Sprachformen verzichtet. Sämtliche personenbezogenen Bezeichnungen gelten daher im Sinne der Gleichbehandlung für alle Geschlechter. Diese Vereinfachung dient ausschließlich der sprachlichen Klarheit und ist in keiner Weise als Wertung zu verstehen.],
  body,
) = {

  if (title == "") {
    panic("Du muss einen Titel angeben")
  }
  if (author == "") {
    panic("Du musst einen Author angeben")
  }
  if (studiengruppe == "") {
    panic("Du musst eine Studiengruppe angeben")
  }
  if (matrikelnummer == "") {
    panic("Du musst eine Matrikelnummer angeben")
  }
  if (akademischerGutachter == "") {
    panic("Du musst einen akademischen Gutachter angeben")
  }
  if (betrieblicherGutachter == "") {
    panic("Du musst einen betrieblichen Gutachter angeben")
  }

  
  // Set the document's basic properties.
  set document(author: author, title: title)
  set text(size: 12pt)
  set page(
    header: [#align(
      center,
      image(
        height: 120%,
        fit: "contain",
        "images/BA_Header.png",
        alt: "Berufsakademie Rhein Main. University of Cooperative Education - staatlich anerkannt -"
      )
    )],
    margin: (
      left: 25mm, 
      right: 25mm, 
      top: 30mm, 
      bottom: 25mm
    ),
    numbering: none,
    number-align: end,
  )
  set cite(style: "chicago-author-date")
  set par(justify:true)
  set text(
    font: "Libre Baskerville", 
    lang: "de",
    hyphenate: false
  )
  show footnote.entry: set text(size: 10pt)
  show figure.caption: set text(size: 10pt)
  show math.equation: set text(weight: 400)
  show heading: set text(size: 12pt, weight: "bold")
  show heading.where(level: 1): set text(size: 14pt, weight: "bold")
  show heading.where(level: 1): it => {
    if it.outlined == true and it.numbering == none {
      it
    } else {
      pagebreak(weak: true) + it + linebreak() 
    }
  }

  show heading.where(level: 2) 
  .or(heading.where(level: 3)) 
  .or(heading.where(level:4)): it => {
    it + linebreak()
  }

  set heading(bookmarked: true)
  // Abstand vor und nach Tabellen/Bildern/Code
  show figure: it => {
    linebreak() + it + linebreak()
  }
  
  init-acronyms(Acronyms)
  init-glossary(Glossar)
  set heading(numbering: "1.1",)

  // Title page.
  v(0.0fr)
  // Titel
  align(center, par(text(12pt, weight: 700, title, hyphenate: false), justify: false))
  v(2fr, weak: true)
  if logo != none {
    align(center, image("images/DB_Logo.png", width: 40%))
  }
  v(2fr)

  //Beschreibung
  align(
    center, 
    text(
      size: 12pt,
      "Exposé erstellt im Rahmen des Bachelor Thesis Kolloquiums:"
    )
  )
  v(1fr)
  align(
    center, 
    text(
      size: 12pt,
      datumDesKolloquiums
    )
  )
  v(1.5fr)
  
  pad(
    top: 0.7em,
    grid(
      columns: (2fr, 2fr),
      gutter: 1em,
      [Studiengruppe: ], [#studiengruppe],
      [Vorgelegt von:], [#author],
      [Anzahl der Wörter:], [#word-count-of(body, exclude: (heading, figure.caption)).words],
      [(inkl. wörtliche Zitate / Fußnoten)], [],
      [Anzahl der Wörter:], [#word-count-of(body, exclude: (heading, figure.caption, cite, footnote)).words],
      [(exkl. wörtliche Zitate / Fußnoten)], [],
      [Akademischer Gutachter:], [#akademischerGutachter],
      [Betrieblicher Gutachter:],[#betrieblicherGutachter],
      [Abgabedatum:], [#abgabe]
    )
  )
  v(1.5fr)

  if sperrvermerk == true {
    v(1fr)
    heading(
      outlined: false,
      numbering: none,
      text(smallcaps[Sperrvermerk]),
    )
    sperrvermerkText
    v(1.618fr)
  }

  if genderhinweis == true {
    v(1fr)
    heading(
      outlined: false,
      numbering: none,
      text(smallcaps[Gleichbehandlung der Geschlechter]),
    )
    genderhinweisText
    v(1.618fr)
  }

  if vorwort == true {
    v(1fr)
    heading(
      outlined: false,
      numbering: none,
      text(smallcaps[Vorwort / Danksagungen]),
    )
    vorwortText  
    v(1.618fr)
  }

  // Table of contents.
  outline(
    depth: 3, 
    indent: true,
    title: 
      text(
        "Inhaltsverzeichnis"
      ),
    )
  set page(numbering: "I")
  counter(page).update(1)

  let pagecounter = 0

  if(abbildungsverzeichnis == true){
    pagecounter += 1
    outline(
      title: heading(
        numbering: none,
        outlined: true,
        text("Abbildungsverzeichnis"),
        level: 1
      ),
      target: figure.where(kind: image)
    )
  }
  
  if(tabellenverzeichnis == true) {
    pagecounter += 1
    outline(
      title: heading(
        numbering: none,
        outlined: true,
        text("Tabellenverzeichnis")
      ),
      target: figure.where(kind: table)
    )
  }

  if(codeverzeichnis == true) {
    pagecounter += 1
    outline(
      title: heading(
        numbering: none,
        outlined: true,
        text("Codeverzeichnis")
      ),
      target: figure.where(kind: raw)
    )
  }

  if(abkürzungsverzeichnis == true) {
    pagecounter += 1
    print-acronyms(
      title: heading(
        numbering: none,
        outlined: true,
        text("Abkürzungsverzeichnis")
      ),
      1em
    )
  }

  // Main body.
  set par(justify: true)
  set page(numbering: "1")
  counter(page).update(1)

  body
  
  set page(numbering: "I")
  counter(page).update(pagecounter  + 1)
  
  if(glossar == true){  
    print-glossary(
      title: heading(
        numbering: none,
        outlined: true,
        text("Glossar")
      ),
      1em)
  }

  if(literaturverzeichnis == true){
    pagebreak()
    heading(
        level: 1,
        numbering: none,
        outlined: true,
        text("Literaturverzeichnis")
      )
    linebreak()
    bibliography(
      title: none,
      "literatur.bib")
  }
  
  set page(numbering: none)
  align(left)[
    #heading(
      outlined: false, 
      numbering: none,
      text("Eidesstattliche Erklärung")
    )
  Hiermit erklären ich, dass diese Bachelorarbeit selbständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt und die aus fremden Quellen direkt oder indirekt übernommenen Gedanken als solche kenntlich gemacht habe. Die Arbeit oder Teile hieraus wurde und wird keiner anderen Stelle oder anderen Person im Rahmen einer Prüfung vorgelegt. Ich versichern zudem, dass keine sachliche Übereinstimmung mit einer im Rahmen eines vorangegangenen Studiums angefertigten Seminar-, Diplom- oder Abschlussarbeit sowie Bachelorthesis besteht.
  ]

  grid(
      columns: (1fr),
        v(3.5em),
        line(length: 100%),
        v(1em),
        "Datum, Unterschrift von " + author
    )
}