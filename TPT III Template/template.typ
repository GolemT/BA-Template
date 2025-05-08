#import "/lib/import.typ": *
#import "glossar.typ": Glossar
#import "acronyms.typ": Acronyms
#import "lib/shared-lib.typ": *

#let project(
  //Settings der Template
   title: "",
  author: "",
  keywords: (),
  description: "",
  studiengruppe: "",
  matrikelnummer: "",
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
  anhang: false,
  glossar: true,
  literaturverzeichnis: true,
  //Vorgeschriebene Texte
  sperrvermerkText: [Die vorliegende Seminararbeit beinhaltet interne vertrauliche Informationen der DB Systel GmbH. Die Weitergabe des Inhaltes dieser Arbeit und eventuell beiliegender Zeichnungen und Daten im Gesamten oder in Teilen ist grundsätzlich untersagt. Es dürfen keinerlei Kopien oder Abschriften, auch nicht in digitaler Form, gefertigt werden. Ausnahmen bedürfen der schriftlichen Genehmigung durch die DB Systel GmbH.],
  vorwortText: [],
  genderhinweisText: [Zur besseren Lesbarkeit wird in dieser Ausarbeitung auf die gleichzeitige Verwendung geschlechtsspezifischer Sprachformen verzichtet. Sämtliche personenbezogenen Bezeichnungen gelten daher im Sinne der Gleichbehandlung für alle Geschlechter. Diese Vereinfachung dient ausschließlich der sprachlichen Klarheit und ist in keiner Weise als Wertung zu verstehen.],
  body,
) = {
  
  // Set the document's basic properties.
    set document(
    author: author, 
    title: title, 
    keywords: keywords, 
    description: description,
  )
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
    if it.outlined == true and it.numbering == none {
      it
    } else {
      pagebreak() + it + linebreak() 
    }
  }

  show heading.where(level: 2) 
  .or(heading.where(level: 3)) 
  .or(heading.where(level:4)): it => {
    linebreak() + it + linebreak()
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
  v(0.6fr)
  // Titel
  align(center, par(text(2em, weight: 700, "Fackpraktische Dokumentation zur Bachelorthesis mit dem vorläufigen Thema: ", hyphenate: false), justify: false) + text(title))
  v(1.2em, weak: true)
  if logo != none {
    align(center, image("images/BA_Logo.jpg", width: 60%))
  }
  v(2.6fr)

  // Authoren.
  align(center, text(1.1em, weight: "bold", author + " (" + matrikelnummer + ")"))

  v(1.5fr)

  //Beschreibung
  align(center, text("Diese fachpraktische Ausarbeitung wurde erstellt im Rahmen der"))
  align(center, text(modul, weight: "bold"))
  v(1.5fr)

  align(center, "Anzahl der Wörter: " + [#word-count-of(body).words])
  
  //Datum
  align(center, text(1.1em, "Datum: " + date))
  v(2.4fr)
if sperrvermerk == true {
    pagebreak()
    heading(
      outlined: false,
      numbering: none,
      text(smallcaps[Sperrvermerk]),
    )
    sperrvermerkText
    v(1.618fr)
  }

  if genderhinweis == true {
    pagebreak()
    heading(
      outlined: false,
      numbering: none,
      text(smallcaps[Gleichbehandlung der Geschlechter]),
    )
    genderhinweisText
    v(1.618fr)
  }

  if vorwort == true {
    pagebreak()
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
  pagebreak()
  outline(
    depth: 3,
    indent: auto,
    title: "Inhaltsverzeichnis"
    )
  set page(numbering: "I")
  counter(page).update(1)

  let pagecounter = 0

  if(abbildungsverzeichnis == true){
    pagebreak()
    pagecounter += 1
    heading(
      "Abbildungsverzeichnis", 
      numbering: none,
      outlined: true, 
      level: 1
    )
    linebreak()
    outline(
      title: none,
      target: figure.where(kind: image)
    )
  }
  
  if(tabellenverzeichnis == true) {
    pagebreak()
    pagecounter += 1
    heading(
      "Tabellenverzeichnis", 
      numbering: none,
      outlined: true, 
      level: 1
    )
    linebreak()
    outline(
      title: none,
      target: figure.where(kind: table)
    )
  }

  if(codeverzeichnis == true) {
    pagebreak()
    pagecounter += 1
    heading(
        numbering: none,
        outlined: true,
        text("Codeverzeichnis")
      )
      linebreak()
    outline(
      title: none,
      target: figure.where(kind: raw)
    )
  }

  if(abkürzungsverzeichnis == true) {
    pagebreak()
    pagecounter += 1
    heading(
        numbering: none,
        outlined: true,
        text("Abkürzungsverzeichnis")
      )
      linebreak()
    print-acronyms(
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

  if(anhang == true){
    pagebreak()
    heading(
      level: 1,
      numbering: none,
      outlined: true,
      "Anhang"
    )
    linebreak()
    include "anhang.typ"
  }
  
  if(glossar == true){
    pagebreak()
    heading(
        numbering: none,
        outlined: true,
        text("Glossar")
    )
    linebreak()
    print-glossary(
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
      style: "american-psychological-association",
      "literatur.bib")
  }

  pagebreak()
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