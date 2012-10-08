class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :category_id
      t.integer :group_id
      t.integer :subject_id
      t.string :title
      t.text :descryption
      t.integer :type
      t.string :file

      t.timestamps
    end
  end
end
