require 'action_view'

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
