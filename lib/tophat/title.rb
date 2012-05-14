module TopHat
  module TitleHelper

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
        title_segments.map! { |t| t.downcase! } if options[:lowercase]
        title_segments.map! { |t| t.upcase! } if options[:uppercase]
        title_segments.map! { |t| strip_tags(t) }

        reverse = options[:reverse]
        reverse = false if options[:default] && TopHat.current['title'].blank? && options[:reverse_on_default] == false

        title_segments.reverse! if reverse

        content_tag :title, title_segments.join(delimiter_from(options)).strip
      end
      alias t title

      def delimiter_from(options={})
        return "" if options.empty?

        # Prefix (leading space)
        if options[:prefix]
          prefix = options[:prefix]
        elsif options[:prefix] == false
          prefix = ''
        else
          prefix = ' '
        end

        # Separator
        separator = options[:separator] || ''

        # Suffix (trailing space)
        if options[:suffix]
          suffix = options[:suffix]
        elsif options[:suffix] == false
          suffix = ''
        else
          suffix = ' '
        end

        prefix + separator + suffix
      end
  end
end

ActionView::Base.send :include, TopHat::TitleHelper