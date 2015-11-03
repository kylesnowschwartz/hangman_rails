class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :lives
      t.string :word
      t.timestamps null: false
    end
  end
end
