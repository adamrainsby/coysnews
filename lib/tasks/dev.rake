namespace :dev do
  desc 'Sync production database'
  task :sync_db do
    Bundler.with_clean_env do
      `dropdb coysnews_development`
      `dropdb coysnews_test`
      `heroku pg:pull DATABASE_URL coysnews_development -a coysnews`
      `RAILS_ENV=test bundle exec rake db:create`
    end
  end
end
