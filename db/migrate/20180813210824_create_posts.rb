class CreatePosts < ActiveRecord::Migration[5.2]
  def change
      create_table :posts do |t|
        t.string :title
        t.text :content

        t.timestamps
      end
        add_index :posts,[:title], unique: true
    end
  end
