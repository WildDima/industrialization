namespace :industrialization do
  namespace :factory_girl do
    if defined?(Rails)
      task :create, %I[command path] => %I[environment create_factory]
    else
      task :create, %I[command path] => :create_factory
    end

    task :create_factory, %I[command path] do |_t, args|
      command = args[:command] || ''
      path = args[:path] || 'spec/factories'

      puts command
      puts path
    end
  end
end
