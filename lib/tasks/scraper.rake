namespace :scraper do
  desc 'Get fixtures from bbc'
  task :update_fixtures => :environment do
    FixtureScraper.update_fixtures
    ResultScraper.update_results
  end
end
