require 'rails_helper'
RSpec.describe Restaurant, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_num_in_range(:rating, 0, 3) }
    it { is_expected.to validate_num_in_range(:max_delivery_time_min, 1, 720) }
    it { is_expected.to validate_num_in_range(:latitude, -90, 90) }
    it { is_expected.to validate_num_in_range(:longitude, -180, 180) }
    it { is_expected.to validate_inclusion_of(:cuisine).in_array(Restaurant::E_CUISINES) }
  end

  context 'defaults' do
    let(:restaurant) { Restaurant.create(name: 'test', cuisine: Restaurant::E_CUISINES[0]) }
    it 'has default rating of 0' do
      expect(restaurant.rating).to eq(0)
    end
    it 'has default accept10bis value of false' do
      expect(restaurant.accept10bis).to eq(false)
    end
  end

  context 'invalid operations' do
    it 'logs error when creating without cuisine' do
      expect(Restaurant.create(name: 'test').errors.messages[:cuisine]).not_to be_empty
    end
    it 'logs error when creating without name' do
      expect(Restaurant.create(cuisine: 'test').errors.messages[:name]).not_to be_empty
    end
  end

  context 'uuid' do
    let(:restaurant) { Restaurant.create(name: 'test', cuisine: Restaurant::E_CUISINES[0]) }
    it 'checks uuid length and chars' do
      expect(restaurant.id.tr('-', '').length).to eq(32)
    end
  end
end

module Shoulda
  module Matchers
    module ActiveModel
      extend Helpers
      def validate_num_in_range(arg, min, max)
        validator = validate_numericality_of(arg).is_greater_than_or_equal_to(min)
        validator.is_less_than_or_equal_to(max)
      end
    end
  end
end
