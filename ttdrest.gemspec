# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ttdrest/version'

Gem::Specification.new do |spec|
  spec.name          = "ttdrest"
  spec.version       = Ttdrest::VERSION
  spec.authors       = ["Eric Vass"]
  spec.email         = ["ericrvass@gmail.com"]
  spec.summary       = %q{TTD API Ruby Client}
  #spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  #spec.files         = `git ls-files -z`.split("\x0")
  spec.files         = Dir["README.md","Gemfile","Rakefile", "lib/*", "lib/ttdrest/*", "lib/ttdrest/concerns/**/*"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
