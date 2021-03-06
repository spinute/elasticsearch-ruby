# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elasticsearch/transport/version'

Gem::Specification.new do |s|
  s.name          = "elasticsearch-transport"
  s.version       = Elasticsearch::Transport::VERSION
  s.authors       = ["Karel Minarik"]
  s.email         = ["karel.minarik@elasticsearch.org"]
  s.summary       = "Ruby client for Elasticsearch."
  s.homepage      = "https://github.com/elasticsearch/elasticsearch-ruby/tree/master/elasticsearch-transport"
  s.license       = "Apache-2.0"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.extra_rdoc_files  = [ "README.md", "LICENSE" ]
  s.rdoc_options      = [ "--charset=UTF-8" ]

  s.required_ruby_version = '>= 1.9'

  s.add_dependency "multi_json"
  s.add_dependency "faraday", '>= 0.14', "< 2"

  if defined?(RUBY_VERSION) && RUBY_VERSION < '1.9'
    s.add_dependency "system_timer"
  end

  s.add_development_dependency "bundler"

  if defined?(RUBY_VERSION) && RUBY_VERSION > '1.9'
    s.add_development_dependency "rake", "~> 11.1"
  else
    s.add_development_dependency "rake", "< 11.0"
  end

  s.add_development_dependency "ansi"
  s.add_development_dependency "shoulda-context"
  s.add_development_dependency "mocha"
  s.add_development_dependency "yard"
  s.add_development_dependency "pry"

  # Gems for testing integrations
  s.add_development_dependency "curb"   unless defined? JRUBY_VERSION
  s.add_development_dependency "patron" unless defined? JRUBY_VERSION
  s.add_development_dependency "typhoeus", '~> 0.6'
  s.add_development_dependency "net-http-persistent"
  s.add_development_dependency "httpclient"
  s.add_development_dependency "manticore", '~> 0.6' if defined? JRUBY_VERSION
  s.add_development_dependency "hashie"

  # Prevent unit test failures on Ruby 1.8
  if defined?(RUBY_VERSION) && RUBY_VERSION < '1.9'
    s.add_development_dependency "test-unit", '~> 2'
    s.add_development_dependency "json", '~> 1.8'
  end

  if defined?(RUBY_VERSION) && RUBY_VERSION > '1.9'
    s.add_development_dependency "minitest"
    s.add_development_dependency "minitest-reporters"
    s.add_development_dependency "elasticsearch-extensions"
    s.add_development_dependency "ruby-prof"    unless defined?(JRUBY_VERSION) || defined?(Rubinius)
    s.add_development_dependency "require-prof" unless defined?(JRUBY_VERSION) || defined?(Rubinius)
    s.add_development_dependency "simplecov"
    s.add_development_dependency "simplecov-rcov"
    s.add_development_dependency "cane"
  end

  if defined?(RUBY_VERSION) && RUBY_VERSION > '2.2'
    s.add_development_dependency "test-unit", '~> 2'
  end

  s.description = <<-DESC.gsub(/^    /, '')
    Ruby client for Elasticsearch. See the `elasticsearch` gem for full integration.
  DESC
end
