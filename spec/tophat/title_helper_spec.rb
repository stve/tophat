require 'spec_helper'

describe TopHat::TitleHelper do

  before(:each) do
    @template = ActionView::Base.new
  end

  context "saving a title" do
    it "should save the title" do
      @template.title('Kind of Blue').should == 'Kind of Blue'
    end
  end

  context "displaying a title" do
    it "should use the website name if title is empty" do
      @template.title(:site => "Miles Davis").should == "<title>Miles Davis</title>"
    end

    it "should display the title if no website was specified" do
      save_basic_title
      @template.title().should == '<title>Kind of Blue</title>'
    end

    it "should use website before page by default" do
      save_basic_title
      @template.title(:site => "Miles Davis", :separator => '|').should == "<title>Miles Davis | Kind of Blue</title>"
    end

    it "should only use markup in titles in the view" do
      save_basic_title("<b>Kind of Blue</b>").should == "<b>Kind of Blue</b>"
      @template.title(:site => "Miles Davis", :separator => '|').should == "<title>Miles Davis | Kind of Blue</title>"
    end

    it "should use page before website if :reverse" do
      save_basic_title
      @template.title(:site => "Miles Davis", :reverse => true, :separator => '|').should == "<title>Kind of Blue | Miles Davis</title>"
    end

    it "should use website before page if :reverse and :reverse_on_default" do
      @template.title(:site => "John Coltrane", :default => "My Favorite Things", :reverse => true, :reverse_on_default => false, :separator => '|').should == "<title>John Coltrane | My Favorite Things</title>"
    end

    it "should be lowercase if :lowercase" do
      save_basic_title
      @template.title(:site => "Miles Davis", :lowercase => true, :separator => '|').should == "<title>miles davis | kind of blue</title>"
    end

    it "should use custom separator if :separator" do
      save_basic_title
      @template.title(:site => "Miles Davis", :separator => "-").should == "<title>Miles Davis - Kind of Blue</title>"
      @template.title(:site => "Miles Davis", :separator => ":").should == "<title>Miles Davis : Kind of Blue</title>"
      @template.title(:site => "Miles Davis", :separator => "&mdash;").should == "<title>Miles Davis &amp;mdash; Kind of Blue</title>"
    end

    it "should use custom prefix and suffix if available" do
      save_basic_title
      @template.title(:site => "Miles Davis", :prefix => " |", :suffix => "| ", :separator => '|').should == "<title>Miles Davis ||| Kind of Blue</title>"
    end

    it "should collapse prefix if false" do
      save_basic_title
      @template.title(:site => "Miles Davis", :prefix => false, :separator => ":").should == "<title>Miles Davis: Kind of Blue</title>"
    end

    it "should collapse suffix if false" do
      save_basic_title
      @template.title(:site => "Miles Davis", :suffix => false, :separator => "~").should == "<title>Miles Davis ~Kind of Blue</title>"
    end

    it "should use all custom options if available" do
      save_basic_title
      custom_options = { :site => "Miles Davis", :prefix => " ", :suffix => " ", :separator => "-", :lowercase => true, :reverse => true }
      @template.title(custom_options).should == "<title>kind of blue - miles davis</title>"
    end

    it "should use default one if title is not present or blank" do
      save_basic_title("")
      @template.title(:site => "Miles Davis", :default => "Round About Midnight", :separator => '|').should == "<title>Miles Davis | Round About Midnight</title>"
    end

    it "should allow custom options per title" do
      save_custom_title
      @template.title(:site => "Freddie Freeloader", :separator => '|').should == "<title>Kind of Blue | Freddie Freeloader</title>"
    end
  end

  def save_basic_title(title='Kind of Blue')
    @template.title(title)
  end

  def save_custom_title(title='Kind of Blue')
    @template.title(title, { :reverse => true })
  end

end