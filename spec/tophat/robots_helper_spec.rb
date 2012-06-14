require 'spec_helper'

describe TopHat::RobotsHelper do

  before(:all) do
    @template = ActionView::Base.new
  end

  describe ".nofollow" do
    it "should default to all robots" do
      @template.nofollow.should == "<meta content=\"nofollow\" name=\"robots\" />"
    end

    it "should use a descriptor if one is provided" do
      @template.nofollow('googlebot').should == "<meta content=\"nofollow\" name=\"googlebot\" />"
    end

    it "doesn't blow up on nil" do
      @template.nofollow(nil).should == "<meta content=\"nofollow\" name=\"robots\" />"
    end
  end

  describe ".noindex" do
    it "should default to all robots" do
      @template.noindex.should == "<meta content=\"noindex\" name=\"robots\" />"
    end

    it "should use a descriptor if one is provided" do
      @template.noindex('googlebot').should == "<meta content=\"noindex\" name=\"googlebot\" />"
    end

    it "doesn't blow up on nil" do
      @template.noindex(nil).should == "<meta content=\"noindex\" name=\"robots\" />"
    end
  end

  describe ".canonical" do
    it "should not render when not passed a path" do
      @template.canonical.should be_nil
    end

    it "should render a tag when passed a path" do
      @template.canonical('http://mysite.com/somepath/').should == "<link href=\"http://mysite.com/somepath/\" rel=\"canonical\" />"
    end

    it "doesn't blow up on nil" do
      @template.canonical(nil).should be_nil
    end
  end

end