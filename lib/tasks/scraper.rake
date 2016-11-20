namespace :scraper do
  desc 'Get fixtures from bbc'
  task :update_fixtures => :environment do
    FixtureScraper.update_fixtures
  end
end
