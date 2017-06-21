require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task default: [:spec]

task ARGV[0] do |t| 
  ruby File.expand_path("tests/#{t}.rb")
end
