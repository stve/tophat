module TopHat
  module HtmlHelper

    def html_tag(options={})
      output = '<html'
      if options[:version]
        output << " version=\"#{options[:version]}\""
      end
      if options[:xmlns]
        if options[:xmlns].kind_of?(String)
          output << " xmlns=\"#{options[:xmlns]}\""
        elsif options[:xmlns].kind_of?(Array)
          output = options[:xmlns].inject(output) do |html, xmlns|
            if xmlns.kind_of?(Hash)
              html << " xmlns:#{xmlns[:prefix]}=\"#{xmlns[:url]}\""
            else
              html << " xmlns=\"#{xmlns}\""
            end
          end
        end
      end
      output << '>'
    end

  end
end

ActionView::Base.send :include, TopHat::HtmlHelper