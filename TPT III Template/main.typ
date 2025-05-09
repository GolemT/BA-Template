#import "template.typ": *
#import "acronyms.typ": Acronyms
#import "glossar.typ": Glossar


#show: project.with(
  // Folgende Einstellungen einkommentieren und anpassen wenn benötigt.

  title: "",
  author: "",
  matrikelnummer: "",
  keywords: ("PDF", "Theorie-Praxis-Transfer"),
  description: "",
  date: "28.03.2025",
  modul: [Theorie-Praxis-Anwendung III],
)

// Hier wird die wirkliche Ausarbeitung geschrieben

= Introduction

#include "/texts/subtext.typ"

== Different Objects

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
  sourcecode(
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
  )
)<code>

=== Contributions <Contribution>

#comment("This is a comment")

#todo("This is a ToDo")

#lorem(40)


= Linking Text

@Logo Zeigt das Logo der BA

@tabelle zeigt ein Beispiel einer Tabelle

@code zeigt ein Code Snippet

== Zitate

Hier ist ein Zitat @nissen_softwareagenten_2006.

#cite(<nissen_softwareagenten_2006>, form: "prose")) zitiert etwas im laufenden Text.

Hier ist ein zitat mit Link auf die Fußnote #footnote()[#cite(<nissen_softwareagenten_2006>)]