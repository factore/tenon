require 'rspec'
require 'rspec/core/formatters/json_formatter'
require 'rspec/core/formatters/progress_formatter'

module Overcommit
  module Hook
    module PreCommit
      # run all specs before committing
      class Rspec < Base
        def run
          config = RSpec.configuration
          config.color = true
          config.fail_fast = true

          json_formatter = RSpec::Core::Formatters::JsonFormatter.new(config.output)
          progress_formatter = RSpec::Core::Formatters::ProgressFormatter.new($stdout)

          reporter =  RSpec::Core::Reporter.new(json_formatter, progress_formatter)
          config.instance_variable_set(:@reporter, reporter)

          RSpec::Core::Runner.run(['spec'])

          :good if json_formatter.output_hash[:summary][:failure_count] == 0
        end
      end
    end
  end
end
