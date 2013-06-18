class AddCoverageToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :coverage, :json
  end
end
