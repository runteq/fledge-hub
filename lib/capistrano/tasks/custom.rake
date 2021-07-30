namespace :custom do
  desc 'Start custom task'
  task :start do
    on roles(:app) do
      execute "touch hello.txt"
    end
  end
end
