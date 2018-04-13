class Game < ApplicationRecord
  belongs_to :match
  belongs_to :team
  validates_presence_of :team_id, :match_id, :round_no
  validates_inclusion_of :score, :in => 0..10

  after_create :check_for_winner
  after_update :check_for_winner
  after_destroy :check_for_winner
  validate :duplicate_record_create, on: :create
  validate :duplicate_records
  validate :round2_after_round1
  validate :team_belongs_to_match
  validate :round3_needed
  validate :same_score

  def team_belongs_to_match
    selected_match = Match.find(self.match.id)
    if self.team.id == selected_match.team1 or self.team.id == selected_match.team2
    else  
      errors.add(:team_id, "Please select the correct team name")
    end
  end

#validate if round 1 scores are entered before round 2
  def round2_after_round1
    if self.round_no == 2
      game = Game.where(match_id: self.match_id, round_no: 1)
      if game.exists?
        unless game.count == 2
        errors.add(:team_id, "Please fill the scores for both teams for round 1")
        end
      else
        errors.add(:team_id, "Please fill the scores for round 1")
      end
    end
  end

#validate if round 3 scores are needed to determine the winner
  def round3_needed
    if self.round_no == 3
      game1 = Game.where(match_id: self.match_id, round_no: 1)
      game2 = Game.where(match_id: self.match_id, round_no: 2)
      game = Game.where(match_id: self.match_id)

      if game1.exists? and game2.exists?
        if game1.count == 2 and game2.count == 2
          round1_winner = find_winner(game, 1) 
          round2_winner = find_winner(game, 2) 
          if game1.count == 2 and game2.count == 2
            if round1_winner.team_id == round2_winner.team_id
              errors.add(:team_id, "Winner declared! Round 3 is not needed")
            end
          else
            errors.add(:team_id, "Please fill the scores for Round 2")
          end
        else
          errors.add(:team_id, "Please fill up the scores for Round 1 and Round 2")
        end
      else
        errors.add(:team_id, "Please fill up the scores for Round 1 and Round 2")
      end  
    end
  end

#validate if a duplicate record exists on create
  def duplicate_record_create
    if Game.where(match_id: self.match_id, round_no: self.round_no, team_id: self.team_id).exists?
      errors.add(:team_id, "Duplicate record!")
    end
  end

#check if corresponding team id is entered during create and update
  def duplicate_records
    game = Game.where(match_id: self.match_id, round_no: self.round_no)
    match = Match.find(self.match_id)
    if game.exists?
      team_ids = game.pluck(:team_id)
      team_ids.each do |id|
        if id != match.team1 and id != match.team2
          errors.add(:team_id, "Invalid values entered")
        end
      end
    else
    end
  end

  #check for the winner team
  def check_for_winner
    game = Game.where(match_id: self.match_id)
    match = Match.find(self.match_id)
    winner = false
    if game.exists?
      no_of_records = game.count
      if no_of_records == 4
        round1_winner = find_winner(game, 1) 
        round2_winner = find_winner(game, 2) 
        round3_winner = nil
        winner = true
      elsif no_of_records == 6
        round1_winner = find_winner(game, 1) 
        round2_winner = find_winner(game, 2)         
        round3_winner = find_winner(game, 3)
        winner = true
      else  
        match.winner = nil
        match.save
      end
      if winner
        if round1_winner.team_id == round2_winner.team_id
          #update match
          match.winner = round1_winner.team_id
          match.save
        elsif round3_winner != nil  
          if round1_winner.team_id == round3_winner.team_id 
            match.winner = round1_winner.team_id
            match.save
          elsif round2_winner.team_id == round3_winner.team_id 
            match.winner = round2_winner.team_id
            match.save 
          else
          end               
        else
          match.winner = nil
          match.save
        end
      end
    end
  end

  def same_score
    games = Game.where(round_no: self.round_no, match_id: self.match_id)
    if games.count == 2 
      if games[0].score == games[1].score
        errors.add(:team_id, "Teams cannot have the same score")
      end
    end 
  end

  def find_winner(game_detail, round_no)
    game = game_detail.where(round_no: round_no)
    team1 = game[0]
    team2 = game[1]
    return game[0].score > game[1].score ? game[0] : game[1]
  end
end
