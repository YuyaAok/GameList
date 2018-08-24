class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.text :Game_title

      t.timestamps
    end
  end
end
