class CreateSuts < ActiveRecord::Migration
  def change
    create_table :suts do |t|
      t.text :metamodel
      t.text :transformation

      t.timestamps
    end
  end
end
