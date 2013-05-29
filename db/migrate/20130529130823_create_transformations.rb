class CreateTransformations < ActiveRecord::Migration
  def change
    create_table :transformations do |t|
      t.timestamps
    end
  end
end
