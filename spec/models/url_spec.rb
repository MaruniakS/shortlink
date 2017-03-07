require 'rails_helper'

RSpec.describe Url, type: :model do
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:long) }
  it { should validate_uniqueness_of(:long) }

  let(:link) { Url.create!(long: 'http://example.com') }

  context 'url validation' do
    it 'creates not blank short url' do
      expect(link.short.blank?).to eq false
    end

    it 'should not save duplicated long url' do
      duplicated_link = Url.new(long: link.long)
      expect(duplicated_link).to be_invalid
    end

    it 'should accept only correct format of url' do
      test_urls = Url.create([{ long: 'example.com' }, { long: 'htp://error.url' }, { long: 'http//error.url' }])
      test_urls.each do |url|
        expect(url.errors).to_not be_empty
      end
    end

    it 'should not save duplicated custom url' do
      second_link = Url.create(long: 'http://us.com', custom: link.short)
      expect(second_link.errors).to_not be_empty
    end
  end

  context 'url methods' do
    it 'should return correct id' do
      expect(Url.get_id(link.short)).to eq link.id
    end
  end
end
