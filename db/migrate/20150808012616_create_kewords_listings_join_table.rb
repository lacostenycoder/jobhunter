class CreateKewordsListingsJoinTable < ActiveRecord::Migration
  def change
    create_table :keywords_listings, id: false do |t|
      t.integer :keyword_id
      t.integer :listing_id
    end

    add_index :keywords_listings, :keyword_id
    add_index :keywords_listings, :listing_id
  end
end
