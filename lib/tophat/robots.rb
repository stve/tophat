module TopHat
  module RobotsHelper

    DEFAULT_DESCRIPTOR = 'robots'

    def noindex(descriptor = nil, content = 'noindex')
      robot_tag(descriptor, content)
    end

    def nofollow(descriptor = nil, content = 'nofollow')
      robot_tag(descriptor, content)
    end

    def robot_tag(descriptor = nil, content)
      if descriptor
        TopHat.current[content] = descriptor || DEFAULT_DESCRIPTOR
      else
        descriptor = TopHat.current[content] || DEFAULT_DESCRIPTOR
      end
      tag(:meta, :name => descriptor, :content => content)
    end

    def canonical(path = nil)
      tag(:link, :rel => 'canonical', :href => path) if path
    end

  end
end
