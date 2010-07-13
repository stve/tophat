module TopHat
  module RobotsHelper

    def noindex(descriptor='robots')
      meta_tag(:name => descriptor, :content => 'noindex')
    end
    
    def nofollow(descriptor='robots')
      meta_tag(:name => descriptor, :content => 'nofollow')
    end
    
    def canonical(path=nil)
      if path
        '<link rel="canonical" href="' + path + '" />'
      end
    end
    
  end
end