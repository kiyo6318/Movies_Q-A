class AddBestAnswersCountToUsers < ActiveRecord::Migration[5.2]
  def self.up
    add_column :users, :best_answers_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :users, :best_answers_count
  end
end
