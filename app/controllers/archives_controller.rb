class ArchivesController < ApplicationController

	def new
		
	end	

	def save
		a = Archive.new
		a.caption = params["title"]
		a.save
		
	end	

    def import
	  uploaded_csv = params[:file]
      csv_text = File.read(uploaded_csv.path)
      csv = CSV.parse(csv_text, :headers => true)
    
      csv.each do |row|
      row_hash = row.to_hash

# extra
  
  #  row_hash["TmStamp"] 
   
#row_hash["WarII"] row_hash["WarI"] row_hash["War1812"] row_hash["CivilWar"] 
#row_hash["Handstamps"] row_hash["RWar"]

county = Array.new
county.append("Allegan") if row_hash["Allegan"] == "1"
county.append("Arenacn") if row_hash["Arenac"] == "1" 
county.append("Berrien") if row_hash["Berrien"]== "1"
county.append("Branch") if row_hash["Branch"]== "1"
county.append("Calhoun") if row_hash["Calhoun"]== "1"
county.append("Cass")  if row_hash["Cass"]== "1"
county.append("Gennessee") if row_hash["Gennessee"] == "1"
county.append("Gladwin") if row_hash["Gladwin"]== "1"
county.append("Gratiot") if row_hash["Gratiot"]== "1"
county.append("Hillsdale") if row_hash["Hillsdale"]== "1"
county.append("Ingham") if row_hash["Ingham"]== "1"
county.append("Ionia") if row_hash["Ionia"]== "1"
county.append("Isabella") if row_hash["Isabella"]== "1"
county.append("Jackson") if row_hash["JCounty"]== "1" 
county.append("Kalamazoo")if row_hash["KCounty"]== "1"  
county.append("Kent") if row_hash["Kent"] == "1"  
county.append("Lenawee") if row_hash["Lenawee"]== "1"  
county.append("Lapeer") if row_hash["Lapeer"] == "1"  
county.append("Livingston") if row_hash["Livingston"]== "1"  
county.append("Mackinac") if row_hash["Mackinac"] == "1"  
county.append("Macomb") if row_hash["Macomb"]== "1"  
county.append("Midland") if row_hash["Midland"] == "1"  
county.append("MonCounty") if row_hash["MonCounty"] == "1"  
county.append("Montcalm") if row_hash["Montcalm"] == "1"  
county.append("Oakland") if row_hash["Oakland"] == "1"  
county.append("Oceana") if row_hash["Oceana"] == "1"  
county.append("Ottawa") if row_hash["Ottawa"]== "1"  
county.append("Saginaw") if row_hash["Saginaw"] == "1"  
county.append("Saint Clair") if row_hash["StClair"] == "1"  
county.append("Saint Joseph") if row_hash["StJoseph"]== "1"  
county.append("Sanilac") if row_hash["Sanilac"] == "1"  
county.append("Shiwassee") if row_hash["Shiwassee"]== "1"  
county.append("VanBuren") if row_hash["VanBuren"]== "1"  
county.append("Washtenaw") if row_hash["Washtenaw"] == "1"    
county.append("Wayne") if row_hash["Wayne"]== "1"  

 

#city
city = Array.new
city.append("Adrian") if row_hash["Adrian"]=="1"
city.append("AnnArbor") if  row_hash["AnnArbor"] =="1"
city.append("BattleCreek") if row_hash["BattleCreek"]=="1"
city.append("Coldwater") if row_hash["Coldwater"]=="1"
city.append("Detroit") if  row_hash["Detroit"] =="1"
city.append("Dexter") if row_hash["Dexter"]=="1"
city.append("Flint") if row_hash["Flint"] =="1"
city.append("Jackson") if row_hash["Jackson"] =="1"
city.append("Kalamazoo") if row_hash["Kalamazoo"]=="1"
city.append("Monroe") if row_hash["Monroe"] =="1"
city.append("Niles") if row_hash["Niles"] =="1"
city.append("Tecumseh") if row_hash["Tecumseh"]=="1"
city.append("Ypsilanti") if row_hash["Ypsilanti"]=="1"

 #category
