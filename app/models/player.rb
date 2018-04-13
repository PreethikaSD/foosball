class Player < ApplicationRecord
  belongs_to :team
  validate :no_of_players

    def no_of_players
  	if self.team.players.count >= 2
  		errors.add(:id, "Maximum of 2 players allowed in a team")
  	end
  end

end
