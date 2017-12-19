
require "csv"
require 'open-uri'

namespace :business do
    desc "businessのインポート"
    task import: :environment do
        puts "start import business...."
        data = CSV.read("lib/csv/new_zealand_business.csv")
        #businesses = Business.all

        #businesses.each do |business|
        #    if business.latitude != 0.0
        #        r_address = geocording(business.latitude, business.longitude)
        #        business.address = r_address
        #        business.save 
        #    end
        #end
        
        keys = data[0]
        data.delete_at(0)
        data.each_with_index do |d, index|
            row = Hash[*[keys, d].transpose.flatten]
            business = Business.generate(row)
            
            if Business.exists?(name: business.name)
            else 
                business.save
            end
            flush_progress_log(index, data.length)
        end
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

def flush_progress_log( index, max_size)
    progression_rate = ((index.to_f / max_size.to_f) * 100).to_i
    if index + 1 == max_size
        progression_rate = 100
    else
        progression_rate += 1
    end
    current_rate = (progression_rate).to_i 
    progress = 100 - current_rate
    str = "  #{progression_rate} %%  |" + "█" * current_rate + " " * progress + "| #{index+1} / #{max_size} " 
    printf "\e[#{str.length}D"
    STDOUT.flush    
    printf str
    sleep 0.001
    if index + 1 == max_size
        puts ""
    end
end



