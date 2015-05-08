require "spec_helper"
require "httparty"

class Party
  include HTTParty
end

describe "Net::HTTP" do
  it_behaves_like "a supported client" do

    let(:get_request) do
      Party.get(url)
    end

    let(:post_request) do
      Party.post(url, body: { foo: 'bar' })
    end

    let(:put_request) do
      Party.put(url, body: { foo: 'bar' })
    end

    let(:delete_request) do
      Party.delete(url)
    end

  end
end