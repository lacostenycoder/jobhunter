class AddListingUniqueIndexToDatId < ActiveRecord::Migration
  def change
    add_index :listings, :data_id, :unique => true
  end
end
