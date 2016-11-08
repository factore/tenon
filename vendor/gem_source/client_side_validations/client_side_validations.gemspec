# -*- encoding: utf-8 -*-
# stub: client_side_validations 5.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "client_side_validations"
  s.version = "5.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Geremia Taglialatela", "Brian Cardarella"]
  s.date = "2016-09-14"
  s.description = "Client Side Validations made easy for your Rails 5 applications"
  s.email = ["tagliala.dev@gmail.com", "bcardarella@gmail.com"]
  s.files = ["HISTORY.md", "README.md", "lib/client_side_validations.rb", "lib/client_side_validations/action_view.rb", "lib/client_side_validations/action_view/form_builder.rb", "lib/client_side_validations/action_view/form_helper.rb", "lib/client_side_validations/action_view/form_tag_helper.rb", "lib/client_side_validations/active_model.rb", "lib/client_side_validations/active_model/absence.rb", "lib/client_side_validations/active_model/acceptance.rb", "lib/client_side_validations/active_model/exclusion.rb", "lib/client_side_validations/active_model/format.rb", "lib/client_side_validations/active_model/inclusion.rb", "lib/client_side_validations/active_model/length.rb", "lib/client_side_validations/active_model/numericality.rb", "lib/client_side_validations/active_model/presence.rb", "lib/client_side_validations/active_record.rb", "lib/client_side_validations/active_record/middleware.rb", "lib/client_side_validations/active_record/uniqueness.rb", "lib/client_side_validations/config.rb", "lib/client_side_validations/core_ext.rb", "lib/client_side_validations/core_ext/range.rb", "lib/client_side_validations/core_ext/regexp.rb", "lib/client_side_validations/engine.rb", "lib/client_side_validations/files.rb", "lib/client_side_validations/generators.rb", "lib/client_side_validations/generators/rails_validations.rb", "lib/client_side_validations/middleware.rb", "lib/client_side_validations/version.rb", "lib/generators/client_side_validations/copy_assets_generator.rb", "lib/generators/client_side_validations/install_generator.rb", "lib/generators/templates/client_side_validations/initializer.rb", "vendor/assets/javascripts/rails.validations.js"]
  s.homepage = "https://github.com/DavyJonesLocker/client_side_validations"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Client Side Validations"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["< 5.1.0", ">= 5.0.0.rc2"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 4.0.1", "~> 4.0"])
      s.add_runtime_dependency(%q<js_regex>, [">= 1.0.9", "~> 1.0"])
      s.add_development_dependency(%q<appraisal>, ["~> 2.1"])
      s.add_development_dependency(%q<byebug>, ["~> 9.0"])
      s.add_development_dependency(%q<coveralls>, ["~> 0.8.14"])
      s.add_development_dependency(%q<m>, ["~> 1.5"])
      s.add_development_dependency(%q<minitest>, ["< 6.0.0", ">= 4.7.5"])
      s.add_development_dependency(%q<mocha>, ["~> 1.1"])
      s.add_development_dependency(%q<rake>, ["~> 11.2"])
      s.add_development_dependency(%q<rubocop>, ["~> 0.41.1"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.12.0"])
      s.add_development_dependency(%q<sqlite3>, ["~> 1.3"])
      s.add_development_dependency(%q<sinatra>, ["~> 2.0"])
      s.add_development_dependency(%q<shotgun>, ["~> 0.9.1"])
      s.add_development_dependency(%q<thin>, ["~> 1.7"])
      s.add_development_dependency(%q<coffee-script>, ["~> 2.4"])
    else
      s.add_dependency(%q<rails>, ["< 5.1.0", ">= 5.0.0.rc2"])
      s.add_dependency(%q<jquery-rails>, [">= 4.0.1", "~> 4.0"])
      s.add_dependency(%q<js_regex>, [">= 1.0.9", "~> 1.0"])
      s.add_dependency(%q<appraisal>, ["~> 2.1"])
      s.add_dependency(%q<byebug>, ["~> 9.0"])
      s.add_dependency(%q<coveralls>, ["~> 0.8.14"])
      s.add_dependency(%q<m>, ["~> 1.5"])
      s.add_dependency(%q<minitest>, ["< 6.0.0", ">= 4.7.5"])
      s.add_dependency(%q<mocha>, ["~> 1.1"])
      s.add_dependency(%q<rake>, ["~> 11.2"])
      s.add_dependency(%q<rubocop>, ["~> 0.41.1"])
      s.add_dependency(%q<simplecov>, ["~> 0.12.0"])
      s.add_dependency(%q<sqlite3>, ["~> 1.3"])
      s.add_dependency(%q<sinatra>, ["~> 2.0"])
      s.add_dependency(%q<shotgun>, ["~> 0.9.1"])
      s.add_dependency(%q<thin>, ["~> 1.7"])
      s.add_dependency(%q<coffee-script>, ["~> 2.4"])
    end
  else
    s.add_dependency(%q<rails>, ["< 5.1.0", ">= 5.0.0.rc2"])
    s.add_dependency(%q<jquery-rails>, [">= 4.0.1", "~> 4.0"])
    s.add_dependency(%q<js_regex>, [">= 1.0.9", "~> 1.0"])
    s.add_dependency(%q<appraisal>, ["~> 2.1"])
    s.add_dependency(%q<byebug>, ["~> 9.0"])
    s.add_dependency(%q<coveralls>, ["~> 0.8.14"])
    s.add_dependency(%q<m>, ["~> 1.5"])
    s.add_dependency(%q<minitest>, ["< 6.0.0", ">= 4.7.5"])
    s.add_dependency(%q<mocha>, ["~> 1.1"])
    s.add_dependency(%q<rake>, ["~> 11.2"])
    s.add_dependency(%q<rubocop>, ["~> 0.41.1"])
    s.add_dependency(%q<simplecov>, ["~> 0.12.0"])
    s.add_dependency(%q<sqlite3>, ["~> 1.3"])
    s.add_dependency(%q<sinatra>, ["~> 2.0"])
    s.add_dependency(%q<shotgun>, ["~> 0.9.1"])
    s.add_dependency(%q<thin>, ["~> 1.7"])
    s.add_dependency(%q<coffee-script>, ["~> 2.4"])
  end
end
