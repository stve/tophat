require 'rubygems'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'tophat'

require 'rails/all'
require 'shoulda'
require 'rails/test_help'
require 'rails/generators'