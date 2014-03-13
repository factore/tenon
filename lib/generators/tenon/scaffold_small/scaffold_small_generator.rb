require File.join(File.dirname(__FILE__), '..', 'scaffold', 'scaffold_generator.rb')
module Tenon
  module Generators
    class ScaffoldSmallGenerator < Tenon::Generators::ScaffoldGenerator
      source_root File.expand_path('../templates', __FILE__)
    end
  end
end
