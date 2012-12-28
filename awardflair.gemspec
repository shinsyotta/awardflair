# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'awardflair/version'

Gem::Specification.new do |gem|
  gem.name          = "awardflair"
  gem.version       = Awardflair::VERSION
  gem.authors       = ["Matt Lally"]
  gem.email         = ["shinsyotta@gmail.com"]
  gem.description   = %q{Award flair (badges) to users of your app using the PickFlair service.}
  gem.summary       = %q{A gem for awarding badges via PickFlair.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
