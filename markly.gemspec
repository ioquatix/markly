# frozen_string_literal: true

require_relative "lib/markly/version"

Gem::Specification.new do |spec|
	spec.name = "markly"
	spec.version = Markly::VERSION
	
	spec.summary = "CommonMark parser and renderer. Written in C, wrapped in Ruby."
	spec.authors = ["Garen Torikian", "Yuki Izumi", "Samuel Williams", "John MacFarlane", "Ashe Connor", "Nick Wellnhofer", "Brett Walker", "Andrew Anderson", "Ben Woosley", "Goro Fuji", "Tomoya Chiba", "Akira Matsuda", "Danny Iachini", "Jerry van Leeuwen", "Michael Camilleri", "Mu-An Chiou", "Olle Jonsson", "Roberto Hidalgo", "Vitaliy Klachkov"]
	spec.license = "MIT"
	
	spec.cert_chain  = ['release.cert']
	spec.signing_key = File.expand_path('~/.gem/release.pem')
	
	spec.homepage = "https://github.com/ioquatix/markly"
	
	spec.metadata = {
		"funding_uri" => "https://github.com/sponsors/ioquatix/",
		"documentation_uri" => "https://ioquatix.github.io/markly/",
	}
	
	spec.files = Dir.glob(['{ext,lib}/**/*', '*.md'], File::FNM_DOTMATCH, base: __dir__)
	spec.require_paths = ['lib']
	
	spec.extensions = ["ext/markly/extconf.rb"]
	
	spec.required_ruby_version = ">= 2.5"
end
