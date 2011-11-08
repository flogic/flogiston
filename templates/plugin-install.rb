plugin 'rspec', :git => 'git://github.com/dchelimsky/rspec.git'
plugin 'rspec-rails', :git => 'git://github.com/dchelimsky/rspec-rails.git'
generate("rspec")

Dir["#{RAILS_ROOT}/vendor/plugins/flogiston/app/controllers/flogiston/*.rb"].each do |f|
  filename = File.basename(f, '.rb')
  controller_name = filename.camelize

  if File.exist?("app/controllers/#{filename}.rb")
    puts "*** controller #{filename}.rb exists. Ensure it defines #{controller_name} < Flogiston::#{controller_name}. ***"
  else
    file "app/controllers/#{filename}.rb", <<-eof
class #{controller_name} < Flogiston::#{controller_name}
end
    eof
  end
end

gem 'mocha'
gem 'haml'

rake("gems:install")
rake("gems:unpack")
rake("gems:build")
