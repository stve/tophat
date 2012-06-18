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

      tag(:html, options, true)
    end

  end
end

ActionView::Base.send :include, TopHat::HtmlHelper