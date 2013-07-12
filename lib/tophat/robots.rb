module TopHat
  module RobotsHelper

    DEFAULT_DESCRIPTOR = 'robots'

    def noindex(descriptor=nil)
      if descriptor
        TopHat.current['noindex'] = descriptor || DEFAULT_DESCRIPTOR
      else
        descriptor = TopHat.current['noindex'] || DEFAULT_DESCRIPTOR
      end
      tag(:meta, :name => descriptor, :content => 'noindex')
    end

    def nofollow(descriptor=nil)
      if descriptor
        TopHat.current['nofollow'] = descriptor || DEFAULT_DESCRIPTOR
      else
        descriptor = TopHat.current['nofollow'] || DEFAULT_DESCRIPTOR
      end
      tag(:meta, :name => descriptor, :content => 'nofollow')
    end

    def canonical(path=nil)
      tag(:link, :rel => 'canonical', :href => path) if path
    end

  end
end
