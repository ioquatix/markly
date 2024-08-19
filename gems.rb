# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2014, by John MacFarlane.
# Copyright, 2015-2019, by Garen Torikian.
# Copyright, 2020-2024, by Samuel Williams.

source 'https://rubygems.org/'

gemspec

group :maintenance, optional: true do
	gem "bake-gem"
	gem "bake-modernize"
	
	gem "build-files", "~> 1.9"
	gem "utopia-project"
end

group :test do
	gem "sus"
	gem "covered"
	gem "decode"
	gem "rubocop"
	
	gem "bake"
	gem "bake-test"
end

group :benchmark do
	# gem 'github-markdown'
	gem 'kramdown'
	gem 'redcarpet'
end
