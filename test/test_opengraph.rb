require 'helper'

class TopHatTitleTestCase < Test::Unit::TestCase

  context "when using the open graph helpers" do
    
    setup do
      @template = ActionView::Base.new
    end
    
    context "site admins" do
      
      should "generate a site admin tag when configured with an admin as a string" do
        @template.opengraph(:admins => '123,124')
        assert_equal @template.opengraph, '<meta property="fb:admins" content="123,124"/>'
      end
      
      should "generate a site admin tag when configured with an admin as an array" do
        @template.opengraph(:admins => [123, 124])
        assert_equal @template.opengraph, '<meta property="fb:admins" content="123,124"/>'
      end
      
    end
    
    context "app_id" do
      
      should "generate a app_id" do
        @template.opengraph(:app_id => 'MyApp')
        assert_equal @template.opengraph, '<meta property="fb:app_id" content="MyApp"/>'
      end
      
    end
  end
  
end