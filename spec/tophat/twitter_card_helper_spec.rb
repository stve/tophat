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
    expect(output).to eq('<meta name="twitter:card" value="summary" />')
  end

  it 'generates twitter:card meta tags' do
    @template.twitter_card('summary') do |card|
      card.url 'http://someurl.com'
      card.title @title
      card.description 'blah blah'
      card.image @image
    end

    output = @template.twitter_card
    expect(output).to include('<meta name="twitter:title" value="Rain Man" />')
    expect(output).to include('<meta name="twitter:image" value="http://someurl.com/animage.jpg" />')
  end

  it 'generates nested twitter:card meta tags' do
    @template.twitter_card('player') do |card|
      card.image @image do |image|
        image.height @height
        image.width @width
      end
    end

    output = @template.twitter_card
    expect(output).to include('<meta name="twitter:image" value="http://someurl.com/animage.jpg" />')
    expect(output).to include('<meta name="twitter:image:height" value="123" />')
    expect(output).to include('<meta name="twitter:image:width" value="456" />')
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
    expect(output).to include('<meta name="twitter:player:stream" value="http://example.com/raw-stream/a.mp4" />')
    expect(output).to include('<meta name="twitter:player:stream:content_type" value="123" />')
  end

  it 'supports default tags' do
    @template.twitter_card('player') do |card|
      card.player do |player|
        player.embed 'https://example.com/embed/a'
      end
    end
    output = @template.twitter_card('player') do |card|
      card.player do |player|
        player.site 'https://example.com'
      end
    end

    expect(output).to include('<meta name="twitter:player:embed" value="https://example.com/embed/a" />')
    expect(output).to include('<meta name="twitter:player:site" value="https://example.com" />')
    expect(output).not_to include('<meta name="twitter:embed" value="https://example.com/embed/a" />')
  end

end
