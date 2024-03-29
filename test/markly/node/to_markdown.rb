# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2016-2017, by Yuki Izumi.
# Copyright, 2016-2019, by Garen Torikian.
# Copyright, 2020-2023, by Samuel Williams.

require 'markly'

MARKDOWN = <<~MARKDOWN
Hi *there*!

1. I am a numeric list.
2. I continue the list.
* Suddenly, an unordered list!
* What fun!

Okay, _enough_.

| a   | b   |
| --- | --- |
| c   | d   |
MARKDOWN

HTML_COMMENT = /<!--.*?-->\s?/

describe Markly::Node do
	let(:document) {Markly.parse(MARKDOWN, extensions: %i[table])}
	
	with '#to_markdown' do
		it "can generate equivalent HTML" do
			markdown = document.to_markdown
			html = Markly.parse(markdown, extensions: %i[table]).to_html
			html.gsub!(HTML_COMMENT, '')
			
			expect(html).to be == document.to_html
		end
	end
end
