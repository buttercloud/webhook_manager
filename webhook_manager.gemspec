# frozen_string_literal: true

require_relative "lib/webhook_manager/version"

Gem::Specification.new do |spec|
  spec.name          = "webhook_manager"
  spec.version       = WebhookManager::VERSION
  spec.authors       = ["Luay Bseiso"]
  spec.email         = ["luay@buttercloud.com"]

  spec.summary       = "A gem to manage webhook triggers"
  spec.description   = "A gem to manage webhook triggers"
  spec.homepage      = "https://github.com/buttercloud/webhook_manager"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = 'https://rubygems.org/'

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/buttercloud/webhook_manager"
  spec.metadata["changelog_uri"] = "https://github.com/buttercloud/webhook_manager"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "faraday", "~> 0.17.3"
  spec.add_development_dependency "pry"
  
  spec.required_ruby_version = '>= 2.1'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
