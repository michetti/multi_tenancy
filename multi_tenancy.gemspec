$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "multi_tenancy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "multi_tenancy"
  s.version     = MultiTenancy::VERSION
  s.authors     = ["Alexandre Michetti Manduca"]
  s.email       = ["a.michetti@gmail.com"]
  s.homepage    = "http://saas-si.com.br"
  s.summary     = "Add Multi Tenancy support for building SaaS."
  s.description = "Add Multi Tenancy support for building SaaS."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.1"

  s.add_development_dependency "sqlite3"
end
