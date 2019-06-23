class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title,null: false
      t.text :details,null: false
      t.integer :status,null: false,default: 0
      t.integer :questioner_id

      t.timestamps
    end
    add_index :questions,:questioner_id
  end
end
