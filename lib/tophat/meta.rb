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

    def itemprop(name, value)
      meta_tag(:itemprop => name, :content => value)
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
        options[:content] = TopHat.current['description'].blank? ? default_description : TopHat.current['description']

        meta_tag(options) if options[:content]
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
        options[:name] = 'keywords'
        default_keywords = options.delete(:default) || []
        display_keywords = TopHat.current['keywords'].blank? ? default_keywords : TopHat.current['keywords']

        # normalize the keywords
        default_keywords = default_keywords.is_a?(String) ? default_keywords.split(',') : default_keywords
        display_keywords = display_keywords.is_a?(String) ? display_keywords.split(',') : display_keywords

        # merge keyword arrays if merge is set to true
        display_keywords += default_keywords if options.delete(:merge_default) == true

        options.merge!(:content => display_keywords.uniq.join(', ').squeeze(' '))
        meta_tag(options) if display_keywords.any?
      end
    end
  end
end
