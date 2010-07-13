require 'helper'

class TopHatRobotsTestCase < Test::Unit::TestCase
  
  context "using the meta helper" do
   
    setup do
      @template = ActionView::Base.new
    end
   
    context "robots" do
      
      context "nofollow" do
        
        should "default to all robots" do
          assert_equal @template.nofollow, "<meta name=\"robots\" content=\"nofollow\" />"
        end
        
        should "use a descriptor if one is provided" do
          assert_equal @template.nofollow('googlebot'), "<meta name=\"googlebot\" content=\"nofollow\" />"
        end
        
      end
      
      context "noindex" do
        
        should "default to all robots" do
          assert_equal @template.noindex, "<meta name=\"robots\" content=\"noindex\" />"
        end
        
        should "use a descriptor if one is provided" do
          assert_equal @template.noindex('googlebot'), "<meta name=\"googlebot\" content=\"noindex\" />"
        end
        
      end
      
      context "canonical" do
        
        should "not render when not passed a path" do
          assert_nil @template.canonical
        end
        
        should "render a tag when passed a path" do
          assert_equal @template.canonical('http://mysite.com/somepath/'), "<link rel=\"canonical\" href=\"http://mysite.com/somepath/\" />"
        end
        
      end
      
    end

    
  end
  
end
