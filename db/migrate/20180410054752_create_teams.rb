class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.references :match, foreign_key: true
      t.string :name
      t.integer :matches_played
      t.integer :macthes_won
      t.timestamps
    end
  end
end
