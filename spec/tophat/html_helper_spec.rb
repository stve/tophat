require 'spec_helper'

describe TopHat::HtmlHelper do
  before(:each) do
    @template = ActionView::Base.new
  end

  describe 'html_tag' do
    it 'returns a simple tag by default' do
      @template.html_tag.should eq('<html>')
    end

    it 'accepts a version in an options hash' do
      output = @template.html_tag(:version => '123')
      output.should eq('<html version="123">')
    end

    it 'accepts xmlns in an options hash' do
      output = @template.html_tag(:xmlns => 'http://someurl.com')
      output.should eq('<html xmlns="http://someurl.com">')
    end

    it 'accepts and array of xmlns in an options hash' do
      output = @template.html_tag(:xmlns => ['http://someurl.com', 'http://otherurl.com'])
      output.should eq('<html xmlns="http://someurl.com" xmlns="http://otherurl.com">')
    end

    it 'accepts an array of xmlns including prefixes' do
      xmlns = { :prefix => 'fb', :url => 'http://developers.facebook.com/schema/' }
      output = @template.html_tag(:xmlns => [xmlns])
      output.should eq('<html xmlns:fb="http://developers.facebook.com/schema/">')
    end

  end
end