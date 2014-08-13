class ChangeTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :task_lists_id
    add_column :tasks, :task_list_id, :integer
  end
end