c = Array.new
c.append("19th Century Michigan Letters") if row_hash["NCent"] =="1"
c.append("20th Century") if row_hash["TCent"] =="1"
c.append("Michigan Advertising") if row_hash["Advertising"]=="1" 
c.append("American Home Missionary Society") if row_hash["AHMS"]=="1"
c.append("Black History") if row_hash["BHistory"] =="1"
c.append("Campbell Family Letters") if row_hash["Campbell"] =="1"
c.append("MI Covers") if row_hash["Covers"] =="1"
c.append("Ernie's Ann Arbor Broken Ring") if row_hash["Ring"]=="1"
c.append("Ernie's Michigan Collection") if row_hash["EC"] =="1"
c.append("MI Fancy Cancels") if row_hash["FancyCancels"]=="1" 
c.append("Letters to Foreign Destinations") if row_hash["FDest"] =="1"
c.append("MI Free Franks") if row_hash["FFranks"] =="1"
c.append("MI Genealogy") if row_hash["Geneology"] =="1"
c.append("German Language Letters") if row_hash["German"] =="1"
c.append("Ann Arbor Hampden Cancels") if row_hash["Hampden"] =="1"
c.append("Machine Cancels") if row_hash["MachCancels"] =="1"
c.append(" Manuscripts") if row_hash["Manuscript"] =="1"
c.append("Maps") if row_hash["Map"]  =="1"
c.append("Michigan Stampless Letters") if row_hash["EMiS"] =="1"
c.append("Michigan Territorial") if row_hash["EMiT"] =="1"
c.append("Northern Michigan") if row_hash["NMichigan"] =="1"
c.append("Ohio Toledo Strip Letters") if row_hash["OhioTStrip"] =="1"
c.append("MI Post Cards") if row_hash["PicPostCards"] =="1"
c.append("Railroads") if row_hash["RR"] =="1"
c.append("MI Waterways") if row_hash["Waterways"] =="1"
c.append("Stamps") if row_hash["Stamps"] =="1"
c.append("Wisconsin/Michigan Territory") if row_hash["Wisconsin"] =="1"
c.append("Women's Correspondence") if row_hash["Women"]=="1"
c.append("Thorp/Lybrook Family Letters") if row_hash["Thorp"] =="1"
c.append("Love Letters") if row_hash["LoveLetters"] =="1"
c.append("Leona & Frank Ohlhaussen Love Letters") if row_hash["Leona"]=="1"
c.append("Scott-10,11,25,26,26a") if row_hash["Scott10"]=="1"  
c.append("Michigan Territorial Exhibit") if row_hash["MTE"] =="1"
c.append("Michigan/Wisconsin Territory Exhibit") if row_hash["MWTE"]=="1"  
c.append("Detroit and Algonac Railway Post Office Exhibit") if row_hash["DARP"] =="1" 
c.append("Michigan Railway Post Offices 1871-1915 Exhibit") if row_hash["MRPO"] =="1"
c.append("Ransom Dunn") if row_hash["Ransom"]=="1"
c.append("Letters Containing Correspondence") if row_hash["LCC"] =="1"
c.append("Privately Owned") if row_hash["PO"] =="1"
c.append("Publicly Owned") if row_hash["PBO"] =="1"
c.append("Unusual Postage") if row_hash["Upostage"]=="1"

a = Archive.new
 count = 0
 while count <= county.count
    a.county = county[count] if count ==0
    a.county1 = county[count] if count ==1
    a.county2 = county[count] if count ==2
    a.county3 = county[count] if count ==3
	count = count+1
 end

 count = 0
 while count <= city.count
    a.city = city[count] if count ==0
    a.city1 = city[count] if count ==1
    a.city2 = city[count] if count ==2
    a.city3 = city[count] if count ==3
	count = count+1
 end

 count = 0
 while count <= c.count
    a.category = c[count] if count ==0
    a.category1 = c[count] if count ==1
    a.category2 = c[count] if count ==2
    a.category3 = c[count] if count ==3
    a.category4 = c[count] if count ==4
    a.category5 = c[count] if count ==5
    a.category6 = c[count] if count ==6
    a.category7 = c[count] if count ==7
    a.category8 = c[count] if count ==8
    a.category9 = c[count] if count ==9
    a.category10 = c[count] if count ==10
    a.category11 = c[count] if count == 11
    a.category12 = c[count] if count ==12
    a.category13 = c[count] if count ==13
    a.category14 = c[count] if count ==14
    a.category15 = c[count] if count == 15
    a.category16 = c[count] if count ==16
    a.category17 = c[count] if count ==17
    a.category18 = c[count] if count ==18
    a.category19 = c[count] if count ==19
    a.category20 = c[count] if count ==20
	count = count+1
 end
 #states
 a.state = "Indiana" if row_hash["Indiana"]=="1"
 a.options = "Exhibit" if row_hash["Exhibit"]=="1" 
 a.options1 = "Outgoing" if row_hash["Outgoing"]=="1"  

        a.fname = row_hash["Name"]
        a.pdate = row_hash["Rdate"]
        a.pic_status = row_hash["ShowPic"]
        a.caption = row_hash["Caption"]
        a.ptype = row_hash["Ptype"] 
        a.pyear = row_hash["Pyear"]
        a.path = row_hash["Ppath"]
        a.price = row_hash["Price"]
        a.cost = row_hash["Cost"]
        a.picval = row_hash["PicVal"]

     a.save! 
      end
    end
end
