class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :category
      t.string :title
      t.string :artist
      t.string :published
      t.string :description

      t.timestamps
    end
  end
end
