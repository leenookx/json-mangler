require 'rubygems'
require 'spec/expectations'
require "test/unit"

# We'll have some unicode support please.
require 'cucumber/formatter/unicode'

mangler_file = File.join(File.dirname(__FILE__), *%w[.. .. lib json-mangler json_mangler.rb])
require mangler_file
extractor_file = File.join(File.dirname(__FILE__), *%w[.. .. lib json-mangler json_extractor.rb])
require extractor_file

 
World do
  include Test::Unit::Assertions
end

