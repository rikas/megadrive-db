class AddAlternativeNamesToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :alternative_names, :string, array: true, default: []
  end
end
