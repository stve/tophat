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
    output.should eq('<meta content="summary" name="twitter:card" />')
  end

  it 'generates twitter:card meta tags' do
    @template.twitter_card('summary') do |card|
      card.url 'http://someurl.com'
      card.title @title
      card.description 'blah blah'
      card.image @image
    end

    output = @template.twitter_card
    output.should include('<meta content="Rain Man" name="twitter:title" />')
    output.should include('<meta content="http://someurl.com/animage.jpg" name="twitter:image" />')
  end

  it 'generates nested twitter:card meta tags' do
    @template.twitter_card('player') do |card|
      card.image @image do |image|
        image.height @height
        image.width @width
      end
    end

    output = @template.twitter_card
    output.should include('<meta content="http://someurl.com/animage.jpg" name="twitter:image" />')
    output.should include('<meta content="123" name="twitter:image:height" />')
    output.should include('<meta content="456" name="twitter:image:width" />')
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
    output.should include('<meta content="http://example.com/raw-stream/a.mp4" name="twitter:player:stream" />')
    output.should include('<meta content="123" name="twitter:player:stream:content_type" />')
  end

end