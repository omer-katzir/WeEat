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
    cuisine { Restaurant::E_CUISINES.sample }
    accept10bis { [true, false].sample }
    rating { Faker::Number.within(0.0..3.0) }
    max_delivery_time_min { Faker::Number.within(1..720) }

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
    trait :invalid_record do
      r = Faker::Number.within(0..2)
      case r
      when 0
        cuisine { nil }
      when 1
        rating { Faker::Number.within((3.0..100_000)) }
      when 2
        max_delivery_time_min { Faker::Number.within(-100_000..0) }
      else
        name { nil }
      end
    end
  end
end
