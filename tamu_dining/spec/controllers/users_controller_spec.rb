require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    before(:all) do
        User.destroy_all
        User.create(first_name: 'Al', last_name: 'Gorithm', uin: '879861986', email: 'al_gorithm@tamu.edu', credits: 48)
        User.create(first_name: 'Shrimpfried', last_name: 'Rice', uin: '973415535', email: 'shrimprice@tamu.edu', credits: 32)
        User.create(first_name: 'Lemon', last_name: 'Jello', uin: '463525785', email: 'lemonj@tamu.edu', credits: 0)
        User.create(first_name: 'Renee', last_name: 'Rapp', uin: '361543783', email: 'rr@tamu.edu', credits: 24)
        User.create(first_name: 'Shakira', last_name: 'Shakira', uin: '643971828', email: 'shakira@tamu.edu', credits: 44)
    end

    describe "GET #index" do
        it "returns a success response" do
        get :index
        expect(response).to be_successful
        end
    end

    describe "GET #show" do
        it "returns a success response" do
            get :show, params: { uin: '879861986' }
            expect(response).to be_successful
        end

        it "returns a not found response for non-existing user" do
            get :show, params: { uin: 'nonexistent' }
            expect(response).to have_http_status(:not_found)
        end
    end

    describe "POST #create" do
        user_attributes = {
            first_name: 'John',
            last_name: 'Doe',
            uin: '123456789',
            email: 'johndoe@tamu.edu',
            credits: 42
        }
        it "creates a new User" do
            expect {
                post :create, params: { user: user_attributes }
            }.to change(User, :count).by(1)
        end

        it "returns a created response" do
            post :create, params: { user: user_attributes }
            expect(response).to have_http_status(:created)
        end

        it "returns err for duplicate UIN" do
            # Create a user with the same UIN before attempting to create again
            User.create(user_attributes)
      
            post :create, params: { user: user_attributes }
            expect(response).to have_http_status(:unprocessable_entity)
            expect(JSON.parse(response.body)['error']).to eq('UIN already exists in the database')
        end
    end

    describe "PATCH #update_credits" do
        it "decrease credits for an existing user" do
            patch :update_credits, params: { uin: '879861986', credits: -10 }
            user = User.find_by(uin: '879861986')
            user.reload
            expect(response).to be_successful
            expect(user.credits).to eq(38)
            expect(JSON.parse(response.body)['message']).to eq('Credits updated successfully')
        end

        it "increase credits for an existing user" do
            patch :update_credits, params: { uin: '643971828', credits: 4 }
            user = User.find_by(uin: '643971828')
            user.reload
            expect(response).to be_successful
            expect(user.credits).to eq(48)
            expect(JSON.parse(response.body)['message']).to eq('Credits updated successfully')
        end
    end

    describe "DELETE #destroy" do
        it "destroys the requested user" do
            user = User.find_by(uin: '973415535')
            expect {
            delete :destroy, params: { uin: user.uin } # Use uin instead of id
            }.to change(User, :count).by(-1)
        end
    end
end
