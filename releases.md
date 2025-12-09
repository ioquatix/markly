# Releases

## v0.15.1

  - Add agent context.

## v0.15.0

  - Introduced `Markly::Renderer::Headings` class for extracting headings from markdown documents with automatic duplicate ID resolution. When rendering HTML with `ids: true`, duplicate heading text now automatically gets unique IDs (`deployment`, `deployment-2`, `deployment-3`). The `Headings` class can also be used to extract headings for building navigation or table of contents.

## v0.14.0

  - Expose `Markly::Renderer::HTML.anchor_for` method to generate URL-safe anchors from headers.
