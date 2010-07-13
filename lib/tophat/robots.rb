module TopHat
  module RobotsHelper

    def noindex(descriptor='robots')
      tag(:meta, :name => descriptor, :content => 'noindex')
    end
    
    def nofollow(descriptor='robots')
      tag(:meta, :name => descriptor, :content => 'nofollow')
    end
    
    def canonical(path=nil)
      if path
        tag(:link, :rel => 'canonical', :href => path)
      end
    end
    
  end
end