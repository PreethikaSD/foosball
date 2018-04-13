class AddRankAndWinningPercentageToTeams < ActiveRecord::Migration[5.1]
  def change
  		add_column :teams, :winning_percentage, :float, :default => 0.0
  		add_column :teams, :rank, :integer

  end
end
