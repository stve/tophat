require 'spec_helper'

describe TopHat::TwitterCardHelper do

  before(:each) do
    @template = ActionView::Base.new
  end

  it 'generates a twitter:card meta tag' do
    @template.twitter_card('summary')
    output = @template.twitter_card
    output.should eq('<meta name="twitter:card" value="summary" />')
  end

  it 'generates twitter:card meta tags' do
    @template.twitter_card('summary') do
      url 'http://someurl.com'
      title 'a title'
      description 'blah blah'
      image 'http://someurl.com/animage.jpg'
    end

    output = @template.twitter_card
    output.should include('twitter:title')
    output.should include('twitter:url')
  end

  it 'generates nested twitter:card meta tags' do
    @template.twitter_card('player') do
      image 'http://someurl.com/image.jpg' do
        height '123'
        width '456'
      end
    end
    output = @template.twitter_card
    output.should include('twitter:image')
    output.should include('twitter:image:height')
    output.should include('twitter:image:width')
  end


  it 'generates multiple nested twitter:card meta tags' do
    @template.twitter_card('player') do
      player 'https://example.com/embed/a' do
        stream 'http://example.com/raw-stream/a.mp4' do
          content_type '123'
        end
      end
    end
    output = @template.twitter_card
    output.should include('twitter:player:stream:content_type')
  end

end