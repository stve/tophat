require 'helper'

class TopHatStylesheetTestCase < Test::Unit::TestCase
  
  context "using the stylesheet helper" do
   
    setup do
      @template = ActionView::Base.new
    end
   
    context "stylesheets" do        
      setup do
        @stylesheet = "ie.css"
      end
      
      should "define IE conditionals" do
        assert_equal @template.ie_5_conditional { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
        
        assert_equal @template.ie_5_5_conditional { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
        
        assert_equal @template.ie_6_conditional { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if IE 6]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
        
        assert_equal @template.ie_7_conditional { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if IE 7]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
        
        assert_equal @template.ie_8_conditional { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if IE 8]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
      end
      
      should "render defined IE conditional with greater than operator" do
        assert_equal @template.ie_5_conditional(:gt) { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if gt IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
        
        assert_equal @template.ie_5_5_conditional(:gt) { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if gt IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
      end
      
      should "render defined IE conditional with greater than or equal to operator" do
        assert_equal @template.ie_5_conditional(:gte) { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if gte IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
        
        assert_equal @template.ie_5_5_conditional(:gte) { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if gte IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
      end
      
      should "render defined IE conditional with ! operator" do
        assert_equal @template.ie_5_conditional(:not) { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if !IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
        
        assert_equal @template.ie_5_5_conditional(:not) { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if !IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
      end
      
      should "render defined IE conditional with less than operator" do
        assert_equal @template.ie_5_conditional(:lt) { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if lt IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
        
        assert_equal @template.ie_5_5_conditional(:lt) { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if lt IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
      end
      
      should "render defined IE conditional with less than or equal to operator" do
        assert_equal @template.ie_5_conditional(:lte) { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if lte IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
        
        assert_equal @template.ie_5_5_conditional(:lte) { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if lte IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
      end
      
      should "render defined IE conditional with equal to operator" do
        assert_equal @template.ie_5_conditional(:eq) { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if eq IE 5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
        
        assert_equal @template.ie_5_5_conditional(:eq) { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if eq IE 5.5]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
      end
      
      should "render defined conditionals for other browsers" do
        assert_equal @template.opera_conditional { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if Opera]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
        
        assert_equal @template.webkit_conditional { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if Webkit]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"

        assert_equal @template.webkit_conditional(:eq) { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if eq Webkit]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
        
        assert_equal @template.gecko_conditional { 
          @template.stylesheet_link_tag(@stylesheet) 
        }, "<!--[if Gecko]>\n<link href=\"/stylesheets/ie.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<![endif]-->"
      end
    end
    
  end
  
end
