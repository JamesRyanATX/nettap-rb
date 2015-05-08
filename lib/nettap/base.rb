class Nettap::Base

  def initialize(options, &block)
    @options = options
    @recipient = block
    @service = options[:service]
    @lifecycle_event = options[:lifecycle_event]

    add
  end

  def receive(message)
    @recipient.call(message)
  end

  def add
    Nettap.add(@options[:service], @options[:lifecycle_event], self)
  end

  def self.tap(options, &block)
    new(options, &block)
  end

end