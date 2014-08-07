class Task < ActiveRecord::Base
  validates :name, presence: { message: "Your task could not be created"}
end