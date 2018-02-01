class AddPicidToFavorite < ActiveRecord::Migration[5.1]
  def change
    add_column :favorites, :picture_id, :integer
  end
end
