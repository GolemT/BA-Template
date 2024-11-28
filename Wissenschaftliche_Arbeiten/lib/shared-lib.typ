#let is-in-dict(dict-type, state, element) = {
  state.display(list => {
    if element not in list {
      panic(element + " is not a key in the " + dict-type + " dictionary.")
      return false
    }
  })
  return true
}

#let display-link(dict-type, state, element, text) = {
  if is-in-dict(dict-type, state, element) {
    link(label(dict-type + "-" + element), text)
  }
}

#let display(dict-type, state, element, text, link: true) = {
  if link {
    display-link(dict-type, state, element, text)
  } else {
    text
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