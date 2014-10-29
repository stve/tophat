require 'spec_helper'

describe TopHat::RobotsHelper do

  before(:all) do
    @template = ActionView::Base.new
  end

  describe ".nofollow" do
    it "defaults to all robots" do
      expect(@template.nofollow).to eq("<meta content=\"nofollow\" name=\"robots\" />")
    end

    it "uses a descriptor if one is provided" do
      expect(@template.nofollow('googlebot')).to eq("<meta content=\"nofollow\" name=\"googlebot\" />")
    end

    it "generates a default tag when passed nil" do
      expect(@template.nofollow(nil)).to eq("<meta content=\"nofollow\" name=\"robots\" />")
    end

    it 'stores a descriptor' do
      @template.nofollow('twitterbot')
      expect(@template.nofollow).to eq("<meta content=\"nofollow\" name=\"twitterbot\" />")
    end
  end

  describe ".noindex" do
    it "defaults to all robots" do
      expect(@template.noindex).to eq("<meta content=\"noindex\" name=\"robots\" />")
    end

    it "uses a descriptor if one is provided" do
      expect(@template.noindex('googlebot')).to eq("<meta content=\"noindex\" name=\"googlebot\" />")
    end

    it "generates a default tag when passed nil" do
      expect(@template.noindex(nil)).to eq("<meta content=\"noindex\" name=\"robots\" />")
    end

    it 'stores a descriptor' do
      @template.noindex('twitterbot')
      expect(@template.noindex).to eq("<meta content=\"noindex\" name=\"twitterbot\" />")
    end
  end

  describe ".canonical" do
    it "returns nil when not passed a path" do
      expect(@template.canonical).to be_nil
    end

    it "renders a tag when passed a path" do
      expect(@template.canonical('http://mysite.com/somepath/')).to eq("<link href=\"http://mysite.com/somepath/\" rel=\"canonical\" />")
    end

    it "returns nil when passed nil" do
      expect(@template.canonical(nil)).to be_nil
    end
  end

end
