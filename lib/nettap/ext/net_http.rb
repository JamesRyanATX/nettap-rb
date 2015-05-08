require 'net/http'
require 'net/https'

# This approach follows the same pattern as fakeweb.

class Net::HTTP

  def request_with_nettap(request, body = nil, &block)
    Nettap.emit(:http, :before, {
      request: request
    })

    connect

    response = request_without_nettap(request, body, &block)

    Nettap.emit(:http, :after, {
      request: request,
      response: response
    })

    response
  end
  alias_method :request_without_nettap, :request
  alias_method :request, :request_with_nettap

end