#import "@preview/suiji:0.5.0": shuffle, gen-rng
#import "@preview/zebraw:0.6.1": *
#show: zebraw.with(numbering: false)


#import "../package/lib.typ": *

#let package = "simple-icons-typst"
#let author-name = "Cason Kervis"
#let author-email = link("mailto:cscnk52@outlook.com")[cscnk52\@outlook.com]
#let version = "v" + toml("../package/typst.toml").package.version
#let today = datetime.today().display("[year]/[month]/[day]")
#let icons = json("./simple-icons.json")

#set page(header: [#package@#version #h(1fr) #today],numbering: "1/1")

#set document(title: [#package@#version], description: [#icons.len() SVG icons for popular brands in Typst], keywords: ("simple-icons", "SVG", "Typst", "WASM", "Rust"), author: author-name)

#set text( size: 12pt)

#align(center + horizon, block(
  [
    #text(size: 36pt)[ *#package*]

    #text(size: 18pt)[#icons.len() SVG icons for popular brands in #box( baseline: 10%,simple-icon(size: 0.8em)) Typst]

    #v(30%)

    #text(size: 14pt)[#author-name \ #author-email]

    #linebreak()

    #link("https://github.com/cscnk52/simple-icons-typst", "GitHub") · #link("https://typst.app/universe/package/sicons", "Typst")

    #text(size: 12pt)[#today]
  ]
))

#pagebreak()

#outline()

#pagebreak()

= Overview

_simple-icons-typst_ is a Typst package that provides SVG icons for popular brands. It allows you to insert brand icons directly in Typst documents withouts manual SVG handing.

= Quick start

use below code quick use this package.

```typ
#import "@preview/simple-icons:16.0.0": simple-icon

#simple-icon(slug: "typst")
#simple-icon(slug: "github")
#simple-icon(slug: "deno")
```


= Usage

This package provide Typst support for the simple icons logos.



```typ
= Typst sicons package Example

#simple-icon(slug: "typst", size: 1em, icon-color: "default")

#simple-title(slug: "typst", size: 1em, text-color: "#000000")

#simple-label(slug: "typst", size: 1em,icon-color: "default", text-color: "#000000")

#simple-raw(slug: "typst")
```

#figure(image("test.svg"), caption: [_simple-icons-typst_ Example])

= Version

Because this package bundles all icons into a single WASM binary, the compiled WASM is approximately 5 MB. To avoid putting unnecessary strain on Typst Universe, only major versions like `x.0.0` are released to the Universe.

If you want use the latest package with newest icon, you can download latest package archive file from release, and load it manually in your own.

=  Slugs

Most of time, title contain non-ASCII character, to avoid encoding issues and to keep filenames easy to typing, search, and reference in terminals, URLs, and source code. We have below rules for slug, or you can see  for :

+ Use *lowercase letters* without *whitespace*, for example:

  ```yaml
  title: Adobe Photoshop
  filename: adobephotoshop.svg
  ```

+ Only use *latin* letters, for example:

  ```yaml
  title: Citroën
  filename: citroen.svg
  ```

+ Replace the following symbols with their alias:

  #align(center,table(
  columns: 2,
  align: (center, left),
  table.header(
    [*Symbol*], [*Alias*],
  ),
  [+],   [plus],
  [.],   [dot],
  [&],   [and],
))

  For example:

  ```yaml
   title: .Net
   filename: dotnet.svg
  ```
+ On rare occasions the resulting name will clash with the name of an existing SVG file in our collection. To resolve such conflicts append `__[MODIFIER]` to the name, where `[MODIFIER]` is a short descriptor of the brand or the service they provide and follows the same rules of construction as above.

  For example:

  ```yaml
   title: Hive
   filename: hive_blockchain.svg
  ```

= Disclaimer



#pagebreak()

= Icon Gallery

#grid(
  columns: 18,
  gutter: 12pt,
  ..shuffle(gen-rng(52), icons).at(1).map(icon =>
    grid.cell(
      align: center,
      simple-icon(slug: icon.slug, size: 100%)
    )
  )
)

#pagebreak()

= Icon Index

#table(
  columns: (10% ,20%,20%, 50%),
  align: left + horizon,
  stroke: none,
  table.hline(),
  table.header(
    [Icon], [Title], [Hex], [Function],
  ),
 table.hline(stroke: 0.5pt),
 ..icons.map(icon => (simple-icon(slug:icon.slug),
  simple-title(slug: icon.slug),text("#" + icon.hex),raw("#simple-icon(slug: \"" + icon.slug + "\")", lang: "typst"))).flatten(),
   table.hline(),
)
