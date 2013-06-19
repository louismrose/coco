class AddErrorToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :error, :text
  end
end
