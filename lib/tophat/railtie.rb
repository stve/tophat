require 'tophat'
require 'tophat/reset'
require 'rails'

module TopHat
  class Railtie < Rails::Railtie

    initializer "tophat.view_helpers" do |app|
      TopHat.setup
    end

    # Clear the identity map after each request
    initializer "tophat.reset" do |app|
      ActiveSupport.on_load(:action_controller) do
        include(TopHat::Reset)
      end
    end

  end
end