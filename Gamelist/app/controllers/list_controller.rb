
class ListController < ApplicationController
  def index
		@lists = GameInfo.all
		@games = Game.all

	end

	def update
		@id = params[:game_info][:id]
		@title = params[:game_info_title]
		list = GameInfo.find_by(Game_Title: params[:game_info_title])

		list = GameInfo.find_by(Game_Title: params[:game_info_title])
		list.update_attribute(:Game_ID, @id)

		list.update_attribute(:Flag, 1)

		redirect_to action: 'index'
	end
end
