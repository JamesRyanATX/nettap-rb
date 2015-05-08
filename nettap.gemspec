lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'nettap'

Gem::Specification.new do |s|
  s.authors = [ 'James Ryan' ]
  s.description = "A low-level monitor for HTTP and HTTPS requests."
  s.email = 'fretlessjazz@gmail.com'
  s.homepage = 'http://github.com/JamesRyanATX/nettap'
  s.license = 'MIT'
  s.name = 'nettap'
  s.require_paths = %w(lib)
  s.required_rubygems_version = '>= 1.3.5'
  s.summary = "A low-level monitor for HTTP and HTTPS requests."
  s.version = Nettap::VERSION

  s.files += Dir.glob('lib/**/*.rb')
  s.files += Dir.glob('spec/**/*')
  s.files += Dir.glob('src/**/*')
end