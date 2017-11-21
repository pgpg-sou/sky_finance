
require "csv"

namespace :business do
    desc "businessのインポート"
    task import: :environment do
        data = CSV.read("lib/csv/business.csv")

        keys = data[0]
        data.delete_at(0)
        data.each_with_index do |d, index|
            row = Hash[*[keys, d].transpose.flatten]
            business = Business.generate(row)
            
            if Business.exists?(name: business.name)
            else 
                business.save
            end
        end
    end
end
