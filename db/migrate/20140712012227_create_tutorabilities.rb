class CreateTutorabilities < ActiveRecord::Migration
  def change
    create_table :tutorabilities do |t|
      t.integer :user_id
      t.string :class_name
      t.integer :ability

      t.timestamps
    end
  end
end
