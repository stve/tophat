require 'spec_helper'

describe TopHat::OpenGraphHelper do

  before(:each) do
    @template = ActionView::Base.new
  end

  context 'html_with_opengraph' do
    it 'renders an html tag with namespace' do
      @template.html_with_opengraph.should =~ /<html/
      @template.html_with_opengraph.should =~ /xmlns\:og/
      @template.html_with_opengraph.should =~ /xmlns\:fb/
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
      @template.opengraph { |graph| graph.title 'The Great Gatsby' }
      @template.opengraph.should be_dom_equivalent_to('<meta content="The Great Gatsby" property="og:title" />')
    end

    it "allows use of the tag 'type'" do
      @template.opengraph { |graph| graph.type 'sports_team' }
      @template.opengraph.should be_dom_equivalent_to('<meta content="sports_team" property="og:type" />')
    end

    it "supports multiple tags" do
      @template.opengraph { |graph|
        graph.title 'Austin Powers: International Man of Mystery'
        graph.type 'movie'
      }
      @template.opengraph.should be_dom_equivalent_to('<meta content="movie" property="og:type" />\n<meta content="Austin Powers: International Man of Mystery" property="og:title" />\n')
    end

  end

  context "combined usage" do
    it "generates all tags" do
      @template.opengraph(:app_id => 'MyApp', :admins => [123, 1234]) { |graph|
        graph.title 'Rain Man'
        graph.type 'movie'
      }
      @template.opengraph.should be_dom_equivalent_to('<meta content="MyApp" property="fb:app_id" />\n<meta content="123,1234" property="fb:admins" />\n<meta content="movie" property="og:type" />\n<meta content="Rain Man" property="og:title" />\n')
    end

    it "generates all tags - alternative usage" do
      @template.opengraph { |graph|
        graph.title 'Rain Man'
        graph.type 'movie'
      }
      @template.opengraph(:app_id => 'MyApp', :admins => [123, 1234]).should be_dom_equivalent_to('<meta content="MyApp" property="fb:app_id" />\n<meta content="123,1234" property="fb:admins" />\n<meta content="movie" property="og:type" />\n<meta content="Rain Man" property="og:title" />\n')
    end
  end

end