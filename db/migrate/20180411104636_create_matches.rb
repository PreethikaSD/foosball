class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.string :code
      t.integer :team1
      t.integer :team2
      t.integer :winner

      t.timestamps
    end
  end
end
