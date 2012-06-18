require 'spec_helper'

describe TopHat::OpenGraphHelper do

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
        @template.opengraph.should be_dom_equivalent_to('<meta content="123,124" property="fb:admins" />\n')
      end
    end

    context "as an array" do
      it "generates a site admin tag" do
        @template.opengraph(:admins => [123, 124])
        @template.opengraph.should be_dom_equivalent_to('<meta content="123,124" property="fb:admins" />\n')
      end
    end
  end

  context "app_id when configured" do
    it "generates an app_id meta tag" do
      @template.opengraph(:app_id => 'MyApp')
      @template.opengraph.should be_dom_equivalent_to('<meta content="MyApp" property="fb:app_id" />\n')
    end
  end

  context "additional open graph properties" do
    it "generates opengraph meta tags" do
      @template.opengraph { title 'The Great Gatsby' }
      @template.opengraph.should be_dom_equivalent_to('<meta content="The Great Gatsby" property="og:title" />')
    end

    it "allows use of the tag 'type'" do
      @template.opengraph { type 'sports_team' }
      @template.opengraph.should be_dom_equivalent_to('<meta content="sports_team" property="og:type" />')
    end

    it "supports multiple tags" do
      @template.opengraph {
        title 'Austin Powers: International Man of Mystery'
        type 'movie'
      }
      @template.opengraph.should be_dom_equivalent_to('<meta content="movie" property="og:type" />\n<meta content="Austin Powers: International Man of Mystery" property="og:title" />\n')
    end

  end

  context "combined usage" do
    it "generates all tags when app_id and admins passed as part of definition" do
      @template.opengraph(:app_id => 'MyApp', :admins => [123, 1234]) {
        title 'Rain Man'
        type 'movie'
      }
      @template.opengraph.should be_dom_equivalent_to('<meta content="MyApp" property="fb:app_id" />\n<meta content="123,1234" property="fb:admins" />\n<meta content="movie" property="og:type" />\n<meta content="Rain Man" property="og:title" />\n')
    end

    it "generates all tags when app_id and admins passed as part of rendering" do
      @template.opengraph {
        title 'Rain Man'
        type 'movie'
      }
      @template.opengraph(:app_id => 'MyApp', :admins => [123, 1234]).should be_dom_equivalent_to('<meta content="MyApp" property="fb:app_id" />\n<meta content="123,1234" property="fb:admins" />\n<meta content="movie" property="og:type" />\n<meta content="Rain Man" property="og:title" />\n')
    end
  end

  context 'deprecated support' do
    it 'generates multiple tags' do
      @template.opengraph { |graph|
        graph.title 'Rain Man'
        graph.type 'movie'
      }

      @template.opengraph.should be_dom_equivalent_to('<meta content="movie" property="og:type" />\n<meta content="Rain Man" property="og:title" />\n')
    end
  end

end