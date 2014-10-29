require 'spec_helper'

describe TopHat do

  before(:each) do
    @template = ActionView::Base.new
  end

  it "is mixed into ActionView::Base" do
    expect(ActionView::Base.included_modules.include?(TopHat::TitleHelper)).to be_truthy
    expect(ActionView::Base.included_modules.include?(TopHat::MetaHelper)).to be_truthy
    expect(ActionView::Base.included_modules.include?(TopHat::StylesheetHelper)).to be_truthy
  end

  it "responds to the 'title' helper" do
    expect(@template.respond_to?(:title)).to be_truthy
  end

  it "responds to the 'title' helper alias" do
    expect(@template.respond_to?(:t)).to be_truthy
  end

  it "responds to the 'description' helper" do
    expect(@template.respond_to?(:description)).to be_truthy
  end

  it "responds to the 'keywords' helper" do
    expect(@template.respond_to?(:keywords)).to be_truthy
  end

  it "responds to the 'ie_5_conditional' helper" do
    expect(@template.respond_to?(:ie_5_conditional)).to be_truthy
  end

  it "responds to the 'ie_5_5_conditional' helper" do
    expect(@template.respond_to?(:ie_5_5_conditional)).to be_truthy
  end

  it "responds to the 'ie_6_conditional' helper" do
    expect(@template.respond_to?(:ie_6_conditional)).to be_truthy
  end

  it "responds to the 'ie_7_conditional' helper" do
    expect(@template.respond_to?(:ie_7_conditional)).to be_truthy
  end

  it "responds to the 'ie_8_conditional' helper" do
    expect(@template.respond_to?(:ie_8_conditional)).to be_truthy
  end

  it "responds to the 'ie_9_conditional' helper" do
    expect(@template.respond_to?(:ie_9_conditional)).to be_truthy
  end

  it "responds to the 'opengraph' helper" do
    expect(@template.respond_to?(:opengraph)).to be_truthy
  end

  it "responds to the 'noindex' helper" do
    expect(@template.respond_to?(:noindex)).to be_truthy
  end

  it "responds to the 'nofollow' helper" do
    expect(@template.respond_to?(:nofollow)).to be_truthy
  end

  it "responds to the 'canonical' helper" do
    expect(@template.respond_to?(:canonical)).to be_truthy
  end

  it "responds to the 'twitter_card' helper" do
    expect(@template.respond_to?(:twitter_card)).to be_truthy
  end

  it "responds to the 'html_tag' helper" do
    expect(@template.respond_to?(:html_tag)).to be_truthy
  end

  describe '.current' do
    it 'returns a hash' do
      expect(TopHat.current).to be_kind_of(Hash)
    end

    it 'allows the hash to be modified' do
      TopHat.current[:title] = 'foo'

      expect(TopHat.current[:title]).to eq('foo')
    end
  end

end
