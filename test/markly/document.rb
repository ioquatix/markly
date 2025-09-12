# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2014, by John MacFarlane.
# Copyright, 2015-2019, by Garen Torikian.
# Copyright, 2020-2025, by Samuel Williams.

require "markly"

describe Markly::Node do
	let(:document) {Markly.parse("Hi *there*")}
	
	with "#to_html" do
		it "can convert to HTML" do
			expect(document.to_html).to be == "<p>Hi <em>there</em></p>\n"
		end
	end
	
	with "#render_html" do
		it "can convert to HTML" do
			expect(Markly.render_html("Hi *there*")).to be == "<p>Hi <em>there</em></p>\n"
		end
	end
end
