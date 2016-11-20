namespace :periodic do
  desc 'runs daily'
  task :daily => [
    'scraper:update_fixtures'
  ]
end
