require 'rails/generators/named_base'
require 'generators/convey_user/orm_helpers'

module Mongoid
    class SetupGenerator < Rails::Generators::NamedBase
      include Devise::Generators::OrmHelpers

      def generate_model
        invoke "mongoid:model", 'user' unless model_exists? && behavior == :invoke
      end

      def inject_field_types
        inject_into_file model_path, migration_data, after: "include Mongoid::Document\n" if model_exists?
      end

      def inject_devise_content
        inject_into_file model_path, model_contents, after: "include Mongoid::Document\n" if model_exists?
      end

      def migration_data
<<RUBY
  feild :active,             type: Boolean, default: true
  feild :uid,                type: Integer
  field :email,              type: String, default: ""
RUBY
      end
    end
end
