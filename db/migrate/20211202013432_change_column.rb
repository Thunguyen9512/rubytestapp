class ChangeColumn < ActiveRecord::Migration[6.1]
  def change
    change_column :books, :author_id, :integer
    change_column :books, :publisher_id, :integer
    change_column :books, :category_id, :integer

    change_column :order_books, :book_id, :integer
    change_column :order_books, :order_id, :integer

    change_column :orders, :staff_id, :integer
    change_column :orders, :reader_id, :integer
  end
end
