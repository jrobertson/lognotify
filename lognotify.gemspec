Gem::Specification.new do |s|
  s.name = 'lognotify'
  s.version = '0.1.1'
  s.summary = 'Actively monitors a log file for new entries which can trigger an event using a regular expression'
  s.authors = ['James Robertson']
  s.files = Dir['lib/lognotify.rb']
  s.add_runtime_dependency('sps-pub', '~> 0.4', '>=0.4.0') 
  s.signing_key = '../privatekeys/lognotify.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/lognotify'
end
