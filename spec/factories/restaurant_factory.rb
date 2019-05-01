# == Schema Information
#
# Table name: restaurants
#
#  id                    :uuid             not null, primary key
#  accept10bis           :boolean          default(FALSE), not null
#  address               :string
#  cuisine               :string
#  latitude              :float
#  longitude             :float
#  max_delivery_time_min :integer
#  name                  :string           not null
#  rating                :float            default(0.0)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

FactoryBot.define do
  factory :restaurant do
    name { 'MyRestaurant' }
    cuisine {  Restaurant::E_CUISINES.sample }
  end
  factory :restaurant_no_cuisine do
    name { 'MayRestaurant' }
  end
  factory :restaurant_no_name do
    cuisine { Restaurant::E_CUISINES.sample }
  end
end
