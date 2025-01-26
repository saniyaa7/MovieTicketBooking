# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TheatersController, type: :controller do
  let(:user) { create(:user) }

  before(:each) do
    add_request_headers(user)
  end

  describe 'GET #index' do
    let!(:theaters) { create_list(:theater, 4) }

    it 'returns a list of theaters' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'contains the theater name' do
      get :index
      theaters.each do |theater|
        expect(response.body).to include(theater.name)
      end
    end
  end

  describe 'GET #show' do
    let(:theater) { create(:theater) }

    it 'returns the theater' do
      get :show, params: { id: theater.id }
      expect(response).to have_http_status(:success)

      # Update the expectation to check for the presence of specific attributes
      expected_attributes = %w[name location city]
      response_attributes = JSON.parse(response.body).keys

      expect(response_attributes).to include(*expected_attributes)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          theater: attributes_for(:theater, name: 'ABC Theater', location: 'Downtown', city: 'New York')
        }
      end

      it 'creates a new theater' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'PUT #update' do
    let(:theater) { create(:theater) }

    context 'with valid parameters' do
      it "updates the theater's name" do
        put :update, params: {
          id: theater.id,
          theater: {
            name: 'Updated Theater Name'
          }
        }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:theater) { create(:theater) }

    it 'destroys the theater' do
      expect do
        delete :destroy, params: { id: theater.id }
      end.to change(Theater, :count).by(-1)

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include('data', 'status')
    end
  end
end
