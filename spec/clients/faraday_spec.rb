require "spec_helper"
require "faraday"

def faraday_connection(url)
  Faraday.new(:url => url) do |faraday|
    faraday.request  :url_encoded             # form-encode POST params
    faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  end
end

describe "Faraday" do
  it_behaves_like "a supported client" do

    let(:get_request) do
      faraday_connection(url).get('/test')
    end

    let(:post_request) do
      faraday_connection(url).post('/test', { foo: 'bar' })
    end

    let(:put_request) do
      faraday_connection(url).put('/test', { foo: 'bar' })
    end

    let(:delete_request) do
      faraday_connection(url).delete('/test')
    end

  end
end