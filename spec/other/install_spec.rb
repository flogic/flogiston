require File.expand_path(File.join(File.dirname(__FILE__), *%w[.. spec_helper]))
require 'fileutils'

def plugin_path(relative)
  File.expand_path(File.join(File.dirname(__FILE__), '..', '..', relative))
end

def rails_path(relative)
  File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', '..', '..', relative))
end

describe 'the plugin install.rb script' do
  before :each do
    FileUtils.stubs(:copy)
    self.stubs(:system).returns(true)
    self.stubs(:puts).returns(true)
  end

  def do_install
    eval File.read(File.join(File.dirname(__FILE__), *%w[.. .. install.rb ]))
  end
  
  it 'should copy in the unlazy-load initializer' do
    FileUtils.expects(:copy).with(plugin_path('lib/initializer-unlazy_load.rb'), rails_path('config/initializers/unlazy_load.rb'))
    do_install
  end
  
  it 'should copy in the stylesheets to the public/ directory' do
    FileUtils.expects(:cp_r).with(plugin_path('public/stylesheets/sass'), rails_path('public/stylesheets'))
    do_install
  end
  
  it 'should copy in the javascripts to the public/ directory' do
    FileUtils.expects(:cp_r).with(plugin_path('public/javascripts'), rails_path('public'))
    do_install
  end
  
  it 'should have rails run the plugin installation template' do
    self.expects(:system).with("rake rails:template LOCATION=#{plugin_path('templates/plugin-install.rb')}")
    do_install
  end

  it 'should display the contents of the plugin README file' do
    self.stubs(:readme_contents).returns('README CONTENTS')
    self.expects(:puts).with('README CONTENTS')
    do_install
  end
  
  describe 'readme_contents' do
    it 'should read the plugin README.markdown file' do
      do_install
      IO.expects(:read).with(plugin_path('README.markdown'))
      readme_contents
    end
  
    it 'should return the contents of the plugin README.markdown file' do
      do_install
      IO.stubs(:read).with(plugin_path('README.markdown')).returns('README CONTENTS')
      readme_contents.should == 'README CONTENTS'
    end
  end
end
