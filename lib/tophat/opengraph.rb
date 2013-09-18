module TopHat
  module OpenGraphHelper

    class OpenGraphGenerator
      include ActionView::Helpers

      def initialize(options={}, &block)
        @app_id = options.delete(:app_id) if options && options.has_key?(:app_id)
        @admins = options.delete(:admins) if options && options.has_key?(:admins)
        @graph_data = {}

        yield self if block_given?
      end

      def merge(options={}, &block)
        yield self if block_given?

        @app_id = options.delete(:app_id) if options && options.has_key?(:app_id)
        @admins = options.delete(:admins) if options && options.has_key?(:admins)
      end

      def app_id
        tag(:meta, :property => 'fb:app_id', :content => @app_id) + "\n".html_safe
      end

      def admins
        tag(:meta, :property => 'fb:admins', :content => [*@admins].join(',')) + "\n".html_safe
      end

      def graph_data
        output = ActiveSupport::SafeBuffer.new
        @graph_data.each do |key, value|
          output << tag(:meta, :property => "og:#{key}", :content => value)
          output << "\n".html_safe if @graph_data.size > 1
        end
        output
      end

      def type(t)
        @graph_data ||= {}
        @graph_data[:type] = t
      end

      def has_graph_data?
        !!@graph_data
      end

      def method_missing(method, *args, &block) #:nodoc
        @graph_data ||= {}
        @graph_data[method] = args.shift
      end

      def to_html
        output = ActiveSupport::SafeBuffer.new
        output << app_id if defined?(@app_id) && @app_id
        output << admins if defined?(@admins) && @admins
        output << graph_data if has_graph_data?
        output
      end

    end

    HTML4_XMLNS = [
      'http://www.w3.org/1999/xhtml',
      { :prefix => 'og', :url => 'http://ogp.me/ns#' },
      { :prefix => 'fb', :url => 'https://www.facebook.com/2008/fbml' }
    ]

    HTML5_XMLNS = [
      { :prefix => 'og', :url => 'http://opengraphprotocol.org/schema/' },
      { :prefix => 'fb', :url => 'http://developers.facebook.com/schema/' }
    ]

    def html_with_opengraph(style='html4')
      Kernel.warn("html_with_opengraph has been deprecated, use opengraph_html instead.")
      opengraph_html(style)
    end

    def opengraph_html(style='html4')
      if style == 'html4'
        html_tag(:xmlns => HTML4_XMLNS)
      elsif style == 'html5'
        html_tag(:version => 'HTML+RDFa 1.0', :xmlns => HTML5_XMLNS)
      else
        html_tag
      end
    end

    def opengraph(options=nil, &block)
      TopHat.current['open_graph_generator'] ||= OpenGraphGenerator.new(options)
      TopHat.current['open_graph_generator'].merge(options, &block)
      TopHat.current['open_graph_generator'].to_html
    end

  end
end
