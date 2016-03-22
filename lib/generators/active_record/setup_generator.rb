require 'rails/generators/active_record'
require 'generators/convey_user/orm_helpers'

module ActiveRecord
    class SetupGenerator < ActiveRecord::Generators::Base
      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      include ConveyUser::Generators::OrmHelpers
      source_root File.expand_path("../templates", __FILE__)

      def copy_conveyuser_migration
        if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?([name]))
          migration_template "migration_existing.rb", "db/migrate/add_convey_to_users.rb"
        else
          migration_template "migration.rb", "db/migrate/convey_create_users.rb"
        end
      end

      def generate_model
        invoke "active_record:model", [name], migration: false unless model_exists? && behavior == :invoke
      end

      def inject_convey_content
        content = model_contents

        class_path = if namespaced?
          class_name.to_s.split("::")
        else
          [class_name]
        end

        indent_depth = class_path.size - 1
        content = content.split("\n").map { |line| "  " * indent_depth + line } .join("\n") << "\n"

        inject_into_class(model_path, class_path.last, content) if model_exists?
      end

      def migration_data
<<RUBY
      t.boolean :active,            null: false, default: true
      t.string  :email,             null: false, default: ""
      t.integer :uid,               null: false
      t.string :first_name,         null: false, default: ''
      t.string :last_name,          null: false, default: ''
      t.integer :gender,            null: false, default: 0
      t.datetime :birthday
      t.string :email_work,         default: ''
      t.string :email_personal,     default: ''
      t.string :phone_personal,     default: ''
      t.string :phone_work,         default: ''
      t.string :address_line_one,   default: ''
      t.string :address_line_two,   default: ''
      t.string :address_city,       default: ''
      t.string :address_state,      default: ''
      t.string :address_zipcode,    default: ''
      t.integer :employment_status, null: false, default: 0
      t.datetime :hire_date
      t.integer :pay_type,          null: false, default: 0
      t.string :pay_rate,           default: ''
      t.string :job_title,          default: ''
      t.integer :reports_to
      t.string :department,         default: ''
      t.string :location,           default: ''
RUBY
      end

      def ip_column
        # Padded with spaces so it aligns nicely with the rest of the columns.
        "%-8s" % (inet? ? "inet" : "string")
      end

      def inet?
        postgresql?
      end

      def rails5?
        Rails.version.start_with? '5'
      end

      def postgresql?
        config = ActiveRecord::Base.configurations[Rails.env]
        config && config['adapter'] == 'postgresql'
      end
    end
end
