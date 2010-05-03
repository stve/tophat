module TopHat
  module MetaHelper

    def meta_tag(options)
      # tag :meta, :name => options[:name], :content => options[:content]    
      "<meta name=\"#{options[:name]}\" content=\"#{options[:content]}\" />"
    end

    # page descriptions
    # <meta name="description" content="Description goes here." />
    def description(options=nil)
      if options.is_a? String
        @tophat_description = options
        
      else
        options ||= {}
        options.merge!(:name => 'description')

        if @tophat_description.blank?
          options.merge!(:content => options.delete(:default))
          
        else
          options.merge!(:content => @tophat_description) 
        end

        meta_tag(options) if options[:content]
      end    
    end

    # keywords
    # <meta name="keywords" content="Keywords go here." />
    def keywords(options=nil)        
      if options.is_a?(String)
        @tophat_keywords = options
        
      elsif options.is_a?(Array)
        @tophat_keywods = options.join(', ')
        
      else
        options ||= {}
        options.merge!(:name => 'keywords')

        if @tophat_keywords.blank?
          keywords = options.delete(:default)
          
          if keywords && keywords.is_a?(Array)
            keywords = keywords.join(', ')
          end
          
          options.merge!(:content => keywords)
          
        else
          options.merge!(:content => @tophat_keywords) 
        end

        meta_tag(options) if options[:content]
      end    
    end
  end
end