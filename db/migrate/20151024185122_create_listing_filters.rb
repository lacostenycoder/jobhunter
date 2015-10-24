class CreateListingFilters < ActiveRecord::Migration
  def change
    create_table :listing_filters do |t|
      t.string :css_selector
      t.string :text

      t.timestamps null: false
    end
  end
end
