require 'helper'

class TopHatPluginTestCase < Test::Unit::TestCase
  
  context "loading the TopHat plugin" do
    
    setup do
      @template = ActionView::Base.new
    end
  
    should "be mixed into ActionView::Base" do
      assert ActionView::Base.included_modules.include?(TopHat::TitleHelper)
      assert ActionView::Base.included_modules.include?(TopHat::MetaHelper)
      assert ActionView::Base.included_modules.include?(TopHat::StylesheetHelper)
    end
  
    should "respond to 'title' helper" do
      assert @template.respond_to?(:title)
    end

    should "respond to 'title' helper alias" do
      assert @template.respond_to?(:t)
    end

    should "respond to 'description' helper" do
      assert @template.respond_to?(:description)
    end    

    should "respond to 'keywords' helper" do
      assert @template.respond_to?(:keywords)
    end

    should "respondo to 'ie_5_conditional' helper" do
      assert @template.respond_to?(:ie_5_conditional)
    end
    
    should "respondo to 'ie_5_5_conditional' helper" do
      assert @template.respond_to?(:ie_5_5_conditional)
    end
    
    should "respondo to 'ie_6_conditional' helper" do
      assert @template.respond_to?(:ie_6_conditional)
    end
    
    should "respond to 'ie_7_conditional' helper" do
      assert @template.respond_to?(:ie_7_conditional)
    end
    
    should "respond to 'ie_8_conditional' helper" do
      assert @template.respond_to?(:ie_8_conditional)
    end 
  
  end
  
end
