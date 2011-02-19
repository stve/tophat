require 'rubygems'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'tophat'

require 'rails/all'
require 'shoulda'

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

def assert_dom_equal(expected, actual, message = "")
  expected_dom = HTML::Document.new(expected).root
  actual_dom   = HTML::Document.new(actual).root
  full_message = build_message(message, "<?> expected to be == to\n<?>.", expected_dom.to_s, actual_dom.to_s)

  assert_block(full_message) { expected_dom == actual_dom }
end