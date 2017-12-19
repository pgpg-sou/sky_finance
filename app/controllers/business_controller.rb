class BusinessController < ApplicationController
    protect_from_forgery :except => [:search]
    def search
        name = params[:name]
        page_num = params[:page]
        businesses = Business.select(["id", "name", "address", "phone", "website", "email","category", "sub_category_1", "sub_category_2"]).where('name LIKE(?)', "%#{name}%").page(page_num).per(100)
        
        render json: businesses.to_json
    end
end
