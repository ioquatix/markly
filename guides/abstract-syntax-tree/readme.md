# Abstract Syntax Tree

This guide explains how to use Markly's abstract syntax tree (AST) to parse and manipulate Markdown documents.

## Parsing

You can parse Markdown to a `Document` node using `Markly.parse`:

~~~ ruby
require 'markly'

document = Markly.parse('*Hello* world')

pp document 
~~~

This will print out the following:

~~~
#<Markly::Node(document):
	source_position={:start_line=>1, :start_column=>1, :end_line=>1, :end_column=>13}
	children=[#<Markly::Node(paragraph):
			 source_position={:start_line=>1, :start_column=>1, :end_line=>1, :end_column=>13}
			 children=[#<Markly::Node(emph):
						source_position={:start_line=>1, :start_column=>1, :end_line=>1, :end_column=>7}
						children=[#<Markly::Node(text): source_position={:start_line=>1, :start_column=>2, :end_line=>1, :end_column=>6}, string_content="Hello">]>,
					#<Markly::Node(text): source_position={:start_line=>1, :start_column=>8, :end_line=>1, :end_column=>13}, string_content=" world">]>]>
~~~

As you can see, a document consists of a root node, which contains several children, they themselves containing children, and so on. We refer to this as the abstract syntax tree (AST).

## Example: Walking the AST

You can use `walk` or `each` to iterate over nodes:

	- `walk` will iterate on a node and recursively iterate on a node's children.
	- `each` will iterate on a node and its children, but no further.

<!-- end list -->

``` ruby
require "markly"

document = Markly.parse("# The site\n\n [GitHub](https://www.github.com)")

# Walk tree and print out URLs for links:
document.walk do |node|
	if node.type == :link
		puts "URL = #{node.url}"
	end
end

# Capitalize all regular text in headers:
document.walk do |node|
	if node.type == :header
		node.each do |subnode|
			if subnode.type == :text
				subnode.string_content = subnode.string_content.upcase
			end
		end
	end
end

# Transform links to regular text:
document.walk do |node|
	if node.type == :link
		node.insert_before(node.first_child)
		node.delete
	end
end
```

### Creating a Custom Renderer

You can also derive a class from {ruby Markly::Renderer::HTML} class. Using a pure Ruby renderer is slower, but allows you to customize the output. For example:

``` ruby
class MyHtmlRenderer < Markly::Renderer::HTML
	def initialize
		super
		@header_id = 1
	end
	
	def header(node)
		block do
			out("<h", node.header_level, " id=\"", @header_id, "\">", :children, "</h", node.header_level, ">")
			@header_id += 1
		end
	end
end

my_renderer = MyHtmlRenderer.new
puts my_renderer.render(document)
```
