class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.string :content
      t.boolean :checked # on creating meanings true answer

      t.timestamps
    end
  end
end
