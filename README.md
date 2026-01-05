<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/cscnk52/simple-icons-typst/raw/refs/heads/main/docs/images/simple-icons-typst-banner.dark.png" />
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/cscnk52/simple-icons-typst/raw/refs/heads/main/docs/images/simple-icons-typst-banner.light.png" />
  <img alt="simpleicons-rs banner" src="https://github.com/cscnk52/typst-sicons/raw/refs/heads/main/assets/img/typst-light.png" />
</picture>

<div align="center">

# simple-icons-typst

Access High quality [Simple Icons](https://simpleicons.org) SVGs from Typst.

</div>

> [!NOTE]
> Since the compiled WASM module is relatively large (~5 MB), this package is only updated with new major releases of Simple Icons.

> [!NOTE]
> For previous user with package name "sicons", i'm trying move package name to "simple-icons", for better consistent, will be changed in v17.0.0(about release in May 2026)

## Usage

Function:

- simple-icon: return icon in SVG format
- simple-title: return icon name
- simple-label: return icon and name
- simple-raw: return Icon SVG code

Parameters:

- slug: icon slug, can be found at <https://simpleicons.org>
- size: the icon size
- icon-color: icons hex color, default is "default", representation Simple Icons Color
- text-color: text color, default to `#000000`

# Example

```typst
#import "@preview/sicons:16.0.0": *

= Typst sicons package Example

#simple-icon(slug: "typst", size: 1em, icon-color: "default")

#simple-title(slug: "typst", size: 1em, text-color: "#000000")

#simple-label(slug: "typst", size: 1em,icon-color: "default", text-color: "#000000")

#simple-raw(slug: "typst")

```

![Example page of sicons](https://github.com/cscnk52/typst-sicons/raw/refs/heads/main/test/test.svg)

# License

This package is under MIT LICENSE

Simple Icons is under CC0-1.0 and additional [legal disclaimer](https://github.com/simple-icons/simple-icons/blob/develop/DISCLAIMER.md)
