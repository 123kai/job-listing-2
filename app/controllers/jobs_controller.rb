class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, :join_collect, :quit_collect]
  before_action :validate_search_key, only: [:search]

  def index

    @jobs = case params[:order]
      when 'by_lower_bound'
        Job.published.lower_wage.paginate(:page => params[:page], :per_page => 5)
      when 'by_upper_bound'
        Job.published.upper_wage.paginate(:page => params[:page], :per_page => 5)
      else
        Job.published.recent.paginate(:page => params[:page], :per_page => 5)
      end
  end

  def show
    @job = Job.find(params[:id])
   if @job.is_hidden
     flash[:warning] = "This Job already archieved"
     redirect_to root_path
   end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to jobs_path
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])

    @job.destroy

    redirect_to jobs_path
  end

#---------- Category --------

  def softengineer
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.where(:category => "softengineer").lower_wage.paginate(:page => params[:page], :per_page => 5)
    when 'by_upper_bound'
      Job.published.where(:category => "softengineer").upper_wage.paginate(:page => params[:page], :per_page => 5)
    else
      Job.published.where(:category => "softengineer").recent.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def dataanalyst
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.where(:category => "dataanalyst").lower_wage.paginate(:page => params[:page], :per_page => 5)
    when 'by_upper_bound'
      Job.published.where(:category => "dataanalyst").upper_wage.paginate(:page => params[:page], :per_page => 5)
    else
      Job.published.where(:category => "dataanalyst").recent.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def engineer
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.where(:category => "engineer").lower_wage.paginate(:page => params[:page], :per_page => 5)
    when 'by_upper_bound'
      Job.published.where(:category => "engineer").upper_wage.paginate(:page => params[:page], :per_page => 5)
    else
      Job.published.where(:category => "engineer").recent.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def business
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.where(:category => "business").lower_wage.paginate(:page => params[:page], :per_page => 5)
    when 'by_upper_bound'
      Job.published.where(:category => "business").upper_wage.paginate(:page => params[:page], :per_page => 5)
    else
      Job.published.where(:category => "business").recent.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def accounting
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.where(:category => "accounting").lower_wage.paginate(:page => params[:page], :per_page => 5)
    when 'by_upper_bound'
      Job.published.where(:category => "accounting").upper_wage.paginate(:page => params[:page], :per_page => 5)
    else
      Job.published.where(:category => "accounting").recent.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def writer
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.where(:category => "writer").lower_wage.paginate(:page => params[:page], :per_page => 5)
    when 'by_upper_bound'
      Job.published.where(:category => "writer").upper_wage.paginate(:page => params[:page], :per_page => 5)
    else
      Job.published.where(:category => "writer").recent.paginate(:page => params[:page], :per_page => 5)
    end
  end

#------------ Collect ------------
def join
   @job = Job.find(params[:id])

   if !current_user.is_member_of?(@job)
     current_user.join_collect!(@job)
   end

   redirect_to job_path(@job)
 end

 def quit
   @job = Job.find(params[:id])

   if current_user.is_member_of?(@job)
     current_user.quit_collect!(@job)  
   end

   redirect_to job_path(@job)
 end


#------------ Search -------------
  def search
    if @query_string.present?
      search_result = Job.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.paginate(:page => params[:page], :per_page => 20 )
    end
  end


  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end


  def search_criteria(query_string)
    { :title_cont => query_string }
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :company, :location, :category,
                                        :wage_upper_bound, :wage_lower_bound, :contact_email,:is_hidden)
  end


end
