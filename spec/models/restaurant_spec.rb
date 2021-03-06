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

require 'helpers/matcher_helper'

RSpec.describe Restaurant, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_num_in_range(:rating, 0, 3) }
    it { is_expected.to validate_num_in_range(:max_delivery_time_min, 1, Restaurant::MAX_DELIVERY_TIME) }
    it { is_expected.to validate_num_in_range(:latitude, -90, 90) }
    it { is_expected.to validate_num_in_range(:longitude, -180, 180) }
    it { is_expected.to validate_inclusion_of(:cuisine).in_array(Restaurant::CUISINES) }
  end

  context 'defaults' do
    restaurant = FactoryBot.create(:restaurant, :not_accepts_10bis, :bad_rating)
    it 'has default rating of 0' do
      expect(restaurant.rating).to eq(0)
    end
    it 'has default accept10bis value of false' do
      expect(restaurant.accept10bis).to be_falsey
    end
  end
end
