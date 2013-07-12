require 'spec_helper'

describe TopHat::RobotsHelper do

  before(:all) do
    @template = ActionView::Base.new
  end

  describe ".nofollow" do
    it "defaults to all robots" do
      @template.nofollow.should == "<meta content=\"nofollow\" name=\"robots\" />"
    end

    it "uses a descriptor if one is provided" do
      @template.nofollow('googlebot').should == "<meta content=\"nofollow\" name=\"googlebot\" />"
    end

    it "generates a default tag when passed nil" do
      @template.nofollow(nil).should == "<meta content=\"nofollow\" name=\"robots\" />"
    end

    it 'stores a descriptor' do
      @template.nofollow('twitterbot')
      @template.nofollow.should == "<meta content=\"nofollow\" name=\"twitterbot\" />"
    end
  end

  describe ".noindex" do
    it "defaults to all robots" do
      @template.noindex.should == "<meta content=\"noindex\" name=\"robots\" />"
    end

    it "uses a descriptor if one is provided" do
      @template.noindex('googlebot').should == "<meta content=\"noindex\" name=\"googlebot\" />"
    end

    it "generates a default tag when passed nil" do
      @template.noindex(nil).should == "<meta content=\"noindex\" name=\"robots\" />"
    end

    it 'stores a descriptor' do
      @template.noindex('twitterbot')
      @template.noindex.should == "<meta content=\"noindex\" name=\"twitterbot\" />"
    end
  end

  describe ".canonical" do
    it "returns nil when not passed a path" do
      @template.canonical.should be_nil
    end

    it "renders a tag when passed a path" do
      @template.canonical('http://mysite.com/somepath/').should == "<link href=\"http://mysite.com/somepath/\" rel=\"canonical\" />"
    end

    it "returns nil when passed nil" do
      @template.canonical(nil).should be_nil
    end
  end

end
