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

      def render
        output = ActiveSupport::SafeBuffer.new
        output << tag(:meta, :name => 'twitter:card', :value => @type)
        @card_data.each do |key, value|
          output << "\n".html_safe
          output << tag(:meta, :name => "twitter:#{key}", :value => value)
        end
        output << "\n".html_safe unless @card_data.empty?
        output
      end

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
      if type.nil?
        if TopHat.current['twitter_card']
          TopHat.current['twitter_card'].render
        end
      else
        TopHat.current['twitter_card'] = TwitterCardGenerator.new(type, &block)
      end
    end
  end
end
