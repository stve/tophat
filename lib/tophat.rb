require 'action_view'
require 'tophat/version'
require 'tophat/core_extensions'
require 'tophat/title'
require 'tophat/meta'
require 'tophat/stylesheet'

Hash.send :include, TopHat::HashOnly unless Hash.instance_methods.include?("only")

ActionView::Base.send :include, TopHat::TitleHelper
ActionView::Base.send :include, TopHat::MetaHelper
ActionView::Base.send :include, TopHat::StylesheetHelper
