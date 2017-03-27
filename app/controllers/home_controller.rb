class HomeController < ApplicationController
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

end
