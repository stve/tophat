require 'helper'

class TopHatOpenGraphTestCase < Test::Unit::TestCase

  context "when using the open graph helpers" do
    
    setup do
      @template = ActionView::Base.new
    end
    
    context "site admins when configured" do
    
      context "as a string" do
      
        should "generate a site admin tag" do
          @template.opengraph(:admins => '123,124')
          assert_equal @template.opengraph, '<meta content="123,124" property="fb:admins" />'
        end
      
      end
    
      context "as an array" do

        should "generate a site admin tag" do
          @template.opengraph(:admins => [123, 124])
          assert_equal @template.opengraph, '<meta content="123,124" property="fb:admins" />'
        end
        
      end
      
    end
    
    context "app_id when configured" do
      
      should "generate an app_id meta tag" do
        @template.opengraph(:app_id => 'MyApp')
        assert_equal @template.opengraph, '<meta content="MyApp" property="fb:app_id" />'
      end
      
    end
    
  end
  
end