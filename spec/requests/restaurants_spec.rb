require 'rails_helper'

RSpec.describe 'Restaurants', type: :request do
  before(:all) do
    Restaurant.delete_all
    FactoryBot.create_list(:restaurant, 10)
  end

  describe 'GET /restaurants' do
    before(:all) do
      get restaurants_path
    end

    it 'return https success' do
      expect(response).to have_http_status(200)
    end

    context 'json body content' do
      it 'has the righ objects count' do
        arr = response_body
        expect(arr.count).to eq(Restaurant.all.count)
      end

      it 'contains mandatory attributes' do
        arr = response_body
        arr.each do |json_rest|
          expect(json_rest.keys).to include('id', 'name', 'cuisine', 'accept10bis')
        end
      end
    end
  end

  describe 'Get /restaurant/:id' do
    before(:all) do
      @rest = Restaurant.all.sample
      puts "TEST:#{@rest.id}"
      get restaurant_path(@rest.id)
    end
    it 'return https success' do
      expect(response).to have_http_status(200)
    end

    it 'returns the correct record' do
      new_rest = response_body
      expect(new_rest['name']).to eq(@rest.name)
      expect(new_rest['cuisine']).to eq(@rest.cuisine.to_s)
      expect(new_rest['id']).to eq(@rest.id)
      expect(new_rest['address']).to eq(@rest.address)
      expect(new_rest['latitude']).to eq(@rest.latitude)
      expect(new_rest['longitude']).to eq(@rest.longitude)
      expect(new_rest['max_delivery_time_min']).to eq(@rest.max_delivery_time_min)
      expect(new_rest['rating']).to eq(@rest.rating)
      # expect(new_rest['created_at']).to eq(@rest.created_at)
      # expect(new_rest['updated_at']).to eq(@rest.updated_at)
    end
  end

  after(:all) do
    Restaurant.delete_all
  end

  def response_body
    JSON.parse(response.body)
  end
end
