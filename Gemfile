source 'https://rubygems.org'

# Distribute your app as a gem
# gemspec

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'bcrypt'
gem 'dm-validations'
gem 'dm-timestamps'
gem 'dm-migrations'
gem 'dm-constraints'
gem 'dm-aggregates'
gem 'dm-types'
gem 'dm-core'
gem 'slim'


group :development, :test do
  gem 'dm-sqlite-adapter'

  gem "binding_of_caller"
  gem 'better_errors'

  gem 'dotenv'
end

group :development do
  gem 'dawn', :require => false
end

group :production do
  gem 'pg'
  gem 'dm-postgres-adapter'
  gem 'do_postgres'
  gem 'dm-do-adapter'

  #TODO: Check if this is necessary!
  #gem "secure_headers", :require => 'secure_headers'
end

gem 'cloudflare'

# Test requirements

# Padrino Stable Gem
gem 'padrino'

# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core support gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.12.4'
# end
