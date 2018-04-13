class Team < ApplicationRecord
  has_many :players
  has_many :games
  has_many :match_details

  def calculate_percentage
    ((self.matches_played/self.matches_won)*100).round(2)
  end
  
end
