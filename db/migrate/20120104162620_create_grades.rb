class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :user_id
      t.integer :survey_id
      t.integer :mark
      t.float :percentage
      t.integer :questions
      t.integer :right

      t.timestamps
    end
  end
end
