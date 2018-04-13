class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :matches_played, default: 0
      t.integer :matches_won, default: 0
      t.timestamps
    end
  end
end
