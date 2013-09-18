require 'spec_helper'

describe TopHat::OpenGraphHelper do
  before(:all) do
    @title = 'Rain Man'
    @type = 'movie'
  end

  before(:each) do
    @template = ActionView::Base.new
  end

  describe 'opengraph_html' do
    context 'default style' do
      it 'renders an html tag with namespace' do
        output = @template.opengraph_html
        output.should =~ /<html/
        output.should =~ /xmlns\:og/
        output.should =~ /xmlns\:fb/
      end
    end

    context 'html5 style' do
      it 'renders an html tag with namespace' do
        output = @template.opengraph_html('html5')
        output.should =~ /<html/
        output.should =~ /xmlns\:og/
        output.should =~ /xmlns\:fb/
      end
    end

    context 'unknown style' do
      it 'returns an empty html tag' do
        @template.opengraph_html('funny').should eq('<html>')
      end
    end

    it 'it supports deprecated html_with_opengraph' do
      @template.opengraph_html.should eq(@template.html_with_opengraph)
    end
  end

  context "site admins when configured" do
    context "as a string" do
      it "generates a site admin tag" do
        @template.opengraph(:admins => '123,124')
        @template.opengraph.should include('<meta content="123,124" property="fb:admins" />')
      end
    end

    context "as an array" do
      it "generates a site admin tag" do
        @template.opengraph(:admins => [123, 124])
        @template.opengraph.should include('<meta content="123,124" property="fb:admins" />')
      end
    end
  end

  context "app_id when configured" do
    it "generates an app_id meta tag" do
      @template.opengraph(:app_id => 'MyApp')
      @template.opengraph.should include('<meta content="MyApp" property="fb:app_id" />')
    end
  end

  context "additional open graph properties" do
    it "generates opengraph meta tags" do
      @template.opengraph { |og| og.title 'The Great Gatsby' }
      @template.opengraph.should include('<meta content="The Great Gatsby" property="og:title" />')
    end

    it "allows use of the tag 'type'" do
      @template.opengraph { |og| og.type 'sports_team' }
      @template.opengraph.should include('<meta content="sports_team" property="og:type" />')
    end

    it "supports multiple tags" do
      @template.opengraph do |og|
        og.title 'Austin Powers: International Man of Mystery'
        og.type 'movie'
      end
      output = @template.opengraph

      output.should include('<meta content="movie" property="og:type" />')
      output.should include('<meta content="Austin Powers: International Man of Mystery" property="og:title" />')
    end

    it 'supports default tags' do
      @template.opengraph do |og|
        og.title @title
        og.type @type
      end
      output = @template.opengraph do |og|
        og.rating '5/10'
      end

      output.should include('<meta content="movie" property="og:type" />')
      output.should include('<meta content="Rain Man" property="og:title" />')
      output.should include('<meta content="5/10" property="og:rating" />')
    end
  end

  context "combined usage" do
    it "generates all tags when app_id and admins passed as part of definition" do
      @template.opengraph(:app_id => 'MyApp', :admins => [123, 1234]) do |og|
        og.title @title
        og.type @type
      end
      output = @template.opengraph

      output.should include('<meta content="MyApp" property="fb:app_id" />')
      output.should include('<meta content="123,1234" property="fb:admins" />')
      output.should include('<meta content="movie" property="og:type" />')
      output.should include('<meta content="Rain Man" property="og:title" />')
    end

    it "generates all tags when app_id and admins passed as part of rendering" do
      @template.opengraph do |og|
        og.title @title
        og.type @type
      end
      output = @template.opengraph(:app_id => 'MyApp', :admins => [123, 1234])

      output.should include('<meta content="MyApp" property="fb:app_id" />')
      output.should include('<meta content="123,1234" property="fb:admins" />')
      output.should include('<meta content="movie" property="og:type" />')
      output.should include('<meta content="Rain Man" property="og:title" />')
    end

    it 'supports default tags' do
      @template.opengraph do |og|
        og.title @title
        og.type @type
      end
      output = @template.opengraph(:app_id => 'MyApp', :admins => [123, 1234]) do |og|
        og.rating '5/10'
      end

      output.should include('<meta content="MyApp" property="fb:app_id" />')
      output.should include('<meta content="123,1234" property="fb:admins" />')
      output.should include('<meta content="movie" property="og:type" />')
      output.should include('<meta content="Rain Man" property="og:title" />')
      output.should include('<meta content="5/10" property="og:rating" />')
    end
  end

end
