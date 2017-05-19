module Industrialization
  # Railtie
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/factory_girl.rake'
    end
  end
end
