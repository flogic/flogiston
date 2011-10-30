require 'fileutils'

def plugin_path(relative)
  File.expand_path(File.join(File.dirname(__FILE__), relative))
end

def rails_path(relative)
  File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', relative))
end

def readme_contents
  IO.read(plugin_path('README.markdown'))
end

# install our stylesheets to the application
puts "Installing plugin stylesheets #{plugin_path('public/stylesheets/sass')} to #{rails_path('public/stylesheets')}..."
FileUtils.cp_r(plugin_path('public/stylesheets/sass'), rails_path('public/stylesheets'))

# install our javascripts to the application
puts "Installing plugin javascripts #{plugin_path('public/javascripts')} to #{rails_path('public')}..."
FileUtils.cp_r(plugin_path('public/javascripts'), rails_path('public'))

puts "Copying in unlazy-loading fix..."
FileUtils.copy(plugin_path('lib/initializer-unlazy_load.rb'), rails_path('config/initializers/unlazy_load.rb'))

# run our Rails template to ensure needed gems and plugins are installed
system("rake rails:template LOCATION=#{plugin_path('templates/plugin-install.rb')}")

# and output our README
puts readme_contents
