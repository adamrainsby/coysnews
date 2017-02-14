require 'open-uri'

class ResultScraper
  class << self
    def update_results
      scraped_results = scrape

      Match.pending_score_update.each do |match|
        matching_results = scraped_results.select do |result|
          match.kick_off.to_date === result[:match_date] &&
          match.home_team_id == result[:home_team].id &&
          match.away_team_id == result[:away_team].id
        end

        next if matching_results.count == 0

        match.update(
          home_team_goals: matching_results.first[:home_team_goals],
          away_team_goals: matching_results.first[:away_team_goals]
        )
      end
    end

    def scrape
      page = Nokogiri::HTML(open('http://www.bbc.co.uk/sport/football/teams/tottenham-hotspur/results'))
      page.css('#results-data .table-stats tbody tr.report').map do |row|
        score = row.css('.match-details.teams .score').text.strip
        goals = score.split('-').map &:to_i

        {
          match_date: parse_kick_off(row.css('.match-date').text),
          home_team: find_or_create_club(row.css('.match-details.teams .team-home.teams').text.strip),
          away_team: find_or_create_club(row.css('.match-details.teams .team-away.teams').text.strip),
          home_team_goals: goals[0],
          away_team_goals: goals[1]
        }
      end
    end

    def parse_kick_off kick_off_string
      parsed_time = Date.parse kick_off_string
      parsed_time > Date.today ? parsed_time - 1.year : parsed_time
    end

    def find_or_create_club team_name
      club_found = Club.find_by(name: team_name)
      club_found || Club.create(name: team_name)
    end
  end
end
