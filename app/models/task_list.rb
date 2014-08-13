class TaskList < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  validates :name, presence: { message: "Your task list could not be created"}, uniqueness: { message: "Your task list could not be created"}
end