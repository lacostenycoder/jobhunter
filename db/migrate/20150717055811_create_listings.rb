class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :description
      t.string :url
      t.string :data_id
      t.boolean :hide, null: false, default: false

      t.timestamps null: false
    end
  end
end
