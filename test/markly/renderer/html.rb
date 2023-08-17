# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2023, by Samuel Williams.

require 'markly'

describe Markly::Renderer::HTML do
	let(:markdown) {"# Introduction\nHi *there*"}
	let(:document) {Markly.parse(markdown)}
	let(:renderer) {subject.new}
	
	it "can render HTML" do
		expect(renderer.render(document)).to be == "<h1>Introduction</h1>\n<p>Hi <em>there</em></p>\n"
	end
	
	with "ids" do
		let(:renderer) {subject.new(ids: true)}
		
		it "can render HTML with ids" do
			expect(renderer.render(document)).to be == "<section id=\"introduction\"><h1>Introduction</h1>\n<p>Hi <em>there</em></p>\n</section>"
		end
	end
	
	with "multiple tables" do
		let(:markdown) do
			<<~MARKDOWN
				| Input       | Expected         | Actual    |
				| ----------- | ---------------- | --------- |
				| One         | Two              | Three     |
				
				| Header   | Row  | Example |
				| :------: | ---: | :------ |
				| Foo      | Bar  | Baz     |
			MARKDOWN
		end
		let(:document) {Markly.parse(markdown, extensions: %i[autolink table tagfilter])}
		
		it "can render multiple tables" do
			expect(renderer.render(document).scan(/<tbody>/).size).to be == 2
		end
		
		it "generates the same output as the built in renderer" do
			expect(renderer.render(document)).to be == document.to_html
		end
	end
	
	with "footnotes" do
		let(:markdown) {"Hello[^hi].\n\n[^hi]: Hey!\n"}
		let(:document) {Markly.parse(markdown, flags: Markly::FOOTNOTES)}
		
		it "can render footnotes" do
			expect(renderer.render(document)).to be == <<~HTML
				<p>Hello<sup class="footnote-ref"><a href="#fn-hi" id="fnref-hi" data-footnote-ref>1</a></sup>.</p>
				<section class="footnotes" data-footnotes>
				<ol>
				<li id="fn-hi">
				<p>Hey! <a href="#fnref-hi" class="footnote-backref" data-footnote-backref data-footnote-backref-idx="1" aria-label="Back to reference 1">↩</a></p>
				</li>
				</ol>
				</section>
			HTML
		end
		
		it "generates the same output as the built in renderer" do
			expect(renderer.render(document)).to be == document.to_html
		end
	end
end
