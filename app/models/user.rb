class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :resumes
  has_many :jobs

  #------- Collect -------
  has_many :collects
  has_many :participated_jobs, :through => :collects, :source => :job

  has_many :job_relationships
  has_many :applied_jobs, through: :job_relationships, source: :job

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    is_admin
  end



  def is_member_of?(job)
    participated_jobs.include?(job)
  end

  def join_collect!(job)
    participated_jobs << job   # "<<" 加入array 
  end

  def quit_collect!(job)
    participated_jobs.delete(job)
  end

  def has_applied?(job)
    applied_jobs.include?(job)
  end

  def apply!(job)
    applied_jobs << job
  end

end
