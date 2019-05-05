require 'rails_helper'

RSpec.describe 'Restaurants', type: :request do
  before(:all) do
    Restaurant.delete_all
    FactoryBot.create_list(:restaurant, 10)
  end

  describe 'GET /restaurants' do
    before do
      get restaurants_path
    end

    it 'return https success' do
      expect(response).to have_http_status(200)
    end

    it 'has the right objects count' do
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

  describe 'GET /restaurant/:id' do
    subject { Restaurant.all.sample }
    it 'return https success' do
      get restaurant_path(subject.id)
      expect(response).to have_http_status(200)
    end

    it 'returns :not_found status on invalid uuid' do
      get restaurant_path('this-is-not-a-uuid')
      expect(response).to have_http_status(:not_found)
    end

    it 'returns the correct record' do
      get restaurant_path(subject.id)
      restaurant_matcher(subject, response_body)
    end
  end

  describe 'POST /restaurants' do
    before do
      post '/restaurants', params: FactoryBot.attributes_for(:restaurant)
      puts "TEST:#{subject}"
    end
    it 'returns http success' do
      expect(response).to have_http_status(:created)
    end

    it 'creates new record in the database' do
      post '/restaurants', params: FactoryBot.attributes_for(:restaurant)
      uuid = response_body['id']
      rest = Restaurant.find_by(id: uuid)
      expect(rest).to_not be_nil
      restaurant_matcher(rest, response_body)
    end

    it 'returns error when params are invalid' do
      invalid_attr = FactoryBot.attributes_for(:restaurant, :invalid_record)
      post '/restaurants', params: invalid_attr
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  after(:all) do
    Restaurant.delete_all
  end

  def response_body
    JSON.parse(response.body)
  end

  def restaurant_matcher(rest_ref, rest_sample)
    expect(rest_sample['name']).to eq(rest_ref.name)
    expect(rest_sample['cuisine']).to eq(rest_ref.cuisine.to_s)
    expect(rest_sample['id']).to eq(rest_ref.id)
    expect(rest_sample['address']).to eq(rest_ref.address)
    expect(rest_sample['max_delivery_time_min']).to eq(rest_ref.max_delivery_time_min)
    float_matcher(rest_sample['latitude'], rest_ref.latitude)
    float_matcher(rest_sample['longitude'], rest_ref.longitude)
    float_matcher(rest_sample['rating'], rest_ref.rating)
  end

  def float_matcher(f_ref, f_sample)
    f_delta = 0.0000000001
    if f_ref.nil?
      expect(f_sample).to be_nil
    else
      expect((f_sample - f_ref).abs).to be < f_delta
    end
  end
end
