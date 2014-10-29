unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter '.bundle'
    add_group 'TopHat', 'lib/tophat'
    add_group 'Specs', 'spec'
  end
end

require 'tophat'
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

def capture_warning
  begin
    old_stderr = $stderr
    $stderr = StringIO.new
    yield
    result = $stderr.string
  ensure
    $stderr = old_stderr
  end
  result
end
