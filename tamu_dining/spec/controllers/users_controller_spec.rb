require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    before(:all) do
        User.destroy_all
        User.create(first_name: 'Al', last_name: 'Gorithm', uin: '879861986', email: 'al_gorithm@tamu.edu', credits: 48)
        User.create(first_name: 'Shrimpfried', last_name: 'Rice', uin: '973415535', email: 'shrimprice@tamu.edu', credits: 32)
        User.create(first_name: 'Lemon', last_name: 'Jello', uin: '463525785', email: 'lemonj@tamu.edu', credits: 0)
        User.create(first_name: 'Renee', last_name: 'Rapp', uin: '361543783', email: 'rr@tamu.edu', credits: 24)
        User.create(first_name: 'Shakira', last_name: 'Shakira', uin: '643971828', email: 'shakira@tamu.edu', credits: 44)
        User.create(first_name:"no", last_name:"credits", uin:"098765432", email:"j@tamu.edu", credits: 0)
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
            get :show, params: { uin: 'not_in_database' }
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

        it "returns err for non-numerical credits" do
            # Create a user with the same UIN before attempting to create again
            invalid_user_attributes = {
            first_name: 'John',
            last_name: 'Doe',
            uin: '123456789',
            email: 'johndoe@tamu.edu',
            credits: "abc"
            }
            
            post :create, params: { user: invalid_user_attributes }
            expect(response).to have_http_status(:unprocessable_entity)
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

        it "fails for an unexisting user" do
            patch :update_credits, params: { uin: 'none', credits: 4 }
            user = User.find_by(uin: 'none')
            expect(response).to have_http_status(:not_found)
        end
    end

    describe "PATCH user" do
        it 'patch successfully' do

            @user = user = User.find_by(first_name: 'no')
            patch :update, params: { uin: @user.uin, user: { credits: 0 } }, as: :json
            assert_response :success
            @user.reload
            assert_equal 0, @user.credits
        end

        it 'patch unsuccessfully' do
            @user = user = User.find_by(first_name: 'no')
            patch :update, params: { uin: @user.uin, user: {credits: '',} }, as: :json
            expect(response).to have_http_status(:unprocessable_entity)
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
