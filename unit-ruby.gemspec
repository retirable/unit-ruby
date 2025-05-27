lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unit-ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'unit-ruby'
  spec.version       = Unit::VERSION
  spec.authors       = ['Chloe Isacke', 'Ian Yamey', 'Trevor Nelson']
  spec.email         = ['chloe@retirable.com', 'ian@retirable.com', 'trevor@retirable.com']

  spec.summary       = 'A Ruby gem for communicating with the Unit API.'
  spec.homepage      = 'https://github.com/retirable/unit-ruby'
  spec.license       = 'MIT'

  spec.metadata = {
    'allowed_push_host' => 'https://rubygems.org/',
    'source_code_uri' => 'https://github.com/retirable/unit-ruby',
    'changelog_uri' => 'https://github.com/retirable/unit-ruby/blob/main/CHANGELOG.md'
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 3.3'

  spec.add_dependency 'activesupport', '~> 7'
  spec.add_dependency 'faraday', '~> 2'
  spec.add_dependency 'faraday-retry', '~> 2'

  spec.add_development_dependency 'dotenv', '~> 2'
  spec.add_development_dependency 'pry', '~> 0.15'
  spec.add_development_dependency 'rake', '~> 13'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'rspec-file_fixtures', '~> 0.1.9'
  spec.add_development_dependency 'rubocop', '~> 1'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
