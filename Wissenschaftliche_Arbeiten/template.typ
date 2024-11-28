#import "lib/glossar-lib.typ": *
#import "lib/acronym-lib.typ": *
#import "glossar.typ": Glossar
#import "acronyms.typ": Acronyms
#import "lib/shared-lib.typ": comment, todo

#let project(
  //Settings der Template
  title: "Projektarbeit an der Berufsakademie Rhein-Main",
  authors: (
    (name: "Student", Matrikelnummer: "123456"),
  ),
  date: "01.01.2024",
  logo: image("images/BA_Logo.jpg", width: auto),
  modul: [Theorie-Praxis-Anwendung II],
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
  
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set page(
    margin: (left: 25mm, right: 25mm, top: 25mm, bottom: 25mm),
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
  show math.equation: set text(weight: 400)
  show heading.where(level: 1): it => {
    pagebreak() + it + linebreak()
  }

  show heading.where(level: 2): it => {
    linebreak() + it + linebreak()
  }
  show heading.where(level: 3): it => {
    linebreak() + it + linebreak()
  }
  show heading.where(level: 4): it => {
    linebreak() + it + linebreak()
  }
  
  init-acronyms(Acronyms)
  init-glossary(Glossar)
  set heading(numbering: "1.1",)

  // Title page.
  v(0.6fr)
  // Titel
  align(center, text(2em, weight: 700, title))
  v(1.2em, weak: true)
  if logo != none {
    align(center, image("images/BA_Logo.jpg", width: 60%))
  }
  v(2.6fr)

  // Authoren.
  align(center, text(1.1em, weight: "bold", "Gruppen-Mitglieder"))
  pad(
    top: 0.7em,
    grid(
      columns: (1fr,),
      gutter: 1em,
      ..authors.map(author => align(center)[
        *#author.name* - #author.Matrikelnummer
      ]),
    ),
  )
  v(1.5fr)

  //Beschreibung
  align(center, text("Diese fachpraktische Ausarbeitung wurde erstellt im Rahmen der"))
  align(center, text(modul, weight: "bold"))
  v(1.5fr)
  
  //Datum
  align(center, text(1.1em, date))
  v(2.4fr)

  if sperrvermerk == true {  
    v(1fr)
    align(center)[
        #heading(
          outlined: false,
          numbering: none,
          text(0.85em, smallcaps[Sperrvermerk]),
        )
        #sperrvermerkText
      ]
    v(1.618fr)
  }

  if genderhinweis == true {
    v(1fr)
    align(center)[
        #heading(
          outlined: false,
          numbering: none,
          text(0.85em, smallcaps[Gleichbehandlung der Geschlechter]),
        )
        #genderhinweisText
      ]
  
    v(1.618fr)
  }

  if vorwort == true {
    v(1fr)
    align(center)[
        #heading(
          outlined: false,
          numbering: none,
          text(0.85em, smallcaps[Vorwort / Danksagungen]),
        )
        #vorwortText
      ]
  
    v(1.618fr)
  }

  // Table of contents.
  outline(depth: 3, indent: true)
  set page(numbering: "I")
  counter(page).update(1)

  let pagecounter = 0

  if(abbildungsverzeichnis == true){
    pagecounter += 1
    outline(title: "Abbildungsverzeichnis" ,target: figure.where(kind: image))
  }
  
  if(tabellenverzeichnis == true) {
    pagecounter += 1
    outline(title: "Tabellenverzeichnis" ,target: figure.where(kind: table))
  }

  if(codeverzeichnis == true) {
    pagecounter += 1
    outline(title: "Codeverzeichnis" ,target: figure.where(kind: raw))
  }

  if(abkürzungsverzeichnis == true) {
    pagecounter += 1
    print-acronyms(title: "Abkürzungsverzeichnis", 1em)
  }

  // Main body.
  set par(justify: true)
  set page(numbering: "1")
  counter(page).update(1)

  body
  
  set page(numbering: "I")
  counter(page).update(pagecounter  + 1)
  
  if(glossar == true){  
    print-glossary(title: "Glossar", 1em)
  }

  if(literaturverzeichnis == true){
    bibliography(title: "Literaturverzeichnis", "literatur.bib")
  }
  
  set page(numbering: none)
  align(left)[
    #heading(
      outlined: false, 
      numbering: none,
      text("Eidesstattliche Erklärung")
    )
  Hiermit erklären wir, dass diese Projektarbeit selbständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt und die aus fremden Quellen direkt oder indirekt übernommenen Gedanken als solche kenntlich gemacht haben. Die Arbeit oder Teile hieraus wurde und wird keiner anderen Stelle oder anderen Person im Rahmen einer Prüfung vorgelegt. Wir versichern zudem, dass keine sachliche Übereinstimmung mit einer im Rahmen eines vorangegangenen Studiums angefertigten Seminar-, Diplom- oder Abschlussarbeit sowie Bachelorthesis besteht.
  ]

  grid(
      columns: (1fr),
      ..authors.map(author => {
        v(3.5em)
        line(length: 100%)
        "Datum, Unterschrift von " + author.name
      })
    )
}