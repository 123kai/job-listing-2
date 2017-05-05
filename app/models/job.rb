class Job < ApplicationRecord

  has_many :resumes
  #------- Collect ------
  has_many :collects
  has_many :members, through: :collects, source: :user

  has_many :job_relationships, dependent: :destroy
  has_many :applicants, through: :job_relationships, source: :user

  belongs_to :user

  scope :published, -> { where(is_hidden: false) }
  scope :recent, -> { order('created_at DESC') }
  scope :lower_wage, -> {order('wage_lower_bound DESC')}
  scope :upper_wage, -> {order('wage_upper_bound DESC')}

  validates :title, presence: true
  validates :company, presence: true
  validates :location, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0}

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end
end
