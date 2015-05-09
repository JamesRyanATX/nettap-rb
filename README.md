# Nettap

A low-level monitor for requests made through Net::HTTP.

### Quick Start

The following example intercepts HTTP traffic and outputs to the console:

**Code**

``` ruby
require 'nettap'

Nettap::Http.tap(:before) do |message|
  request = message[:request]

  puts "requesting #{request.uri.to_s}"
end

Nettap::Http.tap(:after) do |message|
  request = message[:request]
  response = message[:response]

  puts "request #{uri.inspect} completed with status #{response.code}"
end

Net::HTTP.get(URI.parse('https://www.dasheroo.com/'))
```

**Results**

```
% ruby nettap.rb
requesting https://www.dasheroo.com/
request https://www.dasheroo.com/ completed with status 200
```

### Message Payloads

Each tap receives a hash containing the request and response objects as well as information about the tap.

```
{
  request: [Net::HTTPGenericRequest],
  response: [Net::HTTPResponse],
  service: :http,
  lifecycle_event: :before
}
```

### Lifecycle Events

* **:before** -- tap into a request prior to execution
* **:after** -- tap into a request after execution

### Supported API Clients

* Net:HTTP
* Faraday
* HTTParty

### Limitations

Nettap is a monitor only; it does not interfere with the request and response objects.
