require 'spec_helper'

describe Nettap::Http do
  let(:url) { 'http://localhost:4567/test' }

  before do
    @last_request_message = nil

    Nettap.clear
  end

  describe ".tap" do
    before do
      Nettap::Http.tap(lifecycle_event) { |m| @last_request_message = m }
    end

    context ":before lifecycle event" do
      let(:lifecycle_event) { :before }

      before do
        Net::HTTP.get(URI.parse(url))
      end

      shared_examples_for "a valid request intercepted on :before" do

        it "has a message" do
          expect(@last_request_message).to be_kind_of(Hash)
          expect(@last_request_message[:service]).to eq(:http)
          expect(@last_request_message[:lifecycle_event]).to eq(:before)
          expect(@last_request_message[:request]).to be_kind_of(Net::HTTPRequest)
        end

      end

      it_behaves_like "a valid request intercepted on :before"
    end

    context ":after lifecycle_event" do
      let(:lifecycle_event) { :after }

      before do
        Net::HTTP.get(URI.parse(url))
      end

      shared_examples_for "a valid request intercepted on :after" do

        it "has a message" do
          expect(@last_request_message[:service]).to eq(:http)
          expect(@last_request_message[:lifecycle_event]).to eq(:after)
          expect(@last_request_message[:request]).to be_kind_of(Net::HTTPRequest)
          expect(@last_request_message[:response]).to be_kind_of(Net::HTTPResponse)
        end

      end

      it_behaves_like "a valid request intercepted on :after"
    end
  end
end