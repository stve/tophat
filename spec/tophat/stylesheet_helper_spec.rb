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

  it "defines IE conditionals" do
    expect(@template.ie_5_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.ie_5_5_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.ie_6_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if IE 6]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.ie_7_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if IE 7]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.ie_8_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if IE 8]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.ie_9_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if IE 9]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")
  end

  it "renders defined IE conditional with greater than operator" do
    expect(@template.ie_5_conditional(:gt) {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if gt IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.ie_5_5_conditional(:gt) {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if gt IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")
  end

  it "renders defined IE conditional with greater than or equal to operator" do
    expect(@template.ie_5_conditional(:gte) {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if gte IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.ie_5_5_conditional(:gte) {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if gte IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")
  end

  it "renders defined IE conditional with ! operator" do
    expect(@template.ie_5_conditional(:not) {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if !IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.ie_5_5_conditional(:not) {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if !IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")
  end

  it "renders defined IE conditional with less than operator" do
    expect(@template.ie_5_conditional(:lt) {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if lt IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.ie_5_5_conditional(:lt) {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if lt IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")
  end

  it "renders defined IE conditional with less than or equal to operator" do
    expect(@template.ie_5_conditional(:lte) {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if lte IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.ie_5_5_conditional(:lte) {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if lte IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")
  end

  it "renders defined IE conditional with equal to operator" do
    expect(@template.ie_5_conditional(:eq) {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if eq IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.ie_5_5_conditional(:eq) {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if eq IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")
  end

  it "renders defined conditionals for other browsers" do
    expect(@template.opera_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if Opera]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.webkit_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if Webkit]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.webkit_conditional(:eq) {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if eq Webkit]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.gecko_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if Gecko]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.ie_mac_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if IEMac]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.konqueror_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if Konq]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.ie_mobile_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if IEmob]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.psp_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if PSP]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.net_front_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if NetF]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

    expect(@template.mobile_safari_conditional {
      @template.stylesheet_link_tag(@stylesheet)
    }).to eq("<!--[if SafMob]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->")

  end

end