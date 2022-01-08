class Archive < ApplicationRecord
   after_save :index_record
   before_destroy :remove_from_index

   attr_accessor :title, :county,:city,:category, :county1,:city1,:category1, :county2,:city2,:category2,
   :county3,:city3,:category3,:county4,:city4,:category4, :category5, :category6, :category7, :category8, :category9, :category10,
  :category11, :category12, :category13,:category14, :category15, :category16, :category17, :category18, :category19
   
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
      		'title_ssi' => caption,
          'pic_date_dtsi'=>pdate,
          'pic_year_ssi' =>pyear, 
      		 'date_received_ssi' => pdate,
             'county_ssi' => county,
             'county1_ssi' => county1,
             'county2_ssi' => county2,
             'county3_ssi' => county3,
             'county4_ssi' => county4,
             'county5_ssi' => county4,
             'city_ssi' => city,
             'city1_ssi' => city1,
             'city2_ssi' => city2,
             'city3_ssi' => city3,
             'city4_ssi' => city4,
      		 'category_ssi' => category,
           'category1_ssi' => category1,
           'category2_ssi' => category2,
           'category3_ssi' => category3,
           'category4_ssi' => category4,
           'category5_ssi' => category5,
           'category6_ssi' => category6,
           'category7_ssi' => category7,
           'category8_ssi' => category8,
           'category9_ssi' => category9,
           'category10_ssi' => category10,
           'category11_ssi' => category11,
           'category12_ssi' => category12,
           'category13_ssi' => category13,
           'category14_ssi' => category14,
           'category15_ssi' => category15,
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
