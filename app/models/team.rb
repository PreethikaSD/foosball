class Team < ApplicationRecord
  has_many :players
  has_many :games
  has_many :match_details
end
