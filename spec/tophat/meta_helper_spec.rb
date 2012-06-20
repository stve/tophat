require 'spec_helper'

describe TopHat::MetaHelper do

  before(:each) do
    @template = ActionView::Base.new
  end

  describe "charset" do
    it 'renders a meta tag with a charset' do
      @template.charset('utf-8').should eq('<meta charset="utf-8">')
    end
  end

  describe "viewport" do
    it 'renders a meta tag with a viewport' do
      @template.viewport('width=device-width').should eq('<meta content="width=device-width" name="viewport">')
    end
  end

  describe "meta_tag" do
    it 'renders meta_tags' do
      @template.meta_tag(:charset => 'utf-8').should eq('<meta charset="utf-8" />')
    end
  end

  describe "keywords" do
    context "defined as an array" do
      before do
        @keywords = %w{ John Paul George Ringo }
      end

      it "saves keywords" do
        @template.keywords(@keywords).should == @keywords.join(', ')
      end

      it "uses default keywords if keywords is empty" do
        @template.keywords(:default => @keywords).should == "<meta content=\"#{@keywords.join(', ')}\" name=\"keywords\" />"
      end
    end

    context "defined as a string" do
      before do
        @keywords = "John, Paul, George, Ringo"
      end

      it "saves keywords" do
        @template.keywords(@keywords).should == @keywords
      end

      it "uses default keywords passed as a string if keywords is empty" do
        @template.keywords(:default => @keywords).should == "<meta content=\"#{@keywords}\" name=\"keywords\" />"
      end
    end

    it "return nil when no default is configured and no keywords are defined" do
      @template.keywords.should be_nil
    end

    it "returns nil when passed nil" do
      @template.keywords(nil).should be_nil
    end

    it "merges default tags with page tags, when merge_default is set to true" do
      @template.keywords("Stu, Pete")
      @template.keywords(:default => "John, Paul, George, Ringo", :merge_default => true).should == "<meta content=\"Stu, Pete, John, Paul, George, Ringo\" name=\"keywords\" />"
    end
  end

  describe ".description" do
    it "saves the description" do
      desc = "Cinderella story. Outta nowhere. A former greenskeeper, now, about to become the Masters champion."
      @template.description(desc).should == desc
    end

    it "uses the default description if no description is defined" do
      desc = "A flute without holes, is not a flute. A donut without a hole, is a Danish."
      @template.description(:default => desc).should == "<meta content=\"#{desc}\" name=\"description\" />"
    end

    it "returns nil when passed nil" do
      @template.description(nil).should be_nil
    end

    it "returns nil when no default is configured and no description is defined" do
      @template.description.should be_nil
    end
  end

end