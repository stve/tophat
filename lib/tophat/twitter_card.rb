module TopHat
  module TwitterCardHelper

    class TwitterCardGenerator
      include ActionView::Helpers

      attr_reader :card_data

      def initialize(type, &block)
        @type = type
        @card_data = {}

        yield self if block_given?
      end

      def to_html
        output = ActiveSupport::SafeBuffer.new
        output << tag(:meta, :name => 'twitter:card', :value => @type)
        @card_data = @card_data.delete_if { |k, v| v.nil? }
        @card_data.each do |key, value|
          tag_name = "twitter:#{key}".squeeze(":")
          output << "\n".html_safe
          output << tag(:meta, :name => tag_name, :value => value)
        end
        output << "\n".html_safe unless @card_data.empty?
        output
      end
      alias render to_html

      def add_nested_attributes(method, &block)
        image_generator = TwitterCardGenerator.new(method, &block)
        image_generator.card_data.each do |key, value|
          @card_data["#{method}:#{key}"] = value
        end
      end

      def method_missing(method, *args, &block) #:nodoc
        @card_data ||= {}
        @card_data[method] = args.shift
        add_nested_attributes(method, &block) if block_given?
      end
    end

    def twitter_card(type=nil, &block)
      if TopHat.current['twitter_card'].nil?
        TopHat.current['twitter_card'] = TwitterCardGenerator.new(type, &block)
      else
        TopHat.current['twitter_card'].add_nested_attributes('', &block)
      end
      TopHat.current['twitter_card'].to_html
    end
  end
end
