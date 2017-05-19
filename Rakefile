require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

import './lib/tasks/create_factory_girl.rake'

task default: :spec
