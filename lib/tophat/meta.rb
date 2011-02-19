module TopHat
  module MetaHelper

    # page descriptions
    # <meta name="description" content="Description goes here." />
    def description(options={})
      if options.is_a? String
        @tophat_description = options

      else
        options[:name] = 'description'

        if @tophat_description.blank?
          options.merge!(:content => options.delete(:default))

        else
          options.merge!(:content => @tophat_description)
        end

        tag(:meta, options) if options[:content]
      end
    end

    # keywords
    # <meta name="keywords" content="Keywords go here." />
    def keywords(options={})
      if options.is_a?(String)
        @tophat_keywords = options

      elsif options.is_a?(Array)
        @tophat_keywords = options.join(', ')

      else
        options[:name] = 'keywords'
        default_keywords = options.delete(:default) || []
        display_keywords = @tophat_keywords.blank? ? default_keywords : @tophat_keywords

        # normalize the keywords
        default_keywords = default_keywords.is_a?(String) ? default_keywords.split(',') : default_keywords
        display_keywords = display_keywords.is_a?(String) ? display_keywords.split(',') : display_keywords

        # merge keyword arrays if merge is set to true
        display_keywords += default_keywords if options.delete(:merge_default) == true

        options.merge!(:content => display_keywords.uniq.join(', ').squeeze(' '))
        tag(:meta, options) if display_keywords.any?
      end
    end
  end
end