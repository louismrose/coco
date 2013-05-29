class CreateInstances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.text :input_model

      t.timestamps
    end
  end
end