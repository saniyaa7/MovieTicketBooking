require 'rails_helper'

RSpec.describe Api::V1::TicketsController, type: :controller do
  let(:user) { create(:user) }
  let(:movie_show) { create(:movie_show) }

  before(:each) do
    add_request_headers(user)
  end

  describe "GET #index" do
    let!(:tickets) { create_list(:ticket, 4) }

    it "returns a list of tickets" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    let(:ticket) { create(:ticket) }

    it "returns the ticket" do
      get :show, params: { id: ticket.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          ticket: attributes_for(:ticket, payment_mode: "Cash", seat_book: 2, user_id: user.id, movie_show_id: movie_show.id,seat_type:["premium","vip"])
        }
      end

      it "creates a new ticket" do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          ticket: { payment_mode: nil, seat_book: 6, user_id: user.id, movie_show_id: movie_show.id,seat_type:['xyz'] }
        }
      end

      it "does not create a new ticket" do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    let(:ticket) { create(:ticket) }

    context "with valid parameters" do
      it "updates the ticket's payment mode" do
        put :update, params: {
          id: ticket.id,
          ticket: {
            payment_mode: "Online"
          }
        
        }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:ticket) { create(:ticket) }

    it "destroys the ticket" do
      expect {
        delete :destroy, params: { id: ticket.id }
      }.to change(Ticket, :count).by(-1)
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include('data', 'status')
    end
  end
end
