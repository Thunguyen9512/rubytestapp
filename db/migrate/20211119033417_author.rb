class Author < ActiveRecord::Migration[6.1]
  def self.up
    create_table :authors do |t|
      t.integer :age
      t.string :name

      t.timestamps

    end
  end

  def self.down
        drop_table :authors
  end
end