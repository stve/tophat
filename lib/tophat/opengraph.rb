module TopHat
  module OpenGraphHelper

    class OpenGraphGenerator
      include ActionView::Helpers

      def initialize(options={})
        TopHat.current['app_id'] = options.delete(:app_id) if options && options.has_key?(:app_id)
        TopHat.current['admins'] = options.delete(:admins) if options && options.has_key?(:admins)
        TopHat.current['graph_data'] = {}
      end

      def merge(options={})
        TopHat.current['app_id'] = options.delete(:app_id) if options && options.has_key?(:app_id)
        TopHat.current['admins'] = options.delete(:admins) if options && options.has_key?(:admins)
      end

      def app_id
        output = TopHat.current['app_id'] ? tag(:meta, :property => 'fb:app_id', :content => TopHat.current['app_id']) : ""
        output << '\n' unless output.blank?
        output
      end

      def admins
        output = TopHat.current['admins'] ? tag(:meta, :property => 'fb:admins', :content => [*TopHat.current['admins']].join(',')) : ""
        output << '\n' unless output.blank?
        output
      end

      def render_graph_data
        output = ""
        TopHat.current['graph_data'].each_pair do |key, value|
          output << tag(:meta, :property => "og:#{key}", :content => value)
          output << '\n' if TopHat.current['graph_data'].size > 1
        end
        output
      end

      def type(t)
        TopHat.current['graph_data'] ||= {}
        TopHat.current['graph_data'][:type] = t
      end

      def has_graph_data?
        TopHat.current['graph_data']
      end

      def method_missing(method, *args, &block) #:nodoc
        TopHat.current['graph_data'] ||= {}
        TopHat.current['graph_data'][method] = args.shift
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
      if options.kind_of? Hash
        TopHat.current['open_graph_defaults'] = options
      end
      if block_given?
        TopHat.current['open_graph_generator'] = OpenGraphGenerator.new(TopHat.current['open_graph_defaults'])
        yield(TopHat.current['open_graph_generator'])
      else
        TopHat.current['open_graph_generator'] ||= OpenGraphGenerator.new
        TopHat.current['open_graph_generator'].merge(TopHat.current['open_graph_defaults'])
        output = ""
        output << TopHat.current['open_graph_generator'].app_id
        output << TopHat.current['open_graph_generator'].admins
        output << TopHat.current['open_graph_generator'].render_graph_data if TopHat.current['open_graph_generator'].has_graph_data?
        output
      end
    end

  end
end

ActionView::Base.send :include, TopHat::OpenGraphHelper