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

    def html_with_opengraph
      '<html xmlns="http://www.w3.org/1999/xhtml"
            xmlns:og="http://ogp.me/ns#"
            xmlns:fb="https://www.facebook.com/2008/fbml">'
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