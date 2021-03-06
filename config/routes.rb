Rails.application.routes.draw do

  get 'home/lpi_insurance'
  get 'home/gap_insurance'
  get 'home/vehicle_insurance'
  get 'home/break_down_insurance'


  get 'home/business_leasing'
  get 'home/business_finance'
  get 'home/personal_finance'
  get 'home/vehicle_finance'

  get 'business/search'
  post 'business/search'
  post 'home/application_saver'

  post 'home/upload_passport_file'
  post 'home/upload_file_visa'
  post 'home/upload_driver_licence_back'
  post 'home/upload_file'
  get 'home/index'

  get 'home/set_your_budget'

  get 'home/about_us'
  get 'home/how_it_works'
  get 'home/finance'
  
  get 'home/help_and_advice'
  get 'home/apply2'
  get 'home/apply3'
  get 'home/apply'
  get 'home/business_apply'
  get 'home/vehicle_apply'
  
  post 'home/apply_mail'

  root :to => 'home#index' 

end
