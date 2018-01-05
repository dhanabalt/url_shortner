require 'rails_helper'

RSpec.describe Url, :type => :model do
  context 'Proper Url only domain' do
    let(:url) { Url.fetch_or_create_by('google.com') }

    it 'should have exaact sanitized url' do
      expect(url.original_url).to eq('google.com')
      expect(url.sanitized_url).to eq('http://google.com')
    end
  end

  context 'Proper Url with http' do
    let(:url) { Url.fetch_or_create_by('http://google.com') }

    it 'should have exaact sanitized url' do
      expect(url.original_url).to eq('http://google.com')
      expect(url.sanitized_url).to eq('http://google.com')
    end
  end

  context 'Proper Url with https' do
    let(:url) { Url.fetch_or_create_by('https://google.com') }

    it 'should have exaact sanitized url' do
      expect(url.original_url).to eq('https://google.com')
      expect(url.sanitized_url).to eq('http://google.com')
    end
  end

  context 'Proper Url with www' do
    let(:url) { Url.fetch_or_create_by('www.google.com') }

    it 'should have exaact sanitized url' do
      expect(url.original_url).to eq('www.google.com')
      expect(url.sanitized_url).to eq('http://google.com')
    end
  end

  context 'Blank Url' do
    let(:url) { Url.fetch_or_create_by('') }

    it 'should have exaact sanitized url' do
      expect(url.errors.full_messages.include?("Original url can't be blank")).to be_truthy
    end
  end

  context 'Invalid Url' do
    let(:url) { Url.fetch_or_create_by('sdfds') }

    it 'should have exaact sanitized url' do
      expect(url.errors.full_messages.include?("Original url is an invalid URL")).to be_truthy
    end
  end


end