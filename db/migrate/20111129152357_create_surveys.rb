class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :group_id
      t.integer :subject_id
      t.string :title
      t.text :descryption

      t.timestamps
    end
  end
end
