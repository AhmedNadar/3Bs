class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.text :intro
      t.text :content

      t.timestamps null: false
    end
    add_index :posts, :slug, unique: true
  end
end
