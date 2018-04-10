class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.string :code
      t.date :match_date
      t.string :winner

      t.timestamps
    end
  end
end
