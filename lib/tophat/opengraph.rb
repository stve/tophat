module TopHat
  module OpenGraphHelper

    class OpenGraphGenerator
      include ActionView::Helpers
      
      def initialize(options={})
        @app_id = options.delete(:app_id) if options && options.has_key?(:app_id)
        @admins = options.delete(:admins) if options && options.has_key?(:admins)
        @graph_data = {}
      end
      
      def merge(options={})
        @app_id = options.delete(:app_id) if options && options.has_key?(:app_id)
        @admins = options.delete(:admins) if options && options.has_key?(:admins)
      end
      
      def app_id
        output = @app_id ? tag(:meta, :property => 'fb:app_id', :content => @app_id) : ""
        output << '\n' unless output.blank?
        output
      end
      
      def admins
        output = @admins ? tag(:meta, :property => 'fb:admins', :content => [*@admins].join(',')) : ""
        output << '\n' unless output.blank?
        output
      end
      
      def render_graph_data
        output = ""
        @graph_data.each_pair do |key, value|
          output << tag(:meta, :property => "og:#{key}", :content => value)
          output << '\n' if @graph_data.size > 1
        end
        output
      end
      
      def type(t)
        @graph_data ||= {}
        @graph_data[:type] = t
      end
      
      def has_graph_data?
        @graph_data
      end
      
      def method_missing(method, *args, &block) #:nodoc
        @graph_data ||= {}
        @graph_data[method] = args.shift
      end
      
    end
    
    def opengraph(options=nil, &block)
      if options.kind_of? Hash
        @tophat_open_graph_defaults = options
      end
      if block_given?
        @tophat_open_graph_generator = OpenGraphGenerator.new(@tophat_open_graph_defaults)
        yield(@tophat_open_graph_generator)
      else
        @tophat_open_graph_generator ||= OpenGraphGenerator.new
        @tophat_open_graph_generator.merge(@tophat_open_graph_defaults)
        output = ""
        output << @tophat_open_graph_generator.app_id
        output << @tophat_open_graph_generator.admins
        output << @tophat_open_graph_generator.render_graph_data if @tophat_open_graph_generator.has_graph_data?
        output
      end
    end
    
  end
end
                