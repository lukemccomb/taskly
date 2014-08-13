class Task < ActiveRecord::Base
  belongs_to :task_list
  validates :name, presence: { message: "Your task could not be created"}
end
