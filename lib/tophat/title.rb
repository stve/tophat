module TopHat
  module TitleHelper

    def title(title=nil, options={})
      if title.is_a? String
        save_tophat_title(title, options)
      else
        display_tophat_title(title)
      end
    end

    private

    def save_tophat_title(title, options)
      @tophat_title = title.gsub(/<\/?[^>]*>/, '')
      @tophat_title_options = options
      title
    end

    def display_tophat_title(options={})
      options ||= {}
      options = options.merge(@tophat_title_options) unless @tophat_title_options.nil?

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

      # site name
      site_name = options[:site] || ''

      # Lowercase title?
      if options[:lowercase] == true
        @tophat_title.downcase! unless @tophat_title.blank?
        site_name.downcase! unless site_name.blank?
      end

      # Default page title
      if @tophat_title.blank? && options[:default]
        @tophat_title = options[:default]
        @tophat_title_defaulted = true
      end

      # figure out reversing
      if options[:reverse] == true
        if @tophat_title_defaulted
          @tophat_reserve = options[:reverse_on_default] != false
        else
          @tophat_reverse = true
        end
      else
        @tophat_reverse = false
      end

      # Set website/page order
      if @tophat_title.blank?
        # If title is blank, return only website name
        content_tag :title, site_name if options[:site]
      else
        display_title = if @tophat_reverse == true
          # Reverse order => "Page : Website"
          @tophat_title + prefix + separator + suffix + site_name
        else
          # Standard order => "Website : Page"
          site_name + prefix + separator + suffix + @tophat_title
        end

        return content_tag(:title, display_title.strip)
      end



    end
    alias t title

  end
end