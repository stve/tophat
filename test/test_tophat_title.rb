require 'helper'

class TopHatTitleTestCase < Test::Unit::TestCase

  context "when using the title helpers" do
    
    setup do
      @template = ActionView::Base.new
    end
    
    context "saving a title" do
      
      should "save the title" do
        assert_equal @template.title('Kind of Blue'), 'Kind of Blue'
      end
      
    end
    
    context "displaying a title" do

      should "use the website name if title is empty" do
        assert_equal @template.title(:site => "Miles Davis"), "<title>Miles Davis</title>"
      end

      should "use website before page by default" do
        save_basic_title
        assert_equal @template.title(:site => "Miles Davis"), "<title>Miles Davis | Kind of Blue</title>"
      end

      should "only use markup in titles in the view" do
        assert_equal save_basic_title("<b>Kind of Blue</b>"), "<b>Kind of Blue</b>"
        assert_equal @template.title(:site => "Miles Davis"), "<title>Miles Davis | Kind of Blue</title>"
      end  
  
      should "use page before website if :reverse" do
        save_basic_title
        assert_equal @template.title(:site => "Miles Davis", :reverse => true), "<title>Kind of Blue | Miles Davis</title>"
      end

      should "use website before page if :reverse and :reverse_on_default" do
        assert_equal @template.title(:site => "John Coltrane", :default => "My Favorite Things", :reverse => true, :reverse_on_default => false), "<title>John Coltrane | My Favorite Things</title>"
      end
      
      should "be lowercase if :lowercase" do
        save_basic_title
        assert_equal @template.title(:site => "Miles Davis", :lowercase => true), "<title>miles davis | kind of blue</title>"
      end

      should "use custom separator if :separator" do
        save_basic_title
        assert_equal @template.title(:site => "Miles Davis", :separator => "-"), "<title>Miles Davis - Kind of Blue</title>"
        assert_equal @template.title(:site => "Miles Davis", :separator => ":"), "<title>Miles Davis : Kind of Blue</title>"
        assert_equal @template.title(:site => "Miles Davis", :separator => "&mdash;"), "<title>Miles Davis &mdash; Kind of Blue</title>"
      end
      
      should "use custom prefix and suffix if available" do
        save_basic_title
        assert_equal @template.title(:site => "Miles Davis", :prefix => " |", :suffix => "| "), "<title>Miles Davis ||| Kind of Blue</title>"
      end 

      should "collapse prefix if false" do
        save_basic_title
        assert_equal @template.title(:site => "Miles Davis", :prefix => false, :separator => ":"), "<title>Miles Davis: Kind of Blue</title>"
      end
      
      should "collapse suffix if false" do
        save_basic_title
        assert_equal @template.title(:site => "Miles Davis", :suffix => false, :separator => "~"), "<title>Miles Davis ~Kind of Blue</title>"
      end
      
      should "use all custom options if available" do
        save_basic_title
        custom_options = { :site => "Miles Davis", :prefix => " ", :suffix => " ", :separator => "-", :lowercase => true, :reverse => true }
        assert_equal @template.title(custom_options), "<title>kind of blue - miles davis</title>"
      end
      
      should "use default one if title is not present or blank" do
        save_basic_title("")
        assert_equal @template.title(:site => "Miles Davis", :default => "Round About Midnight"), "<title>Miles Davis | Round About Midnight</title>"
      end

      should "allow custom options per title" do
        save_custom_title
        assert_equal @template.title(:site => "Freddie Freeloader"), "<title>Kind of Blue | Freddie Freeloader</title>"
      end
    end
    
  end
  
  def save_basic_title(title='Kind of Blue')
    @template.title(title)
  end

  def save_custom_title(title='Kind of Blue')
    @template.title(title, { :reverse => true })
  end
  
end
