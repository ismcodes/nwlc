class CreateTutoringsessions < ActiveRecord::Migration
  def change
    create_table :tutoringsessions do |t|
      t.integer :user_id
      t.integer :tutor_id
      t.boolean :finished
      t.string :classname
      t.string :topic
      t.string :materials
      t.string :discussion
      t.string :followup

      t.timestamps
    end
  end
end
