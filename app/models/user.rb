class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :resumes
  has_many :jobs

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    is_admin
  end


  #------- Collect -------
  has_many :collects
  has_many :participated_jobs, :through => :collects, :source => :job

  def is_member_of?(job)
    participated_jobs.include?(job)
  end

  def join_collect!(job)
    participated_jobs << job
  end

  def quit_collect!(job)  
    participated_jobs.delete(job)
  end


end
