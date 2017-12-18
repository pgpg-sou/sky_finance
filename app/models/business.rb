class Business < ActiveRecord::Base
    geocoded_by :address, :latitude  => :latitude, :longitude => :longitude 
    after_validation :geocode, if: Proc.new { |a| a.address_changed? }

    def self.generate(row)
        business = Business.new
        business.name = row["Business Name"] 
        business.category = row["Business Category"] 
        business.sub_category_1 = row["Sub Category 1"] 
        business.sub_category_2 = row["Sub Category 2"] 
        business.address = ""
        business.city = row["City"] 
        business.state = row["State"] 
        business.phone = row["Phone"] 
        business.mobile = row["Mobile"] 
        business.fax = row["Fax"] 
        business.website = row["Website"] 
        business.email = row["Email"] 
        business.latitude = row["Latitude"].to_f 
        business.longitude = row["Longitude"].to_f
        business.facebook_page = row["Facebook Page"] 
        business.twitter_page = row["Twitter"] 

        return business
    end
    
end
