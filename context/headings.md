# Headings

This guide explains how to work with headings in Markly, including extracting them for navigation and handling duplicate heading text.

## Unique ID Generation

When rendering HTML with `ids: true`, duplicate heading text automatically gets unique IDs to avoid collisions. This is particularly useful when multiple sections have the same title (e.g., multiple "Deployment" sections under different parent headings).

``` ruby
markdown = <<~MARKDOWN
  ## Kubernetes
  
  ### Deployment
  
  ## Systemd
  
  ### Deployment
MARKDOWN

renderer = Markly::Renderer::HTML.new(ids: true)
html = renderer.render(Markly.parse(markdown))

# Generates:
# <section id="kubernetes">...</section>
# <section id="deployment">...</section>
# <section id="systemd">...</section>
# <section id="deployment-2">...</section>
```

The first occurrence gets the clean ID, subsequent duplicates get numbered suffixes (`-2`, `-3`, etc.).

## Extracting Headings for Table of Contents

The `Headings` class can extract headings for building navigation or table of contents:

``` ruby
document = Markly.parse(markdown)
headings = Markly::Renderer::Headings.extract(document, min_level: 2, max_level: 3)

headings.each do |heading|
  puts "#{heading.level}: #{heading.text} (#{heading.anchor})"
end

# Output:
# 2: Kubernetes (kubernetes)
# 3: Deployment (deployment)
# 2: Systemd (systemd)
# 3: Deployment (deployment-2)
```

Each `Heading` object has:
- `level` - The heading level (1-6)
- `text` - The plain text content
- `anchor` - The unique ID/anchor
- `node` - The original Markly AST node

### Level Filtering

Use `min_level` and `max_level` to filter which heading levels to extract:

``` ruby
# Only extract h2 and h3 headings
headings = Markly::Renderer::Headings.extract(document, min_level: 2, max_level: 3)

# Only h1 headings
headings = Markly::Renderer::Headings.extract(document, min_level: 1, max_level: 1)
```

## Custom Heading Strategies

For advanced use cases, you can provide a custom `Headings` instance to the HTML renderer:

### Sharing State Across Documents

To ensure IDs remain unique across multiple documents:

``` ruby
# Share heading state across multiple documents
headings = Markly::Renderer::Headings.new
renderer = Markly::Renderer::HTML.new(headings: headings)

doc1_html = renderer.render(Markly.parse(doc1_markdown))
doc2_html = renderer.render(Markly.parse(doc2_markdown))
# IDs remain unique across both documents
```

### Custom ID Generation

Subclass `Headings` to implement alternative ID generation strategies:

``` ruby
class HierarchicalHeadings < Markly::Renderer::Headings
  def initialize
    super
    @parent_context = []
  end
  
  def anchor_for(node)
    base = base_anchor_for(node)
    
    # Custom logic: could incorporate parent heading context
    # to generate IDs like "kubernetes-deployment" instead of "deployment-2"
    
    if @ids.key?(base)
      @ids[base] += 1
      "#{base}-#{@ids[base]}"
    else
      @ids[base] = 1
      base
    end
  end
end

renderer = Markly::Renderer::HTML.new(headings: HierarchicalHeadings.new)
```

