require "spec_helper"
require "net/http"

describe "Net::HTTP" do
  it_behaves_like "a supported client" do

    let(:get_request) do
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.path)

      http.request(request)
    end

    let(:post_request) do
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.path)

      request.set_form_data({ "foo" => "bar" })

      http.request(request)
    end

    let(:put_request) do
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Put.new(uri.path)

      request.set_form_data({ "foo" => "bar" })

      http.request(request)
    end

    let(:delete_request) do
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Delete.new(uri.path)

      http.request(request)
    end

  end
end