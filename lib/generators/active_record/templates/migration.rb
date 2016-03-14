class ConveyCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
<%= migration_data -%>

<% attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>

      t.timestamps null: false
    end

    add_index :users, :email,   unique: true
    add_index :users, :uid,     unique: true
  end
end
