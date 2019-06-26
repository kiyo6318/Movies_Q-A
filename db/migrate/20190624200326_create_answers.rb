class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :content,null: false
      t.boolean :best_answer,null: false,default: false
      t.integer :answerer_id
      t.references :question, foreign_key: true

      t.timestamps
    end
    add_index :answers,:answerer_id
  end
end
