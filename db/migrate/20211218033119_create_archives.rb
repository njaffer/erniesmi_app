class CreateArchives < ActiveRecord::Migration[6.1]
  def change
    create_table :archives do |t|
      t.string :caption	
      t.string :fname
      t.string :path
      t.string :pdate
      t.string :pyear
      t.string :county
      t.string :county1
      t.string :county2
      t.string :county3
      t.string :county4
      t.string :county5 
      t.string :county6
      t.string :county7
      t.string :county8
      t.string :county9
      t.string :county10            
      t.string :city
      t.string :city1
      t.string :city2
      t.string :city3
      t.string :city4
      t.string :city5  
      t.string :city6
      t.string :city7
      t.string :city8
      t.string :city9
      t.string :city10
      t.string :city11       
      t.string :category
      t.string :category1
      t.string :category2
      t.string :category3
      t.string :category4
      t.string :category5  
      t.string :category6
      t.string :category7
      t.string :category8
      t.string :category9
      t.string :category10 
      t.string :category11
      t.string :category12
      t.string :category13
      t.string :category14
      t.string :category15  
      t.string :category16
      t.string :category17
      t.string :category18
      t.string :category19
      t.string :category20           
      t.string :state
      t.string :state1
      t.string :state2
      t.string :state3
      t.string :state4
      t.string :state5
      t.string :state6      
      t.string :options
      t.string :options1
      t.string :options2
      t.float :cost
      t.float :price
      t.float :picval
      t.boolean :cover_page
      t.boolean :pic_status
      t.integer :ptype
      t.timestamps
    end
  end
end
