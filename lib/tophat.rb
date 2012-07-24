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
    ActionView::Base.send :include, TopHat::HtmlHelper
    ActionView::Base.send :include, TopHat::TitleHelper
    ActionView::Base.send :include, TopHat::MetaHelper
    ActionView::Base.send :include, TopHat::StylesheetHelper
    ActionView::Base.send :include, TopHat::RobotsHelper
    ActionView::Base.send :include, TopHat::OpenGraphHelper
    ActionView::Base.send :include, TopHat::TwitterCardHelper
  end

end
