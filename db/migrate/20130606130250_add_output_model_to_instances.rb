class AddOutputModelToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :output_model, :text
  end
end
