class RemoveUsreIdFromBookComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :book_comments, :usre_id, :integer
  end
end
