require 'simplecov'
SimpleCov.start do
  add_group 'TopHat', 'lib/tophat'
  add_group 'Specs', 'spec'
end

require File.expand_path('../../lib/tophat', __FILE__)

require 'rspec'