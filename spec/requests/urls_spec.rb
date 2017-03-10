require 'rails_helper'

RSpec.describe 'urls API', type: :request do
  # initialize test data
  let!(:urls) { create_list(:url, 10) }
  let(:url) { urls.first }

  it 'creates an url' do
    get '/'
    expect(response).to render_template(:index)
    post '/urls', url: { long: 'http://url.long' } , format: :js
    expect(response.content_type).to eq Mime[:js]
  end
end