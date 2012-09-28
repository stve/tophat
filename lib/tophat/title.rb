module TopHat
  module TitleHelper

    DEFAULT_PREFIX = ' '.freeze unless defined?(DEFAULT_PREFIX)
    DEFAULT_SUFFIX = ' '.freeze unless defined?(DEFAULT_SUFFIX)
    DEFAULT_SEPARATOR = ''.freeze unless defined?(DEFAULT_SEPARATOR)

    def title(title=nil, options={})
      if title.is_a?(String) || title.is_a?(Array)
        save_tophat_title(title, options)
      else
        display_tophat_title(title || options)
      end
    end

    private

    def save_tophat_title(title, options)
      TopHat.current['title'] = title
      TopHat.current['title_options'] = options
      title
    end

    def display_tophat_title(options)
      options = options.merge(TopHat.current['title_options']) unless TopHat.current['title_options'].nil?

      title_segments = []
      title_segments << options[:site] if options[:site]
      title_segments << (TopHat.current['title'].blank? ? options[:default] : TopHat.current['title'])

      title_segments.flatten! # flatten out in case the title is an array
      title_segments.compact! # clean out any nils
      title_segments.map! { |t| strip_tags(t) }

      reverse = options[:reverse]
      reverse = false if options[:default] && TopHat.current['title'].blank? && options[:reverse_on_default] == false

      title_segments.reverse! if reverse

      title_text = title_segments.join(delimiter_from(options))
      title_text.downcase! if options[:lowercase]
      title_text.upcase! if options[:uppercase]

      content_tag :title, title_text.strip
    end

    def delimiter_from(options={})
      return "" if options.empty?

      # Prefix (leading space)
      prefix = if options[:prefix]
        options[:prefix]
      elsif options[:prefix] == false
        ''
      end
      prefix ||= DEFAULT_PREFIX

      # Separator
      separator = options[:separator] || DEFAULT_SEPARATOR

      # Suffix (trailing space)
      suffix = if options[:suffix]
        options[:suffix]
      elsif options[:suffix] == false
        ''
      end
      suffix ||= DEFAULT_SUFFIX

      prefix + separator + suffix
    end

  end
end
