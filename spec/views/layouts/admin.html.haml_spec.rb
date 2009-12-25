require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe 'layouts/admin.html.haml' do
  before :all do
    AdminHelper.register_section('whatevers')
  end
  
  before :each do
    @testing_index_path = '/blah/blah/blah'
    @testing_new_path   = '/new/thing'
    template.stubs(:admin_whatevers_path).returns(@testing_index_path)
    template.stubs(:new_admin_whatever_path).returns(@testing_new_path)
  end
  
  def do_render
    render :text => '<div id="yielded">Success</div>', :layout => 'admin'
  end
  
  it 'should wrap view content' do
    do_render
    response.should have_tag('div[id=?]', 'yielded', :text => 'Success')
  end
  
  it 'should link to the index action of whatever admin section exists' do
    do_render
    response.should have_tag('a[href=?]', @testing_index_path)
  end
  
  it 'should link to the new action of whatever admin section exists' do
    do_render
    response.should have_tag('a[href=?]', @testing_new_path)
  end
end
