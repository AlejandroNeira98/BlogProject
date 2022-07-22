require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET posts#index' do
    before(:example) { get '/users/1/posts' }

    it 'response status 200 OK' do
      expect(response).to have_http_status(200)
    end

    it 'renders correct template' do
      expect(response).to render_template('index')
    end

    it 'includes correct placeholder text' do
      expect(response.body).to include 'Posts'
    end
  end

  describe 'GET posts#show' do
    before(:example) { get '/users/1/posts/1' }

    it 'response status is 200 OK' do
      expect(response).to have_http_status(200)
    end

    it 'renders correct template' do
      expect(response).to render_template('show')
    end

    it 'includes correct placeholder text' do
      expect(response.body).to include 'Post'
    end
  end
end
