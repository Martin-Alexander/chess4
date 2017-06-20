require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task default: [:spec]

require_relative 'test/test'
task(:test) { RunTests.run }