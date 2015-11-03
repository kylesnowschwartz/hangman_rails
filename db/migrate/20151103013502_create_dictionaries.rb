class CreateDictionaries < ActiveRecord::Migration
  def change
    create_table :dictionaries do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
