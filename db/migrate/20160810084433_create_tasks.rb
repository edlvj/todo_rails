class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :status
      t.integer :project_id, index: true

      t.timestamps null: false
    end
  end
end
