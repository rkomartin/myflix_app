class AddGenreToVideos < ActiveRecord::Migration
  def change
    change_table :videos do |t|
      t.references :genre
      t.timestamps
    end
  end
end
