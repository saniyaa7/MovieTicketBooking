require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:role) { create(:role) }

  before(:each) do
    user = create(:user, role_id: role.id)
    add_request_headers(user)
  end

  describe "GET #index" do
    let!(:users) { create_list(:user, 4) }

    it "returns a list of users" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "contains the user phone number" do
      get :index
      users.each do |user|
        expect(response.body).to include(user.phone_no)
      end
    end
  end

  describe "POST /users" do
    context "with valid parameters" do
      let(:valid_params) { { user: attributes_for(:user, name: "Saniya", age: 20, phone_no: "8237939131", password: "Saniya@123", role_id: role.id) } }

      it "creates a new user" do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) { { user: { name: "Saniya", age: 20, phone_no: "823793913aq", password: "Saniya@123", role_id: role.id } } }

      it "does not create a new user" do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  
  describe "GET #show" do
  let(:user) { create(:user) }

    it "returns the user" do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)

      # Update the expectation to check for the presence of specific attributes
      expected_attributes = ["age", "id", "name", "phone_no", "role"]
      response_attributes = JSON.parse(response.body).keys

      expect(response_attributes).to include(*expected_attributes)
    end
  end

  describe "PUT #update" do
  let(:user) { create(:user) }


  context "with valid parameters" do
    it "updates the user's age" do
      put :update, params:{
        id:user.id,
        user:{
          name:Faker::Name.name
        }
      }
      expect(response).to have_http_status(:ok)
    
    end
  end
end

  describe "DELETE #destroy" do
    let!(:user) { create(:user) }

    it "destroys the user" do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
      debugger
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include('data', 'status')
      # expect(User.find_by(id: user.id)).to be_nil
    end
  end

end
