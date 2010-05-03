require 'helper'

class TopHatMetaTestCase < Test::Unit::TestCase
  
  context "using the meta helper" do
   
    setup do
      @template = ActionView::Base.new
    end
   
    context "keywords" do
      
      context "defined as an array" do
        
        setup do
          @keywords = %w{ John Paul George Ringo }
        end
        
        should "save keywords" do
          assert_equal @template.keywords(@keywords), @keywords.join(', ')
        end
        
        should "use default keywords if keywords is empty" do
          assert_equal @template.keywords(:default => @keywords), "<meta name=\"keywords\" content=\"#{@keywords.join(', ')}\" />"
        end
        
      end
      
      context "defined as a string" do
        
        setup do
          @keywords = "John, Paul, George, Ringo"
        end
        
        should "save keywords" do
          assert_equal @template.keywords(@keywords), @keywords
        end

        should "use default keywords passed as a string if keywords is empty" do
          assert_equal @template.keywords(:default => @keywords), "<meta name=\"keywords\" content=\"#{@keywords}\" />"
        end
        
      end
      
      should "not return a tag if no default is configured and no keywords are defined" do
        assert_nil @template.keywords
      end
      
    end
 
    context "descriptions" do
 
      should "save the description" do
        desc = "Cinderella story. Outta nowhere. A former greenskeeper, now, about to become the Masters champion."
        assert_equal @template.description(desc), desc
      end
 
      should "use the default description if no description is defined" do
        desc = "A flute without holes, is not a flute. A donut without a hole, is a Danish."
        assert_equal @template.description(:default => desc), "<meta name=\"description\" content=\"#{desc}\" />"
      end

      should "not return a tag if no default is configured and no description is defined" do
        assert_nil @template.description
      end

    end
    
  end
  
end
