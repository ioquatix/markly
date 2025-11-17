# Markly

A parser and abstract syntax tree for Markdown documents (CommonMark compatible) in Ruby. Originally forked from
[CommonMarker](https://github.com/gjtorikian/commonmarker). It also includes extensions to the CommonMark spec as
documented in the [GitHub Flavored Markdown spec](http://github.github.com/gfm/), such as support for tables,
strikethroughs, and autolinking.

[![Development Status](https://github.com/ioquatix/markly/workflows/Test/badge.svg)](https://github.com/ioquatix/markly/actions?workflow=Test)

## Motivation

This code base was originally forked from [Commonmarker](https://github.com/gjtorikian/commonmarker) before they
switched from `cmark-gfm` (C) to `comrak` (Rust). This fork was created to preserve the original C extension logic and provide alternate features.

## Usage

Please see the [project documentation](https://ioquatix.github.io/markly/) for more details.

  - [Getting Started](https://ioquatix.github.io/markly/guides/getting-started/index) - This guide explains now to install and use Markly.

  - [Abstract Syntax Tree](https://ioquatix.github.io/markly/guides/abstract-syntax-tree/index) - This guide explains how to use Markly's abstract syntax tree (AST) to parse and manipulate Markdown documents.

## Releases

Please see the [project releases](https://ioquatix.github.io/markly/releases/index) for all releases.

### v0.14.0

  - Expose `Markly::Renderer::HTML.anchor_for` method to generate URL-safe anchors from headers.

## Contributing

We welcome contributions to this project.

1.  Fork it.
2.  Create your feature branch (`git checkout -b my-new-feature`).
3.  Commit your changes (`git commit -am 'Add some feature'`).
4.  Push to the branch (`git push origin my-new-feature`).
5.  Create new Pull Request.

### Developer Certificate of Origin

In order to protect users of this project, we require all contributors to comply with the [Developer Certificate of Origin](https://developercertificate.org/). This ensures that all contributions are properly licensed and attributed.

### Community Guidelines

This project is best served by a collaborative and respectful environment. Treat each other professionally, respect differing viewpoints, and engage constructively. Harassment, discrimination, or harmful behavior is not tolerated. Communicate clearly, listen actively, and support one another. If any issues arise, please inform the project maintainers.
