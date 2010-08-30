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
          assert_equal @template.opengraph, '<meta content="123,124" property="fb:admins" />\n'
        end
      
      end
    
      context "as an array" do

        should "generate a site admin tag" do
          @template.opengraph(:admins => [123, 124])
          assert_equal @template.opengraph, '<meta content="123,124" property="fb:admins" />\n'
        end
        
      end
      
    end
    
    context "app_id when configured" do
      
      should "generate an app_id meta tag" do
        @template.opengraph(:app_id => 'MyApp')
        assert_equal @template.opengraph, '<meta content="MyApp" property="fb:app_id" />\n'
      end
      
    end
    
    context "additional open graph properties" do
      
      should "generate tags" do
        @template.opengraph do |graph|
          graph.title 'The Great Gatsby'
        end
        assert_equal @template.opengraph, '<meta content="The Great Gatsby" property="og:title" />'
      end
      
      should "allow use of the tag 'type'" do
        @template.opengraph do |graph|
          graph.type 'sports_team'
        end
        assert_equal @template.opengraph, '<meta content="sports_team" property="og:type" />'
      end
      
      should "support multiple tags" do
        @template.opengraph do |graph|
          graph.title 'Austin Powers: International Man of Mystery'
          graph.type 'movie'
        end
        assert_equal @template.opengraph, '<meta content="movie" property="og:type" />\n<meta content="Austin Powers: International Man of Mystery" property="og:title" />\n'
      end
      
    end
    
    context "combined usage" do
      should "generate all tags" do
        @template.opengraph(:app_id => 'MyApp', :admins => [123, 1234]) do |graph|
          graph.title 'Rain Man'
          graph.type 'movie'
        end
        assert_equal @template.opengraph, '<meta content="MyApp" property="fb:app_id" />\n<meta content="123,1234" property="fb:admins" />\n<meta content="movie" property="og:type" />\n<meta content="Rain Man" property="og:title" />\n'
      end
      
      should "generate all tags - alternative usage" do
        @template.opengraph do |graph|
          graph.title 'Rain Man'
          graph.type 'movie'
        end
        assert_equal @template.opengraph(:app_id => 'MyApp', :admins => [123, 1234]), '<meta content="MyApp" property="fb:app_id" />\n<meta content="123,1234" property="fb:admins" />\n<meta content="movie" property="og:type" />\n<meta content="Rain Man" property="og:title" />\n'
      end
    end
    
  end
  
end