class CreateGenre < ActiveRecord::Migration
  def up
    create_table :genres do |t|
      t.string :category
      t.timestamps
    end
  end

  def down
    drop_table :genres
  end
end
