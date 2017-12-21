# -*- encoding: utf-8 -*-
#
#
Gem::Specification.new do |s|

  # avoid shelling out to run git every time the gemspec is evaluated
  #
  # @see spec/gemspec_spec.rb
  #
  gemfiles_cache = File.join(File.dirname(__FILE__), '.gemfiles')
  if File.exists?(gemfiles_cache)
    gemfiles = File.open(gemfiles_cache, "r") {|f| f.read}
    # normalize EOL
    gemfiles.gsub!(/\r\n/, "\n")
  else
    # .gemfiles missing, run 'rake gemfiles' to create it
    # falling back to 'git ls-files'"
    gemfiles = `git ls-files`
  end

  s.name        = "dynabix"
  s.version     = File.open(File.join(File.dirname(__FILE__), 'VERSION'), "r") { |f| f.read }
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Robert Wahler"]
  s.email       = ["robert@gearheadforhire.com"]
  s.homepage    = "http://rubygems.org/gems/dynabix"
  s.summary     = "An ActiveRecord 3.x Ruby gem for attribute serialization"
  s.description = "Dynabix dynamically creates read/write accessors on ActiveRecord models for storing attributes in a serialized Hash"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "dynabix"

  s.add_dependency "activerecord", "~> 3.0"

  s.add_development_dependency "bundler", ">= 1.0.14"
  s.add_development_dependency "rspec", "~> 2.9.0"
  s.add_development_dependency "aruba", "= 0.4.5"
  s.add_development_dependency "rake", "~> 0.9.2"
  s.add_development_dependency "sqlite3-ruby", ">= 0.8.7"

  # lock downs from Arubu to prevent requiring Ruby 2.0+
  s.add_development_dependency "cucumber", "~> 1.1.9"
  s.add_dependency 'tins', '~> 1.6.0'
  s.add_dependency 'term-ansicolor', '~> 1.0.7'

  # guard, watches files and runs specs and features
  #
  # @see Gemfile for platform specific dependencies
  s.add_development_dependency "guard", "~> 1.0"
  s.add_development_dependency "guard-rspec", "~> 0.6"

  s.files        = gemfiles.split("\n")
  s.executables  = gemfiles.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_paths = ["lib"]

  s.rdoc_options     = [
                         '--title', 'Dynabix Documentation',
                         '--main', 'README.markdown',
                         '--line-numbers',
                         '--inline-source'
                       ]
end
