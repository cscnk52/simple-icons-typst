#let wasm-path = "simple_icons.wasm"

#let p = plugin(wasm-path)

#let simple-icon = (slug: "typst", size: 1em, icon-color: "default") => {
  image(p.simple_icons_slug_colored(bytes(slug), bytes(icon-color)), width: size)
}

#let simple-title = (slug: "typst", size: 1em, text-color: "#000000") => text(
  str(p.simple_icons_title(bytes(slug))),
  size: size,
  fill: rgb(text-color),
)

#let simple-label = (slug: "typst", size: 1em, icon-color: "default", text-color: "#000000") => {
  let resolvedTextColor = if text-color == "default" {
    rgb(str(p.simple_icons_color(bytes(slug))))
  } else {
    rgb(text-color)
  }

  grid(
    columns: (auto, auto),
    align: center + horizon,
    gutter: size / 3,
    simple-icon(slug: slug, size: size, icon-color: icon-color), simple-title(slug: slug, size: size, text-color: resolvedTextColor),
  )
}

#let simple-raw = (slug: "typst") => raw(str(p.simple_icons_slug(bytes(slug))), lang: "xml")
