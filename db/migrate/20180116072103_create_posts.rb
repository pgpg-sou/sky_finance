class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :data

      t.timestamps null: false
    end
  end
end
