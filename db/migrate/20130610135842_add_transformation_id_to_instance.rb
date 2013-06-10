class AddTransformationIdToInstance < ActiveRecord::Migration
  def change
    add_column :instances, :transformation_id, :integer
  end
end
