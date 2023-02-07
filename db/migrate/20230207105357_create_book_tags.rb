class CreateBookTags < ActiveRecord::Migration[6.1]
  def change
    create_table :book_tags do |t|
      t.references :book, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
    add_index :book_tags, [:book_id, :tag_id], unique: true
  end
end
