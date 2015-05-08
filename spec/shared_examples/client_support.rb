RSpec.shared_examples "a supported client" do
  let(:url) { 'http://localhost:4567/test' }
  let(:request) { send("#{method}_request".to_sym) }

  let(:expected_status_code) { '200' }
  let(:expected_request_body) { nil }
  let(:expected_response_body) { "#{method} response" }

  shared_examples_for "a valid request intercepted on :before" do

    it "has a message" do
      expect(@last_request_message).to be_kind_of(Hash)

      service = @last_request_message[:service]
      lifecycle_event = @last_request_message[:lifecycle_event]
      request = @last_request_message[:request]

      expect(service).to eq(:http)
      expect(lifecycle_event).to eq(:before)

      expect(request).to be_kind_of(Net::HTTPGenericRequest)
      expect(request.body).to eq(expected_request_body)
    end
  end

  shared_examples_for "a valid request intercepted on :after" do

    it "has a message" do
      expect(@last_request_message).to be_kind_of(Hash)

      service = @last_request_message[:service]
      lifecycle_event = @last_request_message[:lifecycle_event]
      response = @last_request_message[:response]
      request = @last_request_message[:request]

      expect(service).to eq(:http)
      expect(lifecycle_event).to eq(:after)

      expect(request).to be_kind_of(Net::HTTPGenericRequest)
      expect(request.body).to eq(expected_request_body)

      expect(response).to be_kind_of(Net::HTTPResponse)
      expect(response.body).to eq(expected_response_body)
      expect(response.code).to eq(expected_status_code)
    end
  end

  shared_examples_for "a valid request" do
    before { request }

    context ":before lifecycle event" do
      let(:lifecycle_event) { :before }

      it_behaves_like "a valid request intercepted on :before"
    end

    context ":after lifecycle event" do
      let(:lifecycle_event) { :after }

      it_behaves_like "a valid request intercepted on :after"
    end
  end

  before do
    @last_request_message = nil

    Nettap.clear
    Nettap::Http.tap(lifecycle_event) do |m|
      @last_request_message = m
    end
  end

  describe "GET" do
    let(:method) { :get }

    it_behaves_like "a valid request"
  end

  describe "POST" do
    let(:method) { :post }
    let(:expected_request_body) { 'foo=bar' }

    it_behaves_like "a valid request"
  end

  describe "DELETE" do
    let(:method) { :delete }

    it_behaves_like "a valid request"
  end

  describe "PUT" do
    let(:method) { :put }
    let(:expected_request_body) { 'foo=bar' }

    it_behaves_like "a valid request"
  end
end