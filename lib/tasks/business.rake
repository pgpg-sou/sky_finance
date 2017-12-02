
require "csv"
require 'open-uri'

namespace :business do
    desc "businessのインポート"
    task import: :environment do
        #data = CSV.read("lib/csv/business.csv")
        businesses = Business.all

        businesses.each do |business|
            if business.latitude != 0.0
                r_address = geocording(business.latitude, business.longitude)
                business.address = r_address
                business.save 
            end
        end
        
        #keys = data[0]
        #data.delete_at(0)
        #data.each_with_index do |d, index|
        #    row = Hash[*[keys, d].transpose.flatten]
        #    business = Business.generate(row)
        #    
        #    if Business.exists?(name: business.name)
        #    else 
        #        business.save
        #    end
        #end
    end
end

def geocording(lat, lng)

    url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + lat.to_s + "," + lng.to_s + "&key=AIzaSyADN_0RRGIMxRj_arCl5Mjq-ccQMpZfmsE"
    #geo_result = Hash.new
    address_result = ""
    begin
        res = open(url)
        code, message = res.status 

        if code == '200'
            result = ActiveSupport::JSON.decode res.read
            address_result = result["results"][0]["formatted_address"]
            #result["results"][0]["address_components"].each_with_index do |address, index|
            #    if address["types"][0] == "country"
            #        geo_result["country"] = address["long_name"]
            #        geo_result["region"] = result["results"][0]["address_components"][index-1]["long_name"]
            #    end
            #end
        else
            geo_result["error"] = message
        end
        return address_result
    rescue Exception => e
        puts  e.class 
        puts  e.message
    end
end



