class AddNameToTransformations < ActiveRecord::Migration
  def change
    add_column :transformations, :name, :string
  end
end
