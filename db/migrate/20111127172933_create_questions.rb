class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :survey_id
      t.string :content
      t.boolean :type # Radio (false) or checkbox (true)

      t.timestamps
    end
  end
end
