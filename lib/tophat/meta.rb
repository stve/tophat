module TopHat
  module MetaHelper

    # Meta Tag helper
    def meta_tag(options, open=false, escape=true)
      tag(:meta, options, open, escape)
    end

    def charset(charset, options={})
      meta_tag(options.merge(:charset => charset), true)
    end

    def viewport(viewport, options={})
      meta_tag(options.merge(:name => 'viewport', :content => viewport), true)
    end

    # page descriptions
    # <meta name="description" content="Description goes here." />
    def description(options={})
      options ||= {}
      if options.is_a? String
        TopHat.current['description'] = options

      else
        default_description = options.delete(:default)
        options[:name] = 'description'
        options[:content] = TopHat.current['description'] || default_description

        meta_tag(options) if options[:content]
      end
    end

    class Keywords
      def initialize(keywords, options={})
        @options = options
        @keywords = keywords || default_keywords
      end

      def to_s
        wordlist.uniq.join(', ').squeeze(' ')
      end

      def any?
        wordlist.size > 0
      end

      private

      def regular_keywords
        @regulars ||= @keywords.blank? ? default_keywords : @keywords
      end

      def default_keywords
        @defaults ||= @options.delete(:default) || []
      end

      def wordlist
        @words ||= [].tap do |list|
          list.concat(normalize(regular_keywords))
          list.concat(normalize(default_keywords)) if @options[:merge_default] == true
        end
      end

      def normalize(list)
        case list
        when String then list.split(',')
        else list
        end
      end
    end

    # keywords
    # <meta name="keywords" content="Keywords go here." />
    def keywords(options={})
      options ||= {}
      if options.is_a?(String)
        TopHat.current['keywords'] = options

      elsif options.is_a?(Array)
        TopHat.current['keywords'] = options.join(', ')

      else
        # options[:name] = 'keywords'
        # default_keywords = options.delete(:default) || []
        # display_keywords = TopHat.current['keywords'].blank? ? default_keywords : TopHat.current['keywords']

        # # normalize the keywords
        # default_keywords = default_keywords.is_a?(String) ? default_keywords.split(',') : default_keywords
        # display_keywords = display_keywords.is_a?(String) ? display_keywords.split(',') : display_keywords

        # # merge keyword arrays if merge is set to true
        # display_keywords += default_keywords if options.delete(:merge_default) == true

        # options.merge!(:content => display_keywords.uniq.join(', ').squeeze(' '))
        # meta_tag(options) if display_keywords.any?

        words = Keywords.new(TopHat.current['keywords'], options)
        meta_tag(:name => 'keywords', :content => words.to_s) if words.any?
      end
    end
  end
end
