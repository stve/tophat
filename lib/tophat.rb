require 'action_view'
require 'tophat/html'
require 'tophat/title'
require 'tophat/meta'
require 'tophat/stylesheet'
require 'tophat/robots'
require 'tophat/opengraph'
require 'tophat/twitter_card'

module TopHat
  extend self

  require "tophat/railtie" if defined?(::Rails)

  def current
    Thread.current[:tophat] ||= {}
  end

  def reset
    Thread.current[:tophat] = {}
  end

  def setup
    ActiveSupport.on_load(:action_view) do
      include TopHat::HtmlHelper
      include TopHat::TitleHelper
      include TopHat::MetaHelper
      include TopHat::StylesheetHelper
      include TopHat::RobotsHelper
      include TopHat::OpenGraphHelper
      include TopHat::TwitterCardHelper
    end
  end
end
