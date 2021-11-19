class DeteleNameFromAuthors < ActiveRecord::Migration[6.1]
  def up
    remove_column :authors, :name
  end

  def down
  
  end
end
