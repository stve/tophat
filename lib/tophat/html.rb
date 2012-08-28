module TopHat
  module HtmlHelper

    def html_tag(options={})
      opts = options.dup
      opts.merge!(xmlns_options(opts.delete(:xmlns))) if opts[:xmlns]
      opts.merge!(prefix_options(opts.delete(:prefix))) if opts[:prefix]

      tag(:html, opts, true)
    end

    private

    def xmlns_options(xmlns)
      options = {}

      if xmlns.kind_of?(String)
        options['xmlns'] = xmlns
      elsif xmlns.kind_of?(Array)
        options.merge!(xmlns_from_array(xmlns))
      elsif xmlns.kind_of?(Hash)
        options.merge!(xmlns_from_hash(xmlns))
      end

      options
    end

    def xmlns_from_array(xmlns)
      options = {}

      xmlns.each do |x|
        if x.kind_of?(Hash)
          options.merge!(xmlns_from_hash(x))
        else
          options['xmlns'] = x
        end
      end

      options
    end

    def xmlns_from_hash(h)
      { "xmlns:#{h[:prefix]}" => h[:url] }
    end

    def prefix_options(prefix)
      options = {}

      options['prefix'] = case prefix
      when String then prefix
      when Hash then prefix_from_hash(prefix)
      when Array then prefix_from_array(prefix)
      end

      options
    end

    def prefix_from_array(prefixes)
      prefixes.map do |prefix|
        if prefix.kind_of?(Hash)
          prefix_from_hash(prefix)
        else
          prefix
        end
      end.join(' ')
    end

    def prefix_from_hash(h)
      "#{h[:prefix]}: #{h[:url]}"
    end

  end
end
