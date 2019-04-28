class CreateRestaurants < ActiveRecord::Migration[6.0]
  def up
    enable_extension 'uuid-ossp'

    create_table :restaurants , id: :uuid do |t|
      t.string :name, null: false
      t.float :rating, default: 0
      t.boolean :accept10bis, null: false, default: false
      t.integer :max_delivery_time_min
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
