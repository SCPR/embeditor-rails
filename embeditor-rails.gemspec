$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "embeditor-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "embeditor-rails"
  s.version     = Embeditor::Rails::VERSION
  s.authors     = ["Bryan Ricker"]
  s.email       = ["bricker@kpcc.org"]
  s.homepage    = "https://github.com/SCPR/embeditor-rails"
  s.license     = 'MIT'
  s.summary     = "Embeditor plugin for Rails."
  s.description = "Embeditor is a set of client-side adapters for various " \
                  "embed codes. It aims to keep your article bodies clean " \
                  "while still allowing you to have rich embeds within them. " \
                  "This is a Rails plugin for that library."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.2.0"
  s.add_dependency "eco", "~> 1.0.0"

  s.add_development_dependency "sqlite3"
end
