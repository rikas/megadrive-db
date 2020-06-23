class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.boolean :owned, null: false, default: false
      t.string :notes
      t.integer :box, null: false, default: 0
      t.integer :cartridge, null: false, default: 0
      t.integer :manual, null: false, default: 0
      t.boolean :pt_manual, null: false, default: false
    end
  end
end
