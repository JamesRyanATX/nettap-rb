require 'nettap/base'

class Nettap::Http < Nettap::Base

  def self.tap(lifecycle_event, options = {}, &block)
    unless [ :before, :after ].member?(lifecycle_event)
      raise ArgumentError, "expected lifecycle event :before or :after, got '#{lifecycle_event}'"
    end

    options = {
      service: :http,
      lifecycle_event: lifecycle_event
    }.merge(options)

    super(options, &block)
  end

end