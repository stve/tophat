module TopHat
  module HtmlHelper

    def html_tag(options={})
      if options[:xmlns] && options[:xmlns].kind_of?(Array)
        options.delete(:xmlns).each do |xmlns|
          if xmlns.kind_of?(Hash)
            options["xmlns:#{xmlns[:prefix]}"] = xmlns[:url]
          else
            options['xmlns'] = xmlns
          end
        end
      end

      if options[:prefix]
        if options[:prefix].kind_of?(Hash)
          prefix_options = options.delete(:prefix)
          options['prefix'] = "#{prefix_options[:prefix]}: #{prefix_options[:url]}"
        elsif options[:prefix].kind_of?(Array)
          prefixes = []
          options.delete(:prefix).each do |prefix|
            if prefix.kind_of?(Hash)
              prefixes << "#{prefix[:prefix]}: #{prefix[:url]}"
            else
              prefixes << prefix
            end
          end

          options['prefix'] = prefixes.join(' ')
        end
      end

      tag(:html, options, true)
    end

  end
end
