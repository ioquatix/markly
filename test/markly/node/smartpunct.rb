# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2015-2019, by Garen Torikian.
# Copyright, 2017, by Yuki Izumi.
# Copyright, 2020-2023, by Samuel Williams.

require 'markly'
require 'markdown_spec'

describe Markly do
	with "Markly::SMART" do
		# I don't really know what this is testing?
		it "doesn't doesn't insert spaces for smart punctuation" do
			markdown = "\"foo\"\nbaz"
			result = "<p>“foo”<br />\nbaz</p>\n"
			doc = Markly.parse(markdown, flags: Markly::SMART)
			expect(result).to be == doc.to_html(flags: Markly::HARD_BREAKS)
		end
	end
end
