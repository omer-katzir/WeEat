class CreateRestaurants < ActiveRecord::Migration[6.0]
  def up
    create_table :restaurants do |t|
      t.string :name, null: false
      t.integer :rating, default: 0
      t.boolean :b10bis, default: false
      t.integer :max_delivery_time_min, default: 1
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :cuisine

      t.timestamps
    end

  end

  def down
    drop_table :restaurants
  end

end
