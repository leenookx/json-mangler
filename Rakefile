# -*- ruby -*-

require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
  t.rcov = true
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "json-mangler"
    gemspec.summary = "JSON data format mangling tools."
    gemspec.description = "JSON data format mangling tools."
    gemspec.email = "lnookx@googlemail.com"
    gemspec.homepage = "http://github.com/leenookx/json-mangler"
    gemspec.description = "TODO"
    gemspec.authors = ["lee nookx"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end


# vim: syntax=ruby
