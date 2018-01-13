Rails.application.routes.draw do

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
  
  get 'home/help_and_advice'
  get 'home/apply2'
  get 'home/apply3'
  get 'home/apply'
  get 'home/business_apply'
  get 'home/vehicle_apply'
  
  post 'home/apply_mail'

  root :to => 'home#index' 

end
