module Nettap

  VERSION = '0.1.0'

  # Emit an intercepted message to all service observers
  def self.emit(service, lifecycle_event, message)
    self.tabs_by_service_lifecycle_event(service, lifecycle_event).each do |tap|
      tap.receive(message.merge({
        service: service,
        lifecycle_event: lifecycle_event
      }))
    end
  end

  # Add a service observer
  def self.add(service, lifecycle_event, tap)
    self.tabs_by_service_lifecycle_event(service, lifecycle_event) << tap
  end

  # Clear all current taps
  def self.clear
    @taps = {}
  end

  def self.tabs_by_service_lifecycle_event(service, lifecycle_event)
    self.taps_by_service(service)[lifecycle_event]
  end

  def self.taps_by_service(service)
    self.taps[service] ||= { before: [], after: [] }
  end

  def self.taps
    @taps ||= {}
  end

end

require 'nettap/ext/net_http'
require 'nettap/http'