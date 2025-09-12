#!/usr/bin/env ruby
# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2014, by John MacFarlane.
# Copyright, 2015-2019, by Garen Torikian.
# Copyright, 2020-2025, by Samuel Williams.

require "benchmark/ips"

$LOAD_PATH << ::File.expand_path("../ext", __dir__)

require "markly"
require "commonmarker"
require "kramdown"

MARKDOWN = File.open("sample.md", "r").read

Benchmark.ips do |x|
	x.report("Markly.render_html") do
		Markly.render_html(MARKDOWN)
	end
	
	x.report("Markly::Node#to_html") do
		Markly.parse(MARKDOWN).to_html
	end
	
	x.report("Markly::Renderer::HTML") do
		Markly::Renderer::HTML.new.render(Markly.parse(MARKDOWN))
	end
	
	x.report("Commonmarker.render_html") do
		CommonMarker.render_html(MARKDOWN)
	end
	
	x.report("Kramdown::Document#to_html") do
		Kramdown::Document.new(MARKDOWN).to_html
	end
	
	# Compare the iterations per second of the various reports!
	x.compare!
end
