module TopHat
  module StylesheetHelper

    def ie_5_conditional(operator = nil, &block)
      ie_conditional(5, operator, &block)
    end

    def ie_5_5_conditional(operator = nil, &block)
      ie_conditional(5.5, operator, &block)
    end

    def ie_6_conditional(operator = nil, &block)
      ie_conditional(6, operator, &block)
    end

    def ie_7_conditional(operator = nil, &block)
      ie_conditional(7, operator, &block)
    end

    def ie_8_conditional(operator = nil, &block)
      ie_conditional(8, operator, &block)
    end

    def ie_9_conditional(operator = nil, &block)
      ie_conditional(9, operator, &block)
    end

    def ie_conditional(version = nil, operator = nil, &block)
      browser_conditional('IE', version, operator, &block)
    end

    def gecko_conditional(operator = nil, &block)
      browser_conditional('Gecko', nil, operator, &block)
    end

    def webkit_conditional(operator = nil, &block)
      browser_conditional('Webkit', nil, operator, &block)
    end

    def mobile_safari_conditional(operator = nil, &block)
      browser_conditional('SafMob', nil, operator, &block)
    end

    def opera_conditional(operator = nil, &block)
      browser_conditional('Opera', nil, operator, &block)
    end

    def ie_mac_conditional(operator = nil, &block)
      browser_conditional('IEMac', nil, operator, &block)
    end

    def konqueror_conditional(operator = nil, &block)
      browser_conditional('Konq', nil, operator, &block)
    end

    def ie_mobile_conditional(operator = nil, &block)
      browser_conditional('IEmob', nil, operator, &block)
    end

    def psp_conditional(operator = nil, &block)
      browser_conditional('PSP', nil, operator, &block)
    end

    def net_front_conditional(operator = nil, &block)
      browser_conditional('NetF', nil, operator, &block)
    end

    private

    def browser_conditional(browser, version = nil, operator = nil, &block)
      unless operator.blank?
        operator = operator.to_s
        operator = '!' if operator == 'not'
        operator << " " unless operator == '!'
      end

      browser_version = version.blank? ? "" : " #{version}"

      output = ActiveSupport::SafeBuffer.new("<!--[if #{operator}#{browser}#{browser_version}]>")
      output << "\n".html_safe
      output << yield if block_given?
      output << "\n".html_safe
      output << "<![endif]-->".html_safe
    end

  end
end
