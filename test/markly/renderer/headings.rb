# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2025, by Samuel Williams.

require "markly"

describe Markly::Renderer::Headings do
	with "basic extraction" do
		let(:markdown) do
			<<~MARKDOWN
				# Title
				
				## Section One
				
				### Subsection
				
				## Section Two
				
				### Another Subsection
			MARKDOWN
		end
		
		let(:document) {Markly.parse(markdown)}
		let(:headings) {subject.extract(document)}
		
		it "extracts all headings" do
			expect(headings.size).to be == 5
		end
		
		it "extracts heading text" do
			expect(headings[0].text).to be == "Title"
			expect(headings[1].text).to be == "Section One"
			expect(headings[2].text).to be == "Subsection"
		end
		
		it "extracts heading levels" do
			expect(headings[0].level).to be == 1
			expect(headings[1].level).to be == 2
			expect(headings[2].level).to be == 3
			expect(headings[3].level).to be == 2
		end
		
		it "generates basic anchors" do
			expect(headings[0].anchor).to be == "title"
			expect(headings[1].anchor).to be == "section-one"
			expect(headings[2].anchor).to be == "subsection"
		end
	end
	
	with "duplicate headings" do
		let(:markdown) do
			<<~MARKDOWN
				## Deployment
				
				Content about first deployment.
				
				## Deployment
				
				Content about second deployment.
				
				## Deployment
				
				Content about third deployment.
			MARKDOWN
		end
		
		let(:document) {Markly.parse(markdown)}
		let(:headings) {subject.extract(document)}
		
		it "generates unique anchors for duplicates" do
			expect(headings[0].anchor).to be == "deployment"
			expect(headings[1].anchor).to be == "deployment-2"
			expect(headings[2].anchor).to be == "deployment-3"
		end
		
		it "maintains correct text for all duplicates" do
			expect(headings[0].text).to be == "Deployment"
			expect(headings[1].text).to be == "Deployment"
			expect(headings[2].text).to be == "Deployment"
		end
	end
	
	with "nested duplicate headings" do
		let(:markdown) do
			<<~MARKDOWN
				## Kubernetes
				
				### Deployment
				
				Some content about Kubernetes deployment.
				
				## Systemd
				
				### Deployment
				
				Some content about Systemd deployment.
				
				## Docker
				
				### Deployment
				
				Some content about Docker deployment.
			MARKDOWN
		end
		
		let(:document) {Markly.parse(markdown)}
		let(:headings) {subject.extract(document)}
		
		it "generates unique anchors for nested duplicates" do
			deployment_headings = headings.select{|h| h.text == "Deployment"}
			
			expect(deployment_headings.size).to be == 3
			expect(deployment_headings[0].anchor).to be == "deployment"
			expect(deployment_headings[1].anchor).to be == "deployment-2"
			expect(deployment_headings[2].anchor).to be == "deployment-3"
		end
	end
	
	with "level filtering" do
		let(:markdown) do
			<<~MARKDOWN
				# H1 Title
				
				## H2 Section
				
				### H3 Subsection
				
				#### H4 Sub-subsection
				
				##### H5 Deep section
				
				###### H6 Deepest section
			MARKDOWN
		end
		
		let(:document) {Markly.parse(markdown)}
		
		it "can filter by min_level" do
			headings = subject.extract(document, min_level: 3)
			expect(headings.size).to be == 4
			expect(headings.map(&:level)).to be == [3, 4, 5, 6]
		end
		
		it "can filter by max_level" do
			headings = subject.extract(document, max_level: 3)
			expect(headings.size).to be == 3
			expect(headings.map(&:level)).to be == [1, 2, 3]
		end
		
		it "can filter by both min and max level" do
			headings = subject.extract(document, min_level: 2, max_level: 4)
			expect(headings.size).to be == 3
			expect(headings.map(&:level)).to be == [2, 3, 4]
		end
	end
	
	with "instance-based extraction" do
		let(:markdown) do
			<<~MARKDOWN
				## Test
				
				## Test
				
				## Another
				
				## Test
			MARKDOWN
		end
		
		let(:document) {Markly.parse(markdown)}
		
		it "maintains state across multiple anchor_for calls" do
			extractor = subject.new
			
			headings = []
			document.walk do |node|
				if node.type == :header
					anchor = extractor.anchor_for(node)
					headings << anchor
				end
			end
			
			expect(headings).to be == ["test", "test-2", "another", "test-3"]
		end
	end
	
	with "special characters" do
		let(:markdown) do
			<<~MARKDOWN
				## Getting Started
				
				## API Reference
				
				## Getting Started
				
				## Special!@# Characters
				
				## Special!@# Characters
			MARKDOWN
		end
		
		let(:document) {Markly.parse(markdown)}
		let(:headings) {subject.extract(document)}
		
		it "handles duplicates with special characters" do
			expect(headings[3].anchor).to be == "special!@#-characters"
			expect(headings[4].anchor).to be == "special!@#-characters-2"
		end
		
		it "handles duplicates with mixed content" do
			expect(headings[0].anchor).to be == "getting-started"
			expect(headings[2].anchor).to be == "getting-started-2"
		end
	end
	
	with "empty document" do
		let(:markdown) {"Just some text without headings."}
		let(:document) {Markly.parse(markdown)}
		let(:headings) {subject.extract(document)}
		
		it "returns empty array" do
			expect(headings).to be == []
		end
	end
	
	with "headings with inline formatting" do
		let(:markdown) do
			<<~MARKDOWN
				## **Bold** Heading
				
				## *Italic* Heading
				
				## `Code` Heading
				
				## **Bold** Heading
			MARKDOWN
		end
		
		let(:document) {Markly.parse(markdown)}
		let(:headings) {subject.extract(document)}
		
		it "strips formatting from text" do
			expect(headings[0].text).to be == "Bold Heading"
			expect(headings[1].text).to be == "Italic Heading"
			expect(headings[2].text).to be == "Code Heading"
		end
		
		it "generates anchors without formatting" do
			expect(headings[0].anchor).to be == "bold-heading"
			expect(headings[3].anchor).to be == "bold-heading-2"
		end
	end
end

