require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET root' do
    before(:example) { get '/' }

    it 'response status 200 OK' do
      expect(response).to have_http_status(200)
    end

    it 'renders correct template' do
      expect(response).to render_template('index')
    end

    it 'includes correct placeholder text' do
      expect(response.body).to include 'Users'
    end
  end

  describe 'GET /show' do
    before(:example) { get '/users/1' }

    it 'response status is 200 OK' do
      expect(response).to have_http_status(200)
    end

    it 'renders correct template' do
      expect(response).to render_template('show')
    end

    it 'includes correct placeholder text' do
      expect(response.body).to include 'User'
    end
  end
end
