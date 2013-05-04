require File.expand_path(File.dirname(__FILE__) + '/config/environment')
require 'rake'

unless ENV['RACK_ENV'] == 'production'
  require 'rspec/core/rake_task'
  task :default => :spec
  
  n = namespace :spec do
    RSpec::Core::RakeTask.new(:models) do |spec|
      spec.pattern = 'spec/models/**/*_spec.rb'
    end
    
    RSpec::Core::RakeTask.new(:requests) do |spec|
      spec.pattern = 'spec/features/**/*_spec.rb'
    end
    
  end
  
  task :spec => [n[:models], n[:integration], n[:features]]
end

task :server do
  system 'rackup'
end
