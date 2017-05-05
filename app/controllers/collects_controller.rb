class CollectsController < ApplicationController
  def index
    @jobs = current_user.participated_jobs
  end

end
