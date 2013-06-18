class AddAttributesToTransformation < ActiveRecord::Migration
  def change
    add_column :transformations, :code, :text
    add_column :transformations, :source_metamodel, :text
    add_column :transformations, :target_metamodel, :text
  end
end
