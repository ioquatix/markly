# frozen_string_literal: true

source 'https://rubygems.org/'

gemspec

group :maintenance, optional: true do
	gem "bake-modernize"
	gem "bake-gem"
end

group :benchmark do
	# gem 'github-markdown'
	gem 'kramdown'
	gem 'redcarpet'
end
