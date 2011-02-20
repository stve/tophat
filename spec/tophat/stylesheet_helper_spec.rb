require 'spec_helper'

describe TopHat::StylesheetHelper do

  before(:each) do
    ENV["RAILS_ASSET_ID"] = ''
    public_dir = File.join(File.dirname(__FILE__), 'public')
    @helpers = ActionController::Base.helpers
    @helpers.config.perform_caching = false
    @helpers.config.assets_dir = public_dir
    @helpers.config.javascripts_dir = "#{public_dir}/javascripts"
    @helpers.config.stylesheets_dir = "#{public_dir}/stylesheets"

    @template = ActionView::Base.new

    @stylesheet = "ie.css"
  end

  it "should define IE conditionals" do
    @template.ie_5_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

    @template.ie_5_5_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

    @template.ie_6_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if IE 6]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

    @template.ie_7_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if IE 7]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

    @template.ie_8_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if IE 8]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

    @template.ie_9_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if IE 9]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
  end

  it "should render defined IE conditional with greater than operator" do
    @template.ie_5_conditional(:gt) {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if gt IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

    @template.ie_5_5_conditional(:gt) {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if gt IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
  end

  it "should render defined IE conditional with greater than or equal to operator" do
    @template.ie_5_conditional(:gte) {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if gte IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

    @template.ie_5_5_conditional(:gte) {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if gte IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
  end

  it "should render defined IE conditional with ! operator" do
    @template.ie_5_conditional(:not) {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if !IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

    @template.ie_5_5_conditional(:not) {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if !IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
  end

  it "should render defined IE conditional with less than operator" do
    @template.ie_5_conditional(:lt) {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if lt IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

    @template.ie_5_5_conditional(:lt) {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if lt IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
  end

  it "should render defined IE conditional with less than or equal to operator" do
    @template.ie_5_conditional(:lte) {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if lte IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

    @template.ie_5_5_conditional(:lte) {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if lte IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
  end

  it "should render defined IE conditional with equal to operator" do
    @template.ie_5_conditional(:eq) {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if eq IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

    @template.ie_5_5_conditional(:eq) {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if eq IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
  end

  it "should render defined conditionals for other browsers" do
    @template.opera_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if Opera]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

    @template.webkit_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if Webkit]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

    @template.webkit_conditional(:eq) {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if eq Webkit]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

    @template.gecko_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }.should == "<!--[if Gecko]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
  end

end