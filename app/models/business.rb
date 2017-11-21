class Business < ActiveRecord::Base
    geocoded_by :address, :latitude  => :latitude, :longitude => :longitude 
    after_validation :geocode, if: Proc.new { |a| a.address_changed? }

    def self.generate(row)
        business = Business.new
        business.name = row["business_name"] 
        business.category = row["business_category"] 
        business.sub_category_1 = row["sub_category_1"] 
        business.sub_category_2 = row["sub_category_2"] 
        business.address = ""
        business.city = row["city"] 
        business.state = row["state"] 
        business.phone = row["phone"] 
        business.mobile = row["mobile"] 
        business.fax = row["fax"] 
        business.website = row["website"] 
        business.email = row["email"] 
        business.latitude = row["latitude"].to_f 
        business.longitude = row["longitude"].to_f
        business.facebook_page = row["facebook_page"] 
        business.twitter_page = row["twitter_page"] 

        return business
    end
    
end
