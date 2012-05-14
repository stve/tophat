require 'spec_helper'

describe TopHat do

  context "loading the TopHat plugin" do
    before(:each) do
      @template = ActionView::Base.new
    end

    it "be mixed into ActionView::Base" do
      ActionView::Base.included_modules.include?(TopHat::TitleHelper).should be_true
      ActionView::Base.included_modules.include?(TopHat::MetaHelper).should be_true
      ActionView::Base.included_modules.include?(TopHat::StylesheetHelper).should be_true
    end

    it "should respond to the 'title' helper" do
      @template.respond_to?(:title).should be_true
    end

    it "should respond to the 'title' helper alias" do
      @template.respond_to?(:t).should be_true
    end

    it "should respond to the 'description' helper" do
      @template.respond_to?(:description).should be_true
    end

    it "should respond to the 'keywords' helper" do
      @template.respond_to?(:keywords).should be_true
    end

    it "should respond to the 'ie_5_conditional' helper" do
      @template.respond_to?(:ie_5_conditional).should be_true
    end

    it "should respond to the 'ie_5_5_conditional' helper" do
      @template.respond_to?(:ie_5_5_conditional).should be_true
    end

    it "should respond to the 'ie_6_conditional' helper" do
      @template.respond_to?(:ie_6_conditional).should be_true
    end

    it "should respond to the 'ie_7_conditional' helper" do
      @template.respond_to?(:ie_7_conditional).should be_true
    end

    it "should respond to the 'ie_8_conditional' helper" do
      @template.respond_to?(:ie_8_conditional).should be_true
    end

    it "should respond to the 'ie_9_conditional' helper" do
      @template.respond_to?(:ie_9_conditional).should be_true
    end

    it "should respond to the 'opengraph' helper" do
      @template.respond_to?(:opengraph).should be_true
    end

    it "should respond to the 'noindex' helper" do
      @template.respond_to?(:noindex).should be_true
    end

    it "should respond to the 'nofollow' helper" do
      @template.respond_to?(:nofollow).should be_true
    end

    it "should respond to the 'canonical' helper" do
      @template.respond_to?(:canonical).should be_true
    end
  end

  describe '.current' do
    it 'returns a hash' do
      TopHat.current.should be_kind_of(Hash)
    end

    it 'allows the hash to be modified' do
      TopHat.current[:title] = 'foo'

      TopHat.current[:title].should eq('foo')
    end
  end

end
