class ResumesController < ApplicationController
  before_action :authenticate_user!

def new
  @job = Job.find(params[:job_id])
  # @resume = Resume.new

  if current_user.admin?
    flash[:warning] = "Job application is not available for companies"
    redirect_to job_path(@job)
  end

  if !current_user.has_applied?(@job)
    @resume = Resume.new
  else
    flash[:warning] = "You have applied this job."
    redirect_to job_path(@job)
  end

end

def create
  @job = Job.find(params[:job_id])
  @resume = Resume.new(resume_params)
  @resume.job = @job
  @resume.user = current_user
  current_user.apply!(@job)

  if @resume.save
   flash[:notice] = "成功提交履历"
   redirect_to job_path(@job)
  else
   render :new
  end
end

private

def resume_params
  params.require(:resume).permit(:content, :attachment)
end

end
