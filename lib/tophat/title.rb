module TopHat
  module TitleHelpers
    
    def title(title, options={})
      if title.is_a? String 
        save_title(title, options)
      else
        display_title(title)
      end
    end

    def save_title(title, options)
      @tophat_title = title.gsub(/<\/?[^>]*>/, '')
      @tophat_title_options = options
      title
    end

    def display_title(options)
      options = options.merge(@tophat_title_options) unless @tophat_title_options.nil? || @tophat_title_options.empty?

      # Prefix (leading space)
      if options[:prefix]
        prefix = options[:prefix]
      elsif options[:prefix] == false
        prefix = ''
      else
        prefix = ' '
      end

      # Separator
      unless options[:separator].blank?
        separator = options[:separator]
      else
        separator = '|'
      end

      # Suffix (trailing space)
      if options[:suffix]
        suffix = options[:suffix]
      elsif options[:suffix] == false
        suffix = ''
      else
        suffix = ' '
      end
      
      site_name = options[:site]

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
      unless @tophat_title.blank?
        if @tophat_reverse == true
          # Reverse order => "Page : Website"
          return content_tag(:title, @tophat_title + prefix + separator + suffix + site_name)
        else
          # Standard order => "Website : Page"
          return content_tag(:title, site_name + prefix + separator + suffix + @tophat_title)
        end
      end

      # If title is blank, return only website name
      content_tag :title, site_name if options[:site]
    end
    alias t title
    
  end
end