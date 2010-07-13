module TopHat
  module OpenGraphHelper

    class OpenGraphGenerator
      def initialize(options={})
        @app_id = options.delete(:app_id)
        @admins = options.delete(:admins)
      end
      
      def app_id
        @app_id ? "<meta property=\"fb:app_id\" content=\"#{@app_id}\"/>" : ""
      end
      
      def admins
        @admins ? "<meta property=\"fb:admins\" content=\"#{[*@admins].join(',')}\"/>" : ""
      end
      
    end
    
    def opengraph(options=nil, &block)
      if options.kind_of? Hash
        @open_graph_defaults = options || {}
      else
        og = OpenGraphGenerator.new(@open_graph_defaults)
        output = ""
        output << og.app_id
        output << og.admins
        output << yield if block_given?
        output
      end
    end
    
  end
end

#     * og:title - The title of your object as it should appear within the graph, e.g., "The Rock".
#     * og:type - The type of your object, e.g., "movie". See the complete list of supported types.
#     * og:image - An image URL which should represent your object within the graph. The image must be at least 50px by 50px and have a maximum aspect ratio of 3:1.
#     * og:url - The canonical URL of your object that will be used as its permanent ID in the graph, e.g., http://www.imdb.com/title/tt0117500/.
# 
# In addition, we've extended the basic meta data to add two required fields to connect your page with:
# 
#     * og:site_name - A human-readable name for your site, e.g., "IMDb". The Open Graph Protocol defines this as optional, but Facebook requires it.
#     * fb:admins or fb:app_id - A comma-separated list of either Facebook user IDs or a Facebook Platform application ID that administers this page.
# 
# It's also recommended that you include the following property as well as these multi-part properties.
# 
#     * og:description - A one to two sentence description of your page.
# 
#     <meta property="fb:admins" content="USER_ID"/>
#         <meta property="og:site_name" content="IMDb"/>
#         <meta property="og:description"
#               content="A group of U.S. Marines, under command of
#                        a renegade general, take over Alcatraz and
#                        threaten San Francisco Bay with biological
#                        weapons."/>
# 
#                          <meta property="og:title" content="The Rock"/>
#                          <meta property="og:type" content="movie"/>
#                          <meta property="og:url" content="http://www.imdb.com/title/tt0117500/"/>
#                          <meta property="og:image" content="http://ia.media-imdb.com/rock.jpg"/>
#                          ...
#                        </head>
#                        
#                        
#                        # location
#                        
#                        <meta property="og:latitude" content="37.416343"/>
#                        <meta property="og:longitude" content="-122.153013"/>
#                        <meta property="og:street-address" content="1601 S California Ave"/>
#                        <meta property="og:locality" content="Palo Alto"/>
#                        <meta property="og:region" content="CA"/>
#                        <meta property="og:postal-code" content="94304"/>
#                        <meta property="og:country-name" content="USA"/>
# 
#                       # contact info
#                       
#                       <meta property="og:email" content="me@example.com"/>
#                       <meta property="og:phone_number" content="650-123-4567"/>
#                       <meta property="og:fax_number" content="+1-415-123-4567"/>
#                       