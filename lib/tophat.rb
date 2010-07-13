require 'action_view'
require 'tophat/version'
require 'tophat/core_extensions'
require 'tophat/title'
require 'tophat/meta'
require 'tophat/stylesheet'
require 'tophat/robots'

Hash.send :include, TopHat::HashOnly unless Hash.instance_methods.include?("only")

module TopHat
  autoload :TitleHelper,      'tophat/title'
  autoload :MetaHelper,       'tophat/meta'
  autoload :StylesheetHelper, 'tophat/stylesheet'
  autoload :RobotsHelper,     'tophat/robots'
end

ActionView::Base.send :include, TopHat::TitleHelper
ActionView::Base.send :include, TopHat::MetaHelper
ActionView::Base.send :include, TopHat::StylesheetHelper
ActionView::Base.send :include, TopHat::RobotsHelper
