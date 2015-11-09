# encoding: utf-8

$:.push(File.expand_path(File.dirname(__FILE__) + '/lib'))
require "wigle_api/version"

Gem::Specification.new do |gem|
  gem.name              = "wigle_api"
  gem.version           = WigleApi::VERSION
  gem.authors           = ["Sam Stelfox", "Patryk Ptasinski"]
  gem.email             = ["sstelfox+rubygems@bedroomprogrammers.net", "rubygithub@ipepe.pl"]
  gem.homepage          = "https://github.com/sstelfox/wigle_api"
  gem.license           = "MIT"

  gem.summary           = "An 'API' for WiGLE.net"
  gem.description       = "Provides an easy way to scrape WiGLE.net for small amounts of data."

  gem.rubyforge_project = "wigle_api"

  gem.files             = `git ls-files`.split($\)
  gem.test_files        = gem.files.grep(%r{^spec/})
  gem.executables       = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.require_paths     = ["lib"]

  gem.add_runtime_dependency "nokogiri"
  gem.add_development_dependency "rspec"

  gem.required_ruby_version = '>= 1.9.2'
end

