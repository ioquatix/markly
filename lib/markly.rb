#!/usr/bin/env ruby
# frozen_string_literal: true

# The compiled library.
require 'markly/markly'

require 'markly/flags'
require 'markly/node'
require 'markly/renderer'
require 'markly/renderer/html_renderer'
require 'markly/version'

module Markly
  # Public: Parses a Markdown string into a `document` node.
  #
  # string - {String} to be parsed
  # option - A {Symbol} or {Array of Symbol}s indicating the parse options
  # extensions - An {Array of Symbol}s indicating the extensions to use
  #
  # Returns the `parser` node.
  def self.parse(text, flags: DEFAULT, extensions: nil)
    parser = Parser.new(flags)
    
    extensions&.each do |extension|
      parser.enable(extension)
    end
    
    return parser.parse(text.encode(Encoding::UTF_8))
  end
  
  # Public:  Parses a Markdown string into an HTML string.
  #
  # text - A {String} of text
  # option - Either a {Symbol} or {Array of Symbol}s indicating the render options
  # extensions - An {Array of Symbol}s indicating the extensions to use
  #
  # Returns a {String} of converted HTML.
  def self.render_html(text, flags: DEFAULT, extensions: nil)
    root = self.parse(text, extensions: extensions)
    
    return root.to_html(flags: flags)
  end
end
