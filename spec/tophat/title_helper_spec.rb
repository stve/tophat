require 'spec_helper'

describe TopHat::TitleHelper do

  before(:each) do
    @template = ActionView::Base.new
  end

  context "saving a title" do
    it "saves the title" do
      @template.title('Kind of Blue').should eq('Kind of Blue')
    end
  end

  context "displaying a title" do
    it "uses the website name if title is empty" do
      @template.title(:site => "Miles Davis").should eq("<title>Miles Davis</title>")
    end

    it "displays the title if no website was specified" do
      save_basic_title
      @template.title().should eq('<title>Kind of Blue</title>')
    end

    it "uses website before page by default" do
      save_basic_title
      @template.title(:site => "Miles Davis", :separator => '|').should eq("<title>Miles Davis | Kind of Blue</title>")
    end

    it "only uses markup in titles in the view" do
      save_basic_title("<b>Kind of Blue</b>").should == "<b>Kind of Blue</b>"
      @template.title(:site => "Miles Davis", :separator => '|').should eq("<title>Miles Davis | Kind of Blue</title>")
    end

    it "uses page before website if :reverse" do
      save_basic_title
      @template.title(:site => "Miles Davis", :reverse => true, :separator => '|').should eq("<title>Kind of Blue | Miles Davis</title>")
    end

    it "uses website before page if :reverse and :reverse_on_default" do
      @template.title(:site => "John Coltrane", :default => "My Favorite Things", :reverse => true, :reverse_on_default => false, :separator => '|').should eq("<title>John Coltrane | My Favorite Things</title>")
    end

    it "lowercases the title if :lowercase" do
      save_basic_title
      @template.title(:site => "Miles Davis", :lowercase => true, :separator => '|').should eq("<title>miles davis | kind of blue</title>")
    end

    it "uppercases the title if :uppercase" do
      save_basic_title
      @template.title(:site => "Miles Davis", :uppercase => true, :separator => '|').should eq("<title>MILES DAVIS | KIND OF BLUE</title>")
    end

    it "uses a custom separator if :separator" do
      save_basic_title
      @template.title(:site => "Miles Davis", :separator => "-").should eq("<title>Miles Davis - Kind of Blue</title>")
      @template.title(:site => "Miles Davis", :separator => ":").should eq("<title>Miles Davis : Kind of Blue</title>")
      @template.title(:site => "Miles Davis", :separator => "&mdash;").should eq("<title>Miles Davis &amp;mdash; Kind of Blue</title>")
    end

    it "uses custom prefix and suffix if available" do
      save_basic_title
      @template.title(:site => "Miles Davis", :prefix => " |", :suffix => "| ", :separator => '|').should eq("<title>Miles Davis ||| Kind of Blue</title>")
    end

    it "collapses prefix if false" do
      save_basic_title
      @template.title(:site => "Miles Davis", :prefix => false, :separator => ":").should eq("<title>Miles Davis: Kind of Blue</title>")
    end

    it "collapses suffix if false" do
      save_basic_title
      @template.title(:site => "Miles Davis", :suffix => false, :separator => "~").should eq("<title>Miles Davis ~Kind of Blue</title>")
    end

    it "uses all custom options if available" do
      save_basic_title
      custom_options = { :site => "Miles Davis", :prefix => " ", :suffix => " ", :separator => "-", :lowercase => true, :reverse => true }
      @template.title(custom_options).should eq("<title>kind of blue - miles davis</title>")
    end

    it "uses the default title if title is not present or blank" do
      save_basic_title("")
      @template.title(:site => "Miles Davis", :default => "Round About Midnight", :separator => '|').should eq("<title>Miles Davis | Round About Midnight</title>")
    end

    it "allows custom options per title" do
      save_custom_title
      @template.title(:site => "Freddie Freeloader", :separator => '|').should eq("<title>Kind of Blue | Freddie Freeloader</title>")
    end

    it "accepts an array of strings as the title" do
      @template.title(['My', 'Favorite', 'Things'])
      @template.title(:site => "Freddie Freeloader", :separator => '|').should eq("<title>Freddie Freeloader | My | Favorite | Things</title>")
    end
  end

  def save_basic_title(title='Kind of Blue')
    @template.title(title)
  end

  def save_custom_title(title='Kind of Blue')
    @template.title(title, { :reverse => true })
  end

end