class AddFavoritesCountToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :favorites_count, :integer, default: 0
  end
end
