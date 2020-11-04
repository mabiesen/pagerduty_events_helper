# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'pagerduty_events_helper'
  s.version     = '0.1.0'
  s.authors     = ['Matthew Biesen']
  s.email       = ['mabiesen@outlook.com']
  s.homepage    = 'https://www.github.com/mabiesen/pagerduty_events_helper'
  s.summary     = 'Client for pagerduty events'
  s.description = 'Client for pagerduty events. Distinct from pagerduty_helper which is a getter for incidents.  Aim to consolidate these two repos later'

    # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = 'https://gems.enova.com/'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  s.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware'

  # specify any dependencies here; for example:
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'pry-nav'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'

end
