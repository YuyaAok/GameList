class CreateGameInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :game_infos do |t|
      t.integer :Game_ID
      t.text :Game_title
      t.text :Article_URL
      t.integer :Media
      t.text :Icon_URL
      t.text :Genre
      t.text :Release_Date
      t.integer :Flag
    end
	end
end
