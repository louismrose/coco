class AddSourceModelNameAndTargetModelNameToTransformation < ActiveRecord::Migration
  def change
    add_column :transformations, :source_model_name, :string
    add_column :transformations, :target_model_name, :string
  end
end
