require 'spec_helper'

describe TopHat::MetaHelper do

  before(:each) do
    @template = ActionView::Base.new
  end

  describe "keywords" do
    context "defined as an array" do
      before do
        @keywords = %w{ John Paul George Ringo }
      end

      it "should save keywords" do
        @template.keywords(@keywords).should == @keywords.join(', ')
      end

      it "should use default keywords if keywords is empty" do
        @template.keywords(:default => @keywords).should == "<meta content=\"#{@keywords.join(', ')}\" name=\"keywords\" />"
      end
    end

    context "defined as a string" do
      before do
        @keywords = "John, Paul, George, Ringo"
      end

      it "should save keywords" do
        @template.keywords(@keywords).should == @keywords
      end

      it "should use default keywords passed as a string if keywords is empty" do
        @template.keywords(:default => @keywords).should == "<meta content=\"#{@keywords}\" name=\"keywords\" />"
      end
    end

    it "should not return a tag if no default is configured and no keywords are defined" do
      @template.keywords.should be_nil
    end

    it "doesn't blow up on nil" do
      @template.keywords(nil).should be_nil
    end

    it "should merge default tags with page tags, when merge_default is set to true" do
      @template.keywords("Stu, Pete")
      @template.keywords(:default => "John, Paul, George, Ringo", :merge_default => true).should == "<meta content=\"Stu, Pete, John, Paul, George, Ringo\" name=\"keywords\" />"
    end
  end

  describe ".description" do
    it "should save the description" do
      desc = "Cinderella story. Outta nowhere. A former greenskeeper, now, about to become the Masters champion."
      @template.description(desc).should == desc
    end

    it "should use the default description if no description is defined" do
      desc = "A flute without holes, is not a flute. A donut without a hole, is a Danish."
      @template.description(:default => desc).should == "<meta content=\"#{desc}\" name=\"description\" />"
    end

    it "doesn't blow up on nil" do
      @template.description(nil).should be_nil
    end

    it "should not return a tag if no default is configured and no description is defined" do
      @template.description.should be_nil
    end
  end

end