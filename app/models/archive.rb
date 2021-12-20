class Archive < ApplicationRecord
   after_save :index_record
   before_destroy :remove_from_index

   attr_accessor :title, :county,:city,:category
   
	 def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |result|
        csv << result.attributes.values_at(*column_names)
      end
    end
  end

  def remove_from_index
  	conn = Blacklight.default_index.connection
    conn.delete_by_id self.id
	conn.commit
  end

  def index_record

  	conn = Blacklight.default_index.connection
  	doc = { 
			'id' => self.id,
			'item_id_ssi' => item_id ,
      		'title_ssi' => title,
      #        'fname' => fname
      #t.string :path
      		 'date_received_ssi' => date_received,
             'county_ssi' => county,
             'city_ssi' => city,
      		 'category_ssi' => category,
      		 'state_ssi' => state,
      		 'options_ssi' => options
      #sub_pages
      #t.string :cover_page
			
		}

	  conn.add doc
	  conn.commit			
    
    # SolrService.add(self.to_solr)
    # SolrService.commit
  end

  # def remove_from_index
  #   SolrService.delete_by_id(self.id)
  #   SolrService.commit
  # end

end
