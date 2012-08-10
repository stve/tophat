module TopHat
  module Reset

    def self.included(base)
      base.append_before_filter :reset_tophat
    end

    def reset_tophat
      TopHat.reset
    end

  end
end