class AddHideToKeyword < ActiveRecord::Migration
  def change
    add_column :keywords, :hide, :boolean, null: false, default: false
  end
end
