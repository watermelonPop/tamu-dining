require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    User.create(first_name: 'Lebron',
                last_name: 'James',
                uin: 49494949,
                credits: 30)
  end

  let!(:user) { User.find_by(uin: 49494949) }
  # let!(:json_response) { JSON.parse(response.body) }

  describe 'POST #increase_credits' do
    context 'with valid parameters' do
      it 'grabs the right user' do
        get :increase_credits, params: { uin: user.uin, credits: 5}
        expect(assigns[:user]).to eq(user)
      end
  
      it 'is successful for a valid number of credits' do
        post :increase_credits, params: { uin: user.uin, credits: 5 }
        expect(response).to have_http_status(:ok)
      end
      
      it 'properly increases the users credit count' do
        get :increase_credits, params: { uin: user.uin, credits: 5 }
        user.reload
        expect(user.credits).to eq(35)
      end
  
      it 'returns the appropriate json message' do
        get :increase_credits, params: { uin: user.uin, credits: 5 }
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('increased user credits')
      end

      it 'returns the new credit amount for the user in json' do
        get :increase_credits, params: { uin: user.uin, credits: 5 }
        json_response = JSON.parse(response.body)
        expect(json_response['credits']).to eq(35)
      end
    end

    describe 'with invalid parameters' do
      it 'returns an error for negative credits' do
        get :increase_credits, params: { uin: user.uin, credits: -3 }
        expect(response).to have_http_status(:bad_request)
      end

      it "returns a detailed error message for negative credits" do
        get :increase_credits, params: { uin: user.uin, credits: -3 }
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('invalid number of credits')
      end
  
      it "doesn't change the user's credit count when given negative credits" do
        get :increase_credits, params: { uin: user.uin, credits: -3 }
        expect(user.credits).to eq(30)
      end

      it 'returns an error when an invalid uin is given' do
        get :increase_credits, params: { uin: 911119997, creduts: 6 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
