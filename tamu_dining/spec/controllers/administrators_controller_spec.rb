require 'rails_helper'

RSpec.describe AdministratorsController, type: :controller do
    before(:all) do
        Administrator.destroy_all
        Administrator.create(first_name: 'Al', last_name: 'Gorithm',email: 'al_gorithm@tamu.edu')
        Administrator.create(first_name: 'Shrimpfried', last_name: 'Rice',email: 'shrimprice@tamu.edu')
        Administrator.create(first_name: 'Lemon', last_name: 'Jello',  email: 'lemonj@tamu.edu')
        Administrator.create(first_name: 'Renee', last_name: 'Rapp',  email: 'rr@tamu.edu')
        Administrator.create(first_name: 'Shakira', last_name: 'Shakira',  email: 'shakira@tamu.edu')
        User.destroy_all
        User.create(first_name:"not", last_name:"admin", uin: '123456789',  email:"j@tamu.edu", credits: 0)
    end

    describe "GET #index" do
        it "returns a success response" do
        get :index
        expect(response).to be_successful
        end
    end

    describe "GET #show" do
        it "returns a success response" do
            get :show, params: { email: 'al_gorithm@tamu.edu' }
            expect(response).to be_successful
        end

        it "returns a not found response for non-existing admin" do
            get :show, params: { email: 'j@tamu.edu' }
            expect(response).to have_http_status(:not_found)
        end
    end

    describe "POST #create" do
        admin_attributes = {
            first_name: 'John',
            last_name: 'Doe',
            email: 'johndoe@tamu.edu'
        }
        it "creates a new Admin" do
            expect {
                post :create, params: { administrator: admin_attributes }
            }.to change(Administrator, :count).by(1)
        end

        it "returns a created response" do
            post :create, params: { administrator: admin_attributes }
            expect(response).to have_http_status(:created)
        end

        it "returns err for duplicate email" do
            # Create a user with the same UIN before attempting to create again
            Administrator.create(admin_attributes)
      
            post :create, params: { administrator: admin_attributes }
            expect(response).to have_http_status(:unprocessable_entity)
            expect(JSON.parse(response.body)['error']).to eq('email already exists in the database as an administrator')
        end
    end

    describe "GET #validate_admin" do
        it "validates existing admin" do
            get :validate_admin, params: { administrator_email: 'rr@tamu.edu'}
            expect(JSON.parse(response.body)).to eq(true)
        end

        it "does not validate non-existing admin" do
            get :validate_admin, params: { administrator_email: 'j@tamu.edu' }
            expect(JSON.parse(response.body)).to eq(false)
        end

    end

    describe "DELETE #destroy" do
        it "destroys the requested admin" do
            admin = Administrator.find_by(email: 'shakira@tamu.edu')
            expect {
            delete :destroy, params: { email: admin.email } # Use uin instead of id
            }.to change(Administrator, :count).by(-1)
        end
    end
end
