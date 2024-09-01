#import "template.typ": *
#import "acronyms.typ": Acronyms
#import "glossar.typ": Glossar


#show: project.with(
  // Folgende Einstellungen einkommentieren und anpassen wenn benötigt.

  // title: "",
  authors: (
    (name: "Tim Kosleck", Matrikelnummer: "222033"), 
    (name: "Alina Kreimer", Matrikelnummer: "222097"),
    (name: "Juliette-Louisa Möhr", Matrikelnummer: "222024"),
    (name: "Max Schiefer", Matrikelnummer: "222020"),
    (name: "Jasper-Finn Schröder", Matrikelnummer: "222049")
  ),
  // date: "01.01.2024",
  // logo: image("images/BA_Logo.jpg", width: auto),
  // modul: [Theorie-Praxis-Anwendung II],
  // sperrvermerk: false,
  // vorwort: false,
  // genderhinweis: true,
  // abbildungsverzeichnis: true,
  // tabellenverzeichnis: true,
  // codeverzeichnis: true
  // abkürzungsverzeichnis: true,
  // glossar: true,
  // literaturverzeichnis: true,
  
  // Texte
  // sperrvermerkText: [],
  // vorwortText: [],
  // genderhinweisText: [],
  
)

// Hier wird die wirkliche Ausarbeitung geschrieben
// Hinweis:
// Titel sehen besser aus wenn sie nacher (und vorher) einen #linebreak() einfügen 

= Introduction

#include "subtext.typ"

== Different Objects

#acr("API") ist eine Abkürzung

#gls("API") ist eine Glossarverlinkung

#figure(
  image("images/BA_Logo.jpg", width: 100pt),
  caption: "Logo der Berufsakademie Rhein-Main"
)<Logo> //Hiermit wird ein aufrufbarer Link erstellt

#figure(
  table(columns: 2fr, row-gutter: 1)[Das ist eine Tabelle], 
  caption: "Tabellenbeispiel"
)<tabelle> //Hiermit wird ein aufrufbarer Link erstellt

#figure(
  caption: "Beispiel für Code",
  ```ts
    const ReactComponent = () => {
      return (
        <div>
          <h1>Hello World</h1>
        </div>
      );
    };

    export default ReactComponent;
  ```
)<code>

=== Contributions

#comment("This is a comment")

#todo("This is a ToDo")

#lorem(40)


= Linking Text

Hier wird nochmal #acr("API") aus dem Abkürzungsverzeichnis erwähnt.

Hier wird nochmal #gls("API") aus dem Glossar erwähnt

@Logo Zeigt das Logo der BA

@tabelle zeigt ein Beispiel einer Tabelle

@code zeigt ein Code Snippet

== Zitate

Hier ist ein Zitat @nissen_softwareagenten_2006.

#cite(<nissen_softwareagenten_2006>, form: "prose")) zitiert etwas im laufenden Text.

Hier ist ein zitat mit Link auf die Fußnote #footnote()[#cite(<nissen_softwareagenten_2006>)]
