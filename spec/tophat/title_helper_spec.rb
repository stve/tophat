require 'spec_helper'

describe TopHat::TitleHelper do

  before(:each) do
    @template = ActionView::Base.new
  end

  context "saving a title" do
    it "saves the title" do
      expect(@template.title('Kind of Blue')).to eq('Kind of Blue')
    end
  end

  context "displaying a title" do
    it "uses the website name if title is empty" do
      expect(@template.title(:site => "Miles Davis")).to eq("<title>Miles Davis</title>")
    end

    it "displays the title if no website was specified" do
      save_basic_title
      expect(@template.title()).to eq('<title>Kind of Blue</title>')
    end

    it "uses website before page by default" do
      save_basic_title
      expect(@template.title(:site => "Miles Davis", :separator => '|')).to eq("<title>Miles Davis | Kind of Blue</title>")
    end

    it "only uses markup in titles in the view" do
      expect(save_basic_title("<b>Kind of Blue</b>")).to eq("<b>Kind of Blue</b>")
      expect(@template.title(:site => "Miles Davis", :separator => '|')).to eq("<title>Miles Davis | Kind of Blue</title>")
    end

    it "uses page before website if :reverse" do
      save_basic_title
      expect(@template.title(:site => "Miles Davis", :reverse => true, :separator => '|')).to eq("<title>Kind of Blue | Miles Davis</title>")
    end

    it "uses website before page if :reverse and :reverse_on_default" do
      expect(@template.title(:site => "John Coltrane", :default => "My Favorite Things", :reverse => true, :reverse_on_default => false, :separator => '|')).to eq("<title>John Coltrane | My Favorite Things</title>")
    end

    it "lowercases the title if :lowercase" do
      save_basic_title
      expect(@template.title(:site => "Miles Davis", :lowercase => true, :separator => '|')).to eq("<title>miles davis | kind of blue</title>")
    end

    it "uppercases the title if :uppercase" do
      save_basic_title
      expect(@template.title(:site => "Miles Davis", :uppercase => true, :separator => '|')).to eq("<title>MILES DAVIS | KIND OF BLUE</title>")
    end

    it "uses a custom separator if :separator" do
      save_basic_title
      expect(@template.title(:site => "Miles Davis", :separator => "-")).to eq("<title>Miles Davis - Kind of Blue</title>")
      expect(@template.title(:site => "Miles Davis", :separator => ":")).to eq("<title>Miles Davis : Kind of Blue</title>")
      expect(@template.title(:site => "Miles Davis", :separator => "&mdash;")).to eq("<title>Miles Davis &amp;mdash; Kind of Blue</title>")
    end

    it "uses custom prefix and suffix if available" do
      save_basic_title
      expect(@template.title(:site => "Miles Davis", :prefix => " |", :suffix => "| ", :separator => '|')).to eq("<title>Miles Davis ||| Kind of Blue</title>")
    end

    it "collapses prefix if false" do
      save_basic_title
      expect(@template.title(:site => "Miles Davis", :prefix => false, :separator => ":")).to eq("<title>Miles Davis: Kind of Blue</title>")
    end

    it "collapses suffix if false" do
      save_basic_title
      expect(@template.title(:site => "Miles Davis", :suffix => false, :separator => "~")).to eq("<title>Miles Davis ~Kind of Blue</title>")
    end

    it "uses all custom options if available" do
      save_basic_title
      custom_options = { :site => "Miles Davis", :prefix => " ", :suffix => " ", :separator => "-", :lowercase => true, :reverse => true }
      expect(@template.title(custom_options)).to eq("<title>kind of blue - miles davis</title>")
    end

    it "uses the default title if title is not present or blank" do
      save_basic_title("")
      expect(@template.title(:site => "Miles Davis", :default => "Round About Midnight", :separator => '|')).to eq("<title>Miles Davis | Round About Midnight</title>")
    end

    it "allows custom options per title" do
      save_custom_title
      expect(@template.title(:site => "Freddie Freeloader", :separator => '|')).to eq("<title>Kind of Blue | Freddie Freeloader</title>")
    end

    it "accepts an array of strings as the title" do
      @template.title(['My', 'Favorite', 'Things'])
      expect(@template.title(:site => "Freddie Freeloader", :separator => '|')).to eq("<title>Freddie Freeloader | My | Favorite | Things</title>")
    end
  end

  def save_basic_title(title='Kind of Blue')
    @template.title(title)
  end

  def save_custom_title(title='Kind of Blue')
    @template.title(title, { :reverse => true })
  end

end