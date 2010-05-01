require 'helper'

class TopHatPluginTestCase < Test::Unit::TestCase
  
  context "loading the TopHat plugin" do
    
    setup do
      @template = ActionView::Base.new
    end
  
    should "be mixed into ActionView::Base" do
      assert ActionView::Base.included_modules.include?(TopHat::TitleHelpers)
      assert ActionView::Base.included_modules.include?(TopHat::MetaHelpers)
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
  
  end
  
end
