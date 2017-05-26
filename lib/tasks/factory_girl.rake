namespace :industrialization do
  namespace :factory_girl do
    task :create, %I[command path method] => %I[environment create_factory]

    task :create_factory, %I[command path method] do |_t, args|
      command = args[:command] || ''
      path = args[:path] || 'spec/factories'
      method = args[:method] || :serializable_hash

      # rubocop:disable Eval
      obj = eval(command)
      # rubocop:enable Eval

      status = Industrialization::Factory.call(obj: obj,
                                               factories_path: path,
                                               serialization_method: method)
      $stdout << status
    end
  end
end
