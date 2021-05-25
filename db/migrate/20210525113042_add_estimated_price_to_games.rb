class AddEstimatedPriceToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :estimated_price, :integer, default: 0
  end
end
