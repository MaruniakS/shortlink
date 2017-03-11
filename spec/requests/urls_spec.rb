require 'rails_helper'

RSpec.describe 'urls API', type: :request do
  # initialize test data
  let!(:urls) { create_list(:url, 10) }
  let(:url) { urls.first }

  it 'creates a short url' do
    get '/'
    expect(response).to render_template(:index)
    post '/urls', url: { long: 'http://url.long' } , format: :js
    expect(response.content_type).to eq Mime[:js]
  end

  it 'creates a custom url' do
    get '/urls/custom'
    expect(response).to render_template(:custom)
    post '/urls', url: { long: 'http://url.long', custom: 'test' } , format: :js
    expect(response.content_type).to eq Mime[:js]
  end

  it 'redirects to index when wrong short url' do
    get '/wrong'
    expect(response).to redirect_to(root_path)
  end
end