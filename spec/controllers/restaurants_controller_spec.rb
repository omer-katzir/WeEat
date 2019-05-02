RSpec.describe RestaurantsController, type: :controller do
  describe 'GET #index' do
    before do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'JSON body response contains expected restaurant attributes' do
      hash = JSON.parse(response.body)
      hash.each do |h|
        expect(h.keys).to
      end
    end
  end
  context 'check creation' do
  end
  context 'check updating' do
  end
  context 'check deleting' do
  end
end
