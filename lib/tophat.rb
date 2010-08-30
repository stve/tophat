require 'action_view'
require 'tophat/title'
require 'tophat/meta'
require 'tophat/stylesheet'
require 'tophat/robots'

module TopHat
  autoload :TitleHelper,      'tophat/title'
  autoload :MetaHelper,       'tophat/meta'
  autoload :StylesheetHelper, 'tophat/stylesheet'
  autoload :RobotsHelper,     'tophat/robots'
  autoload :OpenGraphHelper,  'tophat/opengraph'
end

ActionView::Base.send :include, TopHat::TitleHelper
ActionView::Base.send :include, TopHat::MetaHelper
ActionView::Base.send :include, TopHat::StylesheetHelper
ActionView::Base.send :include, TopHat::RobotsHelper
ActionView::Base.send :include, TopHat::OpenGraphHelper
