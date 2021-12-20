class CreateArchives < ActiveRecord::Migration[6.1]
  def change
    create_table :archives do |t|
      t.string :item_id
      t.string :title	
      t.string :fname
      t.string :path
      t.string :date_received
      t.string :county
      t.string :city
      t.string :category
      t.string :state
      t.string :options
      t.string :sub_pages
      t.string :cover_page
      t.timestamps
    end
  end
end
