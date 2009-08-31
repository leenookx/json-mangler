# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{json-mangler}
  s.version = "0.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["lee nookx"]
  s.date = %q{2009-08-31}
  s.description = %q{JSON data format mangling tools.}
  s.email = %q{lnookx@googlemail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".autotest",
     ".gitignore",
     "History.txt",
     "LICENSE",
     "Manifest.txt",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "features/create.feature",
     "features/extraction.feature",
     "features/group.feature",
     "features/mocks/calais.json",
     "features/mocks/empty.json",
     "features/mocks/extraction.json",
     "features/mocks/extraction2.json",
     "features/mocks/grouped.json",
     "features/mocks/non_grouped.json",
     "features/mocks/valid.json",
     "features/prune.feature",
     "features/step_definitions/creation_steps.rb",
     "features/step_definitions/extaction_steps.rb",
     "features/step_definitions/groups_steps.rb",
     "features/step_definitions/prune_steps.rb",
     "features/support/env.rb",
     "features/test_comparisons/2level_extraction.json",
     "features/test_comparisons/array_extraction.json",
     "features/test_comparisons/author_extraction.json",
     "features/test_comparisons/empty_extraction.json",
     "features/test_comparisons/published_extraction.json",
     "json-mangler.gemspec",
     "lib/json-mangler.rb",
     "lib/json-mangler/json_extractor.rb",
     "lib/json-mangler/json_mangler.rb",
     "test/test_json_mangler.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/leenookx/json-mangler}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{JSON data format mangling tools.}
  s.test_files = [
    "test/test_json_mangler.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
