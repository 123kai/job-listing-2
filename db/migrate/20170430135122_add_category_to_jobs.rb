class AddCategoryToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :category, :string   
  end
end
