require 'rails/generators/base'

module ConveyUser
    MissingORMError = Class.new(Thor::Error)

    class SetupGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Convey initializer and copy locale files to your application."

      hook_for :orm do |instance, controller|
        instance.invoke controller, [ "User" ]
      end

      class_option :routes, desc: "Generate routes", type: :boolean, default: true

      def copy_initializer
        template "convey.rb", "config/initializers/convey.rb"
      end

      def rails_4?
        Rails::VERSION::MAJOR == 4
      end
    end
end
