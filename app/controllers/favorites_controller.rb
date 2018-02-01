class FavoritesController < ApplicationController

  def create
    favorite = current_user.favorites.create(picture_id: params[:picture_id])
    redirect_to pictures_url, notice: "#{favorite.picture.user.name}さんの画像をお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(picture_id: params[:picture_id]).destroy
    redirect_to pictures_url, notice: "#{favorite.picture.user.name}さんの画像をお気に入りから解除しました"
  end
end