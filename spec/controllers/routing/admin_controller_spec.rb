require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe AdminController do
  describe 'mapping routes' do
    it "should map { :controller => 'admin', :action => 'index' } to /admin" do
      route_for(:controller => 'admin', :action => 'index').should == '/admin'
    end
  end
  
  describe 'generating params' do
    it "should generate params { :controller => 'admin', action => 'index' } from GET /admin" do
      params_from(:get, '/admin').should == { :controller => 'admin', :action => 'index' }
    end
  end
end
