class HomeController < ApplicationController
  protect_from_forgery :except => [:apply_mail]

  def index
  end

  def set_your_budget
  end

  def about_us
      render :layout => 'other_page'
  end

  def how_it_works
      render :layout => 'other_page'
  end
 
  def help_and_advice
      render :layout => 'other_page'
  end
  
  def apply
      render :layout => 'other_page'
  end
  
  
  def apply_mail
      @application = params[:application].to_json
      NoticeMailer.contact_mail(@application).deliver

      personal = {'name' => 'Yamada'}
      render :json => personal
  end

end
