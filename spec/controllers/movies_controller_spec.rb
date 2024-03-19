# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :controller do
  let(:user) { create(:user) }

  before(:each) do
    add_request_headers(user)
  end

  describe 'GET #index' do
    let!(:movies) { create_list(:movie, 4) }

    it 'returns a list of movies' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'contains the movie title' do
      get :index
      movies.each do |movie|
        expect(response.body).to include(movie.title)
      end
    end
  end

  describe 'GET #show' do
    let(:movie) { create(:movie) }

    it 'returns the movie' do
      get :show, params: { id: movie.id }
      expect(response).to have_http_status(:success)
      expected_attributes = %w[title stars description]
      response_attributes = JSON.parse(response.body).keys

      expect(response_attributes).to include(*expected_attributes)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        { movie: attributes_for(:movie, title: 'Inception', stars: 5, description: 'Mind-bending') }
      end

      it 'creates a new movie' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { movie: { title: 'Inception', stars: nil, description: nil } } }

      it 'does not create a new movie' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let(:movie) { create(:movie) }

    context 'with valid parameters' do
      it "updates the movie's title" do
        put :update, params: {
          id: movie.id,
          movie: {
            title: 'Updated Title'
          }
        }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:movie) { create(:movie) }

    it 'destroys the movie' do
      expect do
        delete :destroy, params: { id: movie.id }
      end.to change(Movie, :count).by(-1)

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include('data', 'status')
    end
  end
end
