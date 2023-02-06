class AddUserIdToBookComment < ActiveRecord::Migration[6.1]
  def change
    add_column :book_comments, :user_id, :integer
  end
end
