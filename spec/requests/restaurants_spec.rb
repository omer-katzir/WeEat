require 'rails_helper'

RSpec.describe 'Restaurants', type: :request do
  MAX_RECORD_COUNT = 100
  RESTAURANT_ATTRIBUTES = %w(id name rating cuisine accept10bis max_delivery_time_min
                             created_at updated_at address latitude longitude).freeze
  describe 'GET /restaurants' do
    before(:all) do
      FactoryBot.create_list(:restaurant, rand(1..MAX_RECORD_COUNT))
      get restaurants_path
    end

    it 'return https :ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'has the right restaurants count' do
      restaurants = response_body
      expect(restaurants.count).to eq(Restaurant.all.count)
    end

    it 'contains all attributes' do
      restaurants = response_body
      restaurants.each do |restaurant|
        expect(restaurant.keys).to match_array(RESTAURANT_ATTRIBUTES)
      end
    end
  end

  describe 'GET /restaurant/:id' do
    context 'valid records' do
      subject { Restaurant.all.sample }
      before(:all) do
        FactoryBot.create_list(:restaurant, rand(1..MAX_RECORD_COUNT))
      end

      it 'return https success' do
        get restaurant_path(subject)

        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct record' do
        get restaurant_path(subject.id)

        restaurant_attr_matcher(subject.attributes, response_body)
      end
    end

    context 'non-valid records' do
      it 'returns :not_found status on invalid uuid' do
        get restaurant_path('this-is-not-a-uuid')

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /restaurants' do
    context 'valid requests' do
      before(:all) do
        post '/restaurants', params: FactoryBot.attributes_for(:restaurant)
      end

      it 'returns http :created' do
        expect(response).to have_http_status(:created)
      end

      it 'creates new record in the database' do
        uuid = response_body['id']
        restaurant = Restaurant.find_by(id: uuid)

        expect(restaurant).to_not be_nil
        restaurant_attr_matcher(restaurant.attributes, response_body)
      end
    end

    context 'non-valid records' do
      it 'returns error when params are invalid' do
        invalid_attr = FactoryBot.attributes_for(:restaurant, name: nil)
        post '/restaurants', params: invalid_attr

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /restaurant/:id' do
    subject { Restaurant.all.sample }

    before(:all) do
      FactoryBot.create_list(:restaurant, rand(1..MAX_RECORD_COUNT))
    end

    it 'returns https :not_content' do
      put restaurant_path(subject.id), params: FactoryBot.attributes_for(:restaurant)

      expect(response).to have_http_status(:no_content)
    end

    it 'returns error when params are invalid' do
      invalid_attr = FactoryBot.attributes_for(:restaurant, name: nil)
      put restaurant_path(subject.id), params: invalid_attr

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'updates the record fields' do
      new_rest = FactoryBot.build(:restaurant, id: subject.id)
      put restaurant_path(subject.id), params: new_rest.attributes
      rest = Restaurant.find(subject.id)

      restaurant_attr_matcher(rest.attributes, new_rest.attributes)
    end
  end

  describe 'DELETE /restaurant/:id' do
    subject { Restaurant.all.sample }

    context 'valid records' do
      before(:all) do
        FactoryBot.create_list(:restaurant, rand(1..MAX_RECORD_COUNT))
      end

      it 'returns http :ok' do
        delete restaurant_path(subject.id)

        expect(response).to have_http_status(:ok)
      end

      it 'cannot find the deleted record' do
        delete restaurant_path(subject.id)

        expect(Restaurant.find_by(id: subject.id)).to be_nil
      end
    end

    context 'invalid records' do
      it 'gets an http :not_found' do
        delete restaurant_path('this-is-not-a-uuid')

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  private

  def response_body
    JSON.parse(response.body)
  end

  # rubocop: disable Metrics/AbcSize
  def restaurant_attr_matcher(rest_ref, rest_sample)
    expect(rest_ref.keys).to match_array(RESTAURANT_ATTRIBUTES)
    expect(rest_sample.keys).to match_array(RESTAURANT_ATTRIBUTES)
    expect(rest_sample['name']).to eq(rest_ref['name'])
    expect(rest_sample['cuisine']).to eq(rest_ref['cuisine'])
    expect(rest_sample['id']).to eq(rest_ref['id'])
    expect(rest_sample['address']).to eq(rest_ref['address'])
    expect(rest_sample['max_delivery_time_min']).to eq(rest_ref['max_delivery_time_min'])
    float_matcher(rest_sample['latitude'], rest_ref['latitude'])
    float_matcher(rest_sample['longitude'], rest_ref['longitude'])
    float_matcher(rest_sample['rating'], rest_ref['rating'])
  end
  # rubocop: enable Metrics/AbcSize

  private

  def float_matcher(f_ref, f_sample)
    f_delta = 0.0000000001

    if f_ref.nil?
      expect(f_sample).to be_nil
    else
      expect((f_sample - f_ref).abs).to be < f_delta
    end
  end
end
