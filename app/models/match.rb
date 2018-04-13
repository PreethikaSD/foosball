class Match < ApplicationRecord
	validates_presence_of :team1, :team2
	validate :different_team
	validates_uniqueness_of :team1, scope: :team2

	def different_team
		if self.team1 == self.team2
		  	errors.add(:id, "Match cannot have same teams")
		end
	end

end
