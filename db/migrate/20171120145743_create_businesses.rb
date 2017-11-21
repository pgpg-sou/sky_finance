class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :category
      t.string :sub_category_1
      t.string :sub_category_2
      t.string :city
      t.string :state
      t.string :phone
      t.string :mobile
      t.string :fax
      t.string :website
      t.string :email
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :facebook_page
      t.string :twitter_page

      t.timestamps null: false
    end
  end
end
