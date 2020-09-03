class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.string :name
      t.text :description
      t.belongs_to :user
      t.integer :price
      t.timestamps
    end
  end
end