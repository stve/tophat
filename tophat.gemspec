# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tophat/version"

Gem::Specification.new do |s|
  s.name        = 'tophat'
  s.version     = TopHat::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Steve Agalloco"]
  s.email       = ['steve.agalloco@gmail.com']
  s.homepage    = "https://github.com/spagalloco/tophat"
  s.description = %q{simple view helpers for your layouts}
  s.summary     = %q{simple view helpers for your layouts}

  s.add_runtime_dependency('actionpack', '>= 2.3.5')

  s.add_development_dependency('shoulda', '>= 0')
  s.add_development_dependency('yard', '~> 0.6')
  s.add_development_dependency('maruku', '~> 0.6')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

