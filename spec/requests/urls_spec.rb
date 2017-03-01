require 'rails_helper'

RSpec.describe 'urls API', type: :request do
  # initialize test data
  let!(:urls) { create_list(:url, 10) }
  let(:url_id) { urls.first.id }
end