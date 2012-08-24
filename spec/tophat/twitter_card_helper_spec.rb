require 'spec_helper'

describe TopHat::TwitterCardHelper do
  before(:all) do
    @title = 'Rain Man'
    @image = 'http://someurl.com/animage.jpg'
    @height = 123
    @width  = 456
  end

  before(:each) do
    @template = ActionView::Base.new
  end

  it 'generates a twitter:card meta tag' do
    @template.twitter_card('summary')

    output = @template.twitter_card
    output.should eq('<meta name="twitter:card" value="summary" />')
  end

  it 'generates twitter:card meta tags' do
    @template.twitter_card('summary') do |card|
      card.url 'http://someurl.com'
      card.title @title
      card.description 'blah blah'
      card.image @image
    end

    output = @template.twitter_card
    output.should include('<meta name="twitter:title" value="Rain Man" />')
    output.should include('<meta name="twitter:image" value="http://someurl.com/animage.jpg" />')
  end

  it 'generates nested twitter:card meta tags' do
    @template.twitter_card('player') do |card|
      card.image @image do |image|
        image.height @height
        image.width @width
      end
    end

    output = @template.twitter_card
    output.should include('<meta name="twitter:image" value="http://someurl.com/animage.jpg" />')
    output.should include('<meta name="twitter:image:height" value="123" />')
    output.should include('<meta name="twitter:image:width" value="456" />')
  end


  it 'generates multiple nested twitter:card meta tags' do
    @template.twitter_card('player') do |card|
      card.player 'https://example.com/embed/a' do |player|
        player.stream 'http://example.com/raw-stream/a.mp4' do |stream|
          stream.content_type '123'
        end
      end
    end

    output = @template.twitter_card
    output.should include('<meta name="twitter:player:stream" value="http://example.com/raw-stream/a.mp4" />')
    output.should include('<meta name="twitter:player:stream:content_type" value="123" />')
  end

end