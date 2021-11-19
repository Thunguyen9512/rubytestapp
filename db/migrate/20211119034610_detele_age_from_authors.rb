class DeteleAgeFromAuthors < ActiveRecord::Migration[6.1]
  def up
      remove_column :authors, :age
  end

  def down
    
  end
end
