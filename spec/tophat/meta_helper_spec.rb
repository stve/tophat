require 'spec_helper'

describe TopHat::MetaHelper do

  before(:each) do
    @template = ActionView::Base.new
  end

  describe "charset" do
    it 'renders a meta tag with a charset' do
      expect(@template.charset('utf-8')).to eq('<meta charset="utf-8">')
    end
  end

  describe "viewport" do
    it 'renders a meta tag with a viewport' do
      expect(@template.viewport('width=device-width')).to eq('<meta content="width=device-width" name="viewport">')
    end
  end

  describe "meta_tag" do
    it 'renders meta_tags' do
      expect(@template.meta_tag(:charset => 'utf-8')).to eq('<meta charset="utf-8" />')
    end
  end

  describe "keywords" do
    context "defined as an array" do
      before do
        @keywords = %w{ John Paul George Ringo }
      end

      it "saves keywords" do
        expect(@template.keywords(@keywords)).to eq(@keywords.join(', '))
      end

      it "uses default keywords if keywords is empty" do
        expect(@template.keywords(:default => @keywords)).to eq("<meta content=\"#{@keywords.join(', ')}\" name=\"keywords\" />")
      end
    end

    context "defined as a string" do
      before do
        @keywords = "John, Paul, George, Ringo"
      end

      it "saves keywords" do
        expect(@template.keywords(@keywords)).to eq(@keywords)
      end

      it "uses default keywords passed as a string if keywords is empty" do
        expect(@template.keywords(:default => @keywords)).to eq("<meta content=\"#{@keywords}\" name=\"keywords\" />")
      end
    end

    it "return nil when no default is configured and no keywords are defined" do
      expect(@template.keywords).to be_nil
    end

    it "returns nil when passed nil" do
      expect(@template.keywords(nil)).to be_nil
    end

    it "merges default tags with page tags, when merge_default is set to true" do
      @template.keywords("Stu, Pete")
      expect(@template.keywords(:default => "John, Paul, George, Ringo", :merge_default => true)).to eq("<meta content=\"Stu, Pete, John, Paul, George, Ringo\" name=\"keywords\" />")
    end
  end

  describe ".description" do
    it "saves the description" do
      desc = "Cinderella story. Outta nowhere. A former greenskeeper, now, about to become the Masters champion."
      expect(@template.description(desc)).to eq(desc)
    end

    it "uses the default description if no description is defined" do
      desc = "A flute without holes, is not a flute. A donut without a hole, is a Danish."
      expect(@template.description(:default => desc)).to eq("<meta content=\"#{desc}\" name=\"description\" />")
    end

    it "returns nil when passed nil" do
      expect(@template.description(nil)).to be_nil
    end

    it "returns nil when no default is configured and no description is defined" do
      expect(@template.description).to be_nil
    end

    it 'overrides the default' do
      @template.description('This is a custom description')
      expect(@template.description(:default => 'This is a default description.')).to eq('<meta content="This is a custom description" name="description" />')
    end

    it "uses the default description if custom description is blank" do
      @template.description('')
      expect(@template.description(:default => 'This is a default description')).to eq('<meta content="This is a default description" name="description" />')
    end 
  end

  describe ".itemprop" do
    it "renders an itemprop meta tag" do
      expect(@template.itemprop(:rating, '1')).to eq("<meta content=\"1\" itemprop=\"rating\" />")
    end
  end

end
