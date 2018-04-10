class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.references :team, foreign_key: true
      t.string :name
      t.integer :age
      t.string :sex
      t.timestamps
    end
  end
end
