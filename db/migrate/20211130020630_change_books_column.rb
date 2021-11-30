class ChangeBooksColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :books, :pulisher_id, :publisher_id
  end
end
