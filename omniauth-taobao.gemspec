# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-taobao/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-taobao"
  s.version     = Omniauth::Taobao::VERSION
  s.authors     = ["Scott Ballantyne"]
  s.email       = ["ussballantyne@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{an omniauth strategy for taobao}
  s.description = %q{an omniauth strategy for taobao}

  s.rubyforge_project = "omniauth-taobao"
  s.add_dependency 'omniauth', '~> 1.0.0.rc2'
  s.add_dependency 'omniauth-oauth2', '~> 1.0.0.rc2'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
