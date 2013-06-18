class AddCoverageToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :coverage, :string
  end
end
