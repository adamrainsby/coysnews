require 'open-uri'

class FixtureScraper
  class << self
    def update_fixtures
      scraped_fixtures = scrape

      Match.upcoming.each do |upcoming_match|
        matching_fixtures_count = scraped_fixtures.count { |scraped_fixture|
          scraped_fixture == {
            kick_off: upcoming_match.kick_off,
            home_team: upcoming_match.home_team,
            away_team: upcoming_match.away_team
          }
        }
        upcoming_match.destroy if matching_fixtures_count == 0
      end

      scraped_fixtures.each do |scraped_fixture|
        Match.where(scraped_fixture).count > 0 || Match.create(scraped_fixture)
      end
    end

    def scrape
      page = Nokogiri::HTML(open('http://www.bbc.co.uk/sport/football/teams/tottenham-hotspur/fixtures'))
      page.css('#fixtures-data .table-stats tbody .preview').map do |row|
        {
          kick_off: parse_kick_off("#{row.css('.match-date').text} #{row.css('.kickoff').text}"),
          home_team: find_or_create_club(row.css('.match-details.teams .team-home.teams').text.strip),
          away_team: find_or_create_club(row.css('.match-details.teams .team-away.teams').text.strip)
        }
      end
    end

    def parse_kick_off kick_off_string
      parsed_time = Time.zone.parse kick_off_string
      parsed_time < Time.zone.now ? parsed_time + 1.year : parsed_time
    end

    def find_or_create_club team_name
      club_found = Club.find_by(name: team_name)
      club_found || Club.create(name: team_name)
    end
  end
end
