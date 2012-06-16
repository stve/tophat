require 'action_view'

module TopHat
  extend self

  def current
    return Thread.current[:tophat] if Thread.current[:tophat]

    reset
  end

  def reset
    Thread.current[:tophat] = {}
  end

end

require 'tophat/html'
require 'tophat/title'
require 'tophat/meta'
require 'tophat/stylesheet'
require 'tophat/robots'
require 'tophat/opengraph'




