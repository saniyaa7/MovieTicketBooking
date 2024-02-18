require 'rails_helper'

RSpec.describe Api::V1::MovieShowsController, type: :controller do
  let(:user) { create(:user) }

  before(:each) do
    add_request_headers(user)
  end

  describe "GET #index" do
    let!(:movie_shows) { create_list(:movie_show, 4) }

    it "returns a list of movie shows" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "contains the movie show language" do
      get :index
      movie_shows.each do |movie_show|
        expect(response.body).to include(movie_show.language)
      end
    end
  end
  
  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          movie_show: attributes_for(:movie_show, language: "English", seat_count: 100, show_start_time: DateTime.now, show_end_time: DateTime.now + 2.hours, screen_no: 1, movie_id: create(:movie).id)
        }
      end

      it "creates a new movie show" do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          movie_show: { language: nil, seat_count: nil, show_start_time: DateTime.now, show_end_time: DateTime.now+2.hours, screen_no: 1, movie_id: create(:movie).id }
        }
      end

      it "does not create a new movie show" do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    let(:movie_show) { create(:movie_show) }

    context "with valid parameters" do
      it "updates the movie show's language" do
        put :update, params: {
          id: movie_show.id,
          movie_show: {
            language: "Updated Language"
          }
        }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:movie_show) { create(:movie_show) }

    it "destroys the movie show" do
      expect {
        delete :destroy, params: { id: movie_show.id }
      }.to change(MovieShow, :count).by(-1)

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include('data', 'status')
    end
  end
end
