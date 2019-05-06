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

require 'faker'

FactoryBot.define do
  factory :restaurant do
    name { Faker::Restaurant.name }

    cuisine { Restaurant::CUISINES.sample }

    accept10bis { [true, false].sample }

    rating { Faker::Number.within(0.0..3.0) }

    max_delivery_time_min { rand(1..Restaurant::MAX_DELIVERY_TIME) }

    trait :with_location do
      addr = Faker::Address
      address { addr.full_address }
      latitude { addr.latitude }
      longitude { addr.longitude }
    end

    trait :accepts_10bis do
      accept10bis { true }
    end

    trait :not_accepts_10bis do
      accept10bis { false }
    end

    trait :bad_rating do
      rating { 0 }
    end

    trait :rally_bad_restaurant do # ;) :P
      rating { 0 }
      max_delivery_time_min { 720 }
      accepts_10bis { false }
    end
  end
end
