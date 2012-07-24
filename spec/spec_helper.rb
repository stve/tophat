require 'simplecov'
SimpleCov.start do
  add_group 'TopHat', 'lib/tophat'
  add_group 'Specs', 'spec'
end

require File.expand_path('../../lib/tophat', __FILE__)

require 'rspec'
require 'rails/all'


RSpec.configure do |config|
  config.before(:suite) do
    TopHat.setup
  end

  config.after(:each) do
    TopHat.reset
  end
end

require 'action_controller/vendor/html-scanner'

module HTML
  class Node
    def ==(node)
      return false unless self.class == node.class && children.size == node.children.size

      equivalent = true

      children.size.times do |i|
        equivalent &&= children.include?(node.children[i])
      end

      equivalent
    end
  end
end

RSpec::Matchers.define :be_dom_equivalent_to do |expected|
  match do |actual|
    expected_dom = HTML::Document.new(expected).root
    actual_dom   = HTML::Document.new(actual).root

    expected_dom == actual_dom
  end

  failure_message_for_should do |actual|
    "expected #{actual} would be dom equivalent to #{expected}"
  end

end

