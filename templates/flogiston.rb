plugin 'rspec', :git => 'git://github.com/dchelimsky/rspec.git'
plugin 'rspec-rails', :git => 'git://github.com/dchelimsky/rspec-rails.git'
generate("rspec")

gem 'mocha'
gem 'haml'

rake("gems:install")
rake("gems:unpack")
rake("gems:build")
