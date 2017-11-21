class BusinessController < ApplicationController
    protect_from_forgery :except => [:search]
    def search
        name = params[:name]
        page_num = params[:page]
        businesses = Business.select(["id", "name", "address", "phone"]).where('name LIKE(?)', "%#{name}%").page(page_num)
        
        render json: businesses.to_json
    end
end
