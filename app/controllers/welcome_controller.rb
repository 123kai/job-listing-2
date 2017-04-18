class WelcomeController < ApplicationController

  def index
    flash[:notice] = "SEEKING FOR A JOB"  
  end
end
